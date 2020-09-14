
Submitting jobs
================

When you SSH into Compute1, you will land on a :term:`head node`. When you are on a head node you use :ref:`b-commands <b-commands>`
to interact with :term:`LSF`. LSF is the :term:`scheduling <scheduler>` software that runs on Compute1. The scheduler is
a system that manages the computing resources: it receives job submissions from users, it finds :term:`exec nodes` with the resources
to run each job, and then it starts those jobs running in isolated environments on the allocated exec nodes. Note that 
the system will delay starting a job if there currently aren't enough resources for the job.

This section describes the procedure for submitting a job on Compute1.

Create a job script
-------------------
In brief, a :term:`job script <job>` specifies three things:

1. the job's resource requirements (e.g., number of core, memory requirements, a time limit, etc.)
2. the job's configuration (e.g., whether or not the job is :term:`interactive <interactive job>`,
   the output log's file name, the :term:`container` in which to execute the job).
3. the commands that are  executed when the job lands on the exec node

Lets look at :code:`interactive.bsub` as an example:

.. code-block:: bash

   #!/bin/bash
   #BSUB -Is
   #BSUB -n 8
   #BSUB -R "rusage[mem=40000] span[hosts=1]"
   #BSUB -q rvmartin-interactive
   #BSUB -a 'docker(registry.gsc.wustl.edu/sleong/base-engineering)'

   cd /my-projects
   bash

The lines at the top, starting with :code:`#BSUB`, are specifying LSF options:

* :code:`-Is` tells LSF it is an interactive job
* :code:`-n 8` tells LSF the job needs 8 cores
* :code:`-R "rusage[mem=40000] span[hosts=1]"` tells LSF the job needs 40 GB of memory, and that all 8 cores should land on the same :term:`host` (exec node)
* :code:`-q rvmartin-interactive` tells LSF to add the job to the :code:`rvmartin-interactive` :term:`job queue <queue>`
* :code:`-a 'docker(registry.gsc.wustl.edu/sleong/base-engineering)'` tells LSF to launch the job in the :code:`registry.gsc.wustl.edu/sleong/base-engineering` :term:`container`

The other lines are the commands that are executed when the job lands on the exec node:

.. code-block:: bash

   cd /my-projects
   bash

This job changes to your :code:`project directory` and starts a bash terminal.

Submit with bsub
----------------

You submit a job to the scheduler with the :code:`bsub` command. This is done as follows

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ bsub < interactive.bsub

This submits the :code:`interactive.bsub` job to :code:`rvmartin-interactive` queue.