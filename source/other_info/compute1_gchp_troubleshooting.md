# GCHP Tips on Compute1 

This page has tips for diagnosing GCHP crashes that were caused by Compute1 system errors, and steps you can take to improve the 
robustness of your simulations.

## Common Compute1 Errors That Will Crash Your Simulation

There are two common errors on Compute1 that can crash GCHP simulations, even if the simulation is totally valid. In most case restarting/resuming your simulation will work. However, if you're running many simulations in parallel, these reliability issues can turn into a major headache. This page has tips for improving the robustness of GCHP simulations on Compute1, and remediation steps for crashes.

The two common transient (random/irregular) errors are:
1. MPI initialization errors
2. Runtime read (i/o) errors


### MPI Initialization errors

#### Identification
MPI initialization errors are identified by a message at the top of the log file similar to 

```
--------------------------------------------------------------------------
A system call failed during shared memory initialization that should
not have.  It is likely that your MPI job will now either abort or
experience performance degradation.

  Local host:  compute1-exec-21.ris.wustl.edu
  System call: open(2)
  Error:       Permission denied (errno 13)
--------------------------------------------------------------------------
[compute1-exec-21.ris.wustl.edu:00116] 179 more processes have sent help message help-opal-shmem-mmap.txt / sys call fail
[compute1-exec-21.ris.wustl.edu:00116] Set MCA parameter "orte_base_help_aggregate" to 0 to see all help / error messages
```

This indicates a configuration error on RIS' end. Unfortunately, there isn't much we can do on our end beside report the offending host and job to RIS.

#### Remediation
Report the job number and hostname to RIS.

### Runtime read (i/o) errors

#### Identification
These can be identified by a crash mid-simulation in the RUN stage of EXTDATA. You might see strings like 
```
	pe=00199 FAIL at line=00256    FileMetadata.F90   <can not find time>
	Log file 1: pe=00452 FAIL at line=01844    MAPL_Generic.F90                         <Error during the 'Run' stage of the gridded component 'EXTDATA'>
```
or 
```
nf90_open: returned error code (-51) opening ./MetDir/2018/11/MERRA2.20181122.A1.05x0625.nc4 [NetCDF: Unknown file format
```
in the stack trace (the long list of error messages printed when the simulation crashes).

#### Remediation
I wrote [nf90_open_with_retries](https://github.com/LiamBindle/nf90_open_with_retries) as a workaround for this. The usage is described [here](https://github.com/LiamBindle/nf90_open_with_retries/blob/master/README.md).

This won't catch every error, but it should help quite a bit. This is also a safe zero-diff update. You can replace any `nf90_open()` call with `nf90_open_with_retries()` (see the stack trace to find where the error originated and replace the netcdf open call).

The steps to implement it are:
1. Go to the  `src/MAPL/pfio`  directory in your source code.
2. Download this file to the directory: https://raw.githubusercontent.com/LiamBindle/nf90_open_with_retries/master/nf_retry.f90
3. Edit `CMakeLists.txt`. Add `nf_retries.f90` to the `set(srcs ...)` call (it's near line 13).
4. Edit `NetCDF4_FileFormatter.F90`. Replace `nf90_open()` calls with `nf90_open_with_retries()`: near the top add `use nf_retries` where there are other `use` statements (near line 7), and near line 245 replace `nf90_open(...)` with `nf90_open_with_retries(...)`.
5. Recompile GCHP
6. Add a file called `nf_retry.nml` to your run directory. You can download a example file here: https://raw.githubusercontent.com/LiamBindle/nf90_open_with_retries/master/nf_retry.nml. This file configures the retry behaviour. To catch all NetCDF errors, set `nf_retry_catch_all=T` (useful for your first run with retries so you can see what errors are caught). If you want to catch specific errors only (e.g., -51 which is the error code that storage1 I/O errors show up as), you can set them like so `nf_retry_catch=-51,-52`. You might also want to tweak the `nf_retry_wait` (e.g., wait 5 seconds between attempts) and `nf_retry_max_tries` (e.g., retry up to 500 times).

If you experience NetCDF read errors elsewhere in the code (i.e., not in `NetCDF4_FileFormatter.F90`) you can repeat step 4 (and 5) in the appropriate file.

## How to Automatically Requeue & Restart a Simulation

There is a script in `/storage1/fs1/rvmartin/Active/Shared` called `configure-autorun-until-checkpoint-exists`.  Review the instructions at the top of this file for instructions on how to set up automatically requeuing/restarting GCHP simulations. It's important you use these with caution because your simulation will restart forever until the DONE criteria is reached. If the DONE criteria is never reached, your job will run forever (e.g., you have an actual error in one of your config files). You can always kill a job with `bkill JOBNUMBER` though.

## Running GCHP Simulations with Mixed Chipsets

### Selecting Same Chipset

Running GCHP simulations with same chipset can help speed up the stage of ExtData Initialization (reading external files), which can be achieved by:

1. Selecting old hosts (72 cores per node): \
`#BSUB -R 'select[model==Intel_Xeon_Gold6154CPU300GHz]'`

2. Selecting new hosts (64 cores per node): \
`#BSUB -R 'select[model==Intel_Xeon_Gold6242CPU280GHz]'`

Note: The performance of old/new nodes is comparable in terms of running GCHP simulations

### Running GCHP on Mixed chipsets

The problem of long-time stuck on the stage of ExtData Initialization can be fixed by:

1. Add MPI platform of skx. \
Specifically, add line of: `export I_MPI_PLATFORM=skx` in your `lsf-conf.rc` file on `$HOME` directory; and
2. Specify running nodes starting with old chipset first (the one with 72 cores per node). \
This can be done by using the `bsub-m-list.sh` in the `/Shared` directory. \
Specific usage is:
   ```
   bsub -m "$(/storage1/fs1/rvmartin/Active/Shared/bsub-m-list.sh)" < $your_bsub_scripts
   ```