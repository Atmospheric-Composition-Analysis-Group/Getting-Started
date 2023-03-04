.. include:: /fillers/contacts.rst

.. _acag-glossary:

Terminology
===========
.. note::

   If the glossary is missing a term you don't understand, please contact |glossary-contact|.

.. glossary::
   :sorted:
   
   node
      Each physical machine (server) in the cluster is node. There are many nodes in the Compute1 cluster. There are two
      types of nodes on Compute1: :term:`head nodes <head node>`, and :term:`exec nodes`.

   head node
      When you SSH into Compute1 you will land on one of the head nodes. Head nodes are essentially the login servers for Compute1. These
      head nodes have names like :code:`compute1-client-3`.
      When you're on a head node you can interact with :term:`LSF` to submit jobs, kills :term:`jobs <job>`, see how much acticity is in each queue, etc.,
      and you can navigate around the filesystem and modify files. You should not run CPU-intensive things on a head node.

   exec nodes
      Your :term:`jobs <job>` run on exec nodes. Both :term:`interactive jobs <interactive job>`, and :term:`batch jobs <batch job>` are run on :term:`exec nodes`. 
      
   job
      A bash script that executes things. At the top of your job script, you specify resource requirements for 
      your job (e.g., how many cores, how much memory, a time-limit for the job, etc.) There are two types of jobs: :term:`interactive jobs <interactive job>`, and :term:`batch jobs <batch job>`

   interactive job
      A job in which you will be connected to a terminal on an exec node. These are typically used for development and light computations.
      In most cases, the job will terminate when you close the terminal.

   batch job
      A bash script which executes things. The job runs on the system and it's output is logged, but there is no interactive terminal.
      Batch jobs are used for computational work (e.g., a GEOS-Chem simulation). You should use batch jobs (rather than interactive jobs)
      whenever possible (it will save you time in the long-run).

   LSF
      LSF is the :term:`scheduler` that runs on Compute1. It is produced by IBM.

   scheduler
      The scheduler is the software that manages the cluster (Compute1). Specifically it manages the clusters resources. You submit your
      job to the scheduler, then the scheduler finds an exec node with available resources (sufficient to satisfy your job's requirements),
      allocates the necessary resources on that node for your job, and then starts your job running on that node. All jobs go through the 
      scheduler. Compute1 uses the :term:`LSF` scheduler produced by IBM.

   container
      Your job will run on an exec node inside a container. A container is a bundle of software. Our group has several containers with 
      software frequently used by our group, like compilers, NCO (NetCDF operators), and all the software that GEOS-Chem/GCHP needs.
      These containers are the mechanism that allows RIS to distribute a variety of software to different research groups on Compute1.
      Compute1 is based on Docker containers. You can build these yourself and there is plently of documentation online.

   slot
      A CPU core. 1 slot is 1 core on a CPU. 500 slots is 500 cores (which will be spread across multiple CPUs).

   host
      Same as a node. It is usually used to refer to a specific node, computer, or server. For example, the term localhost is commonly
      used to refer to laptop/computer at your fingertips.

   Compute1
      The HPC cluster (physically, the group of servers which we run computations on).

   Storage1
      The filesystem which we store our data on. It is connected to Compute1, but they are not the same thing.

   project directory
      This is **your** personal data directory on Storage1. Note that it is not :code:`$HOME`. Your
      project directory is in :code:`/storage1/fs1/rvmartin/Active/`, and it is most likely your
      WUSTL key. There is no size limit. This is for data that you don't need to share with others.
      Data that you need to share with others should go in the :term:`shared directory`. In your
      jobs, your project directory will be mounted to :code:`/my-projects`.

   shared directory
      This is a directory for sharing data between ACAG members. Everyone in ACAG has read/write permissions by default, but you 
      can restrict them with :code:`chmod`. There is no size limit. On :term:`Storage1` this directory is 
      :code:`/storage1/fs1/rvmartin/Active/Shared`. In your jobs, this directory will be mounted to :code:`/shared`.

   $HOME
      This is your home directory (alias: :code:`~`). You should not put data here. This directory is intended
      for configuration scripts, job scripts, etc. You can always get here by :code:`cd ~` or equivalently :code:`cd $HOME`.

   absolute path
      The full path to a file. Absolute paths start with :code:`/` followed by the entire path to the file. For example,
      :code:`/storage1/fs1/rvmartin/Active/wustlkey/project1/file1.txt` is an absolute path. If you were in the directory
      :code:`/storage1/fs1/rvmartin/Active/wustlkey` the relative path to the same file would be :code:`project1/file1.txt`.

   environment variables
      These are variables (in your terminal) which some programs (e.g., :term:`LSF`) use to configure various settings.

   queue
      The job queues on Compute1 are the locations that you can submit a job to. Our group can use the :code:`rvmartin`, 
      :code:`rvmartin-interactive`, :code:`general`, and :code:`general-interactive` queues. The number of available
      :term:`slots <slot>` in a queue can been seen with the :code:`bqueues` command. Interactive jobs must be 
      submitted to the interactive queues.

   ExtData
      This is the data repository for all GEOS-Chem data (e.g., metfields, HEMCO, etc.). In your
      job, this directory is mounted to :literal:`/ExtData`. On Storage1 this directory is located
      at :literal:`/storage1/fs1/rvmartin/Active/GEOS-Chem-shared/ExtData`. Note ExtData is an offical data repository for
      GEOS-Chem, so it is read-only. For custom emissions, you will have to put them elsewhere (the :term:`shared directory`
      would be a good place)

   mount
      To connect the directories between filesystems
