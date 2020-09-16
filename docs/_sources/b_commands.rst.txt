
.. include:: /fillers/links.rst

.. _b-commands:

Useful b-commands
=================

The command-line programs that you use to interact with :term:`LSF` start with the letter "b": :code:`bsub`, :code:`bqueues`, :code:`bkill`, etc.
Hence, we refer to this group of commands as b-commands. This page lists some of the most useful b-commands.

For the complete documentation of all the b-commands, see the |lsf-command-reference|.

:code:`bjobs`
   Lists your active jobs. For example

   .. code-block:: none

      [liam.bindle@compute1-client-1 ~]$ bjobs
      JOBID   USER    STAT  QUEUE      FROM_HOST   EXEC_HOST   JOB_NAME   SUBMIT_TIME
      59060   liam.bi RUN   general-in compute1-cl 8*compute1- *#zsh;bash Feb 20 09:56

   Alternatively, you can use the :code:`-l <JOB_NUMBER>` option for more verbose output

   .. code-block:: none

      [liam.bindle@compute1-client-1 ~]$ bjobs -l 15691
      Job 15691, User liam.bindle, Project default, Application docker1, Job 
                     Group /liam.bindle/default, User Group , Status PEND, Queue rvmartin-interactive, Interactiv
                     e pseudo-terminal shell mode, Command <#!/bin/bash;#BSUB -
                     Is;#BSUB -n 24;#BSUB -R "rusage[mem=200000] span[hosts=1]"
                     ;#BSUB -q rvmartin-interactive;#j#BSUB -a 'docker(liambind
                     le/mypyenv)';##BSUB -a 'docker(registry.gsc.wustl.edu/sleo
                     ng/base-engineering)';#BSUB -a 'docker(registry.gsc.wustl.
                     edu/sleong/base-engineering-gcc)'; #source /init.rc;source
                     $HOME/compute1/compute-node.rc;cd /my-projects;zsh;#bash>
                     , Esub registry.gsc.wustl.edu/sleong/base-engineer
                     ing-gcc)>
      Wed Jan 15 08:29:47: Submitted from host compute1-client-1.ris.wustl.edu>, CWD
                     $HOME, 24 Task(s), Requested Resources ;
      PENDING REASONS:
      Not enough job slot(s): 25 hosts;

      RUNLIMIT                
      1440.0 min

      MEMLIMIT
      195.3 G 

      SCHEDULING PARAMETERS:
            r15s   r1m  r15m   ut      pg    io   ls    it    tmp    swp    mem
      loadSched   -     -     -     -       -     -    -     -     -      -      -  
      loadStop    -     -     -     -       -     -    -     -     -      -      -  

      RESOURCE REQUIREMENT DETAILS:
      Combined: select[(defined(docker)) && (type == any)] order[r15s:pg] rusage[mem
                     =200000.00] span[hosts=1]
      Effective: -

:code:`bkill`
   Kill one or more jobs. Pass this command the jobs that you want to kill. For example

   .. code-block:: none

      [liam.bindle@compute1-client-1 ~]$ bkill 59060
      Job <59060> is being terminated


:code:`bqueues`
   Check how much activity there is on the queues. For example,

   .. code-block:: none

      [liam.bindle@compute1-client-1 ~]$ bqueues
      QUEUE_NAME      PRIO STATUS          MAX JL/U JL/P JL/H NJOBS  PEND   RUN  SUSP 
      datatransfer     10  Open:Active       -    -    -    -     0     0     0     0
      general          10  Open:Active       -    -    -    -  3984   111  3873     0
      general-interac  10  Open:Active       -    -    -    -     3     0     3     0
      fitzp            10  Open:Active       -    -    -    -     0     0     0     0
      fitzp-interacti  10  Open:Active       -    -    -    -     0     0     0     0
      pathology        10  Open:Active       -    -    -    -     0     0     0     0
      pathology-inter  10  Open:Active       -    -    -    -     0     0     0     0
      rvmartin         10  Open:Active       -    -    -    -     0     0     0     0
      rvmartin-intera  10  Open:Active       -    -    -    -     0     0     0     0
      tychele          10  Open:Active       -    -    -    -     0     0     0     0
      tychele-interac  10  Open:Active       -    -    -    -     0     0     0     0
      irahall          10  Open:Active       -    -    -    -     0     0     0     0
      irahall-interac  10  Open:Active       -    -    -    -    16     0    16     0
      timley           10  Open:Active       -    -    -    -     0     0     0     0
      timley-interact  10  Open:Active       -    -    -    -     0     0     0     0

:code:`bhosts`
   Checks how much activity is on each exec node. Pass this command the queue that you want
   to check.

   .. code-block:: none

      [liam.bindle@compute1-client-1 ~]$ bhosts rvmartin
      HOST_NAME          STATUS       JL/U    MAX  NJOBS    RUN  SSUSP  USUSP    RSV 
      compute1-exec-10.r ok              -     36      0      0      0      0      0
      compute1-exec-11.r ok              -     36      0      0      0      0      0
      compute1-exec-12.r ok              -     36      0      0      0      0      0
      compute1-exec-13.r ok              -     36      0      0      0      0      0
      compute1-exec-14.r ok              -     36      0      0      0      0      0
      compute1-exec-15.r ok              -     36      0      0      0      0      0
      compute1-exec-16.r ok              -     36      0      0      0      0      0
      compute1-exec-17.r ok              -     36      0      0      0      0      0
      compute1-exec-18.r ok              -     36      0      0      0      0      0
      compute1-exec-19.r ok              -     36      0      0      0      0      0
      compute1-exec-20.r ok              -     36      0      0      0      0      0
      compute1-exec-21.r ok              -     36      0      0      0      0      0
      compute1-exec-22.r closed          -     36      0      0      0      0      0
      compute1-exec-23.r ok              -     36      0      0      0      0      0
      compute1-exec-24.r ok              -     36      0      0      0      0      0
      compute1-exec-25.r ok              -     36      0      0      0      0      0
      compute1-exec-26.r ok              -     36      0      0      0      0      0
      compute1-exec-27.r ok              -     36      0      0      0      0      0
      compute1-exec-28.r ok              -     36      0      0      0      0      0
      compute1-exec-29.r ok              -     36      0      0      0      0      0
      compute1-exec-3.ri closed          -      1      0      0      0      0      0
      compute1-exec-30.r ok              -     36      0      0      0      0      0
      compute1-exec-4.ri ok              -     36      0      0      0      0      0
      compute1-exec-5.ri ok              -     36      0      0      0      0      0
      compute1-exec-6.ri ok              -     36      0      0      0      0      0
      compute1-exec-7.ri ok              -     36      0      0      0      0      0
      compute1-exec-8.ri closed          -     36      0      0      0      0      0
      compute1-exec-9.ri ok              -     36      0      0      0      0      0      

:code:`bgadd`
   Creates a job group. For example

   .. code-block:: none

      [liam.bindle@compute1-client-1 ~]$ bgadd -L 30 /liam.bindle/test_group
      Job group  was added.

   In your job script, you specify the job's group with the :code:`-g` option. For example,
   to include a job in this group you would have the following line in your job script

   .. code-block:: bash

      #BSUB -g /liam.bindle/test_group