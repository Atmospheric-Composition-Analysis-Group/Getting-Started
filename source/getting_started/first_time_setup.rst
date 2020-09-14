.. include:: /fillers/contacts.rst

First time setup
================

.. note::

   This section uses terminology that you might not be familiar with. Please refer to the 
   :ref:`glossary <acag-glossary>` for definitions.

This section describes the steps to set up your environment on Compute1, so you can start using Compute1 effectively. 
By the end of this section you will have:

1. created :code:`~/lsf-conf.rc`, which configures some useful :term:`LSF` settings
2. configured :code:`bash` to automatically load :code:`~/lsf-conf.rc` when you log on to Compute1
3. created :code:`~/interactive.bsub`, which is a simple interactive job script

If you need help any any point in this section, please contact |compute1-getting-started-contact|.

Before proceeding, log on to Compute1 and make sure you are in your :code:`$HOME` directory.

.. code-block:: console

   $ ssh wustlkey@compute1-client-1.ris.wustl.edu

Create :code:`lsf-conf.rc`
--------------------------

Here, you are going to create :code:`lsf-conf.rc`. This file sets :term:`environment variables` that configure some
useful :term:`LSF` settings. Make sure you are logged on to Compute1 and in your :code:`$HOME` directory. 

Download our :code:`lsf-conf.rc` template

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ wget -q https://raw.githubusercontent.com/Atmospheric-Composition-Analysis-Group/compute1/master/lsf-conf.rc

Next, find your :term:`project directory`. Do this by listing the contents of :code:`/storage1/fs1/rvmartin/Active/`, and noting the directory that looks like
it is yours (it is most likely your WUSTL key).

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ ls /storage1/fs1/rvmartin/Active/

Now, open :code:`lsf-conf.rc`

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ vim lsf-conf.rc

and modify :code:`MY_PROJECTS_DIR` so that it points to your project directory (it needs to be the :term:`absolute path`).
Save :code:`~/lsf-conf.rc`. 

Now, you can load these setting like so

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ source lsf-conf.rc


.. note::

   :code:`MY_PROJECTS_DIR` is the only variable you need to modify in :code:`lsf-conf.rc`.

Auto-load LSF settings
----------------------

You are going to want to :code:`source lsf-conf.rc` everytime you log on to Compute1. Therefore, you can add some lines
to :code:`~/.bashrc` to do this automatically. Open :code:`~/.bashrc`

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ vim .bashrc

and add the following at the bottom

.. code-block:: bash

   # Source ~/lsf-conf.rc we land on a head node
   if $(hostname | grep -q "compute1-client"); then
       source $HOME/lsf-conf.rc
   fi

This snippet will automatically load your LSF settings when you log on to Compute1.

Now, check that your LSF settings are being auto-loaded properly. To do this, log off and then
log back in (this is to trigger the automatic-loading of your LSF settings).

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ exit
   $ ssh wustlkey@compute1-client-1.ris.wustl.edu
   [wustlkey@compute1-client-1 ~]$ 

Then check that :code:`MY_PROJECTS_DIR` was automatically set.

.. code-block:: console

   [wustlkey.bindle@compute1-client-1 ~]$ echo $MY_PROJECTS_DIR 
   /storage1/fs1/rvmartin/Active/wustlkey

Download starter job
--------------------

Lastly, download :code:`interactive.bsub`. This is a basic :term:`interactive job` script. In the future, you can expand on it as you need,
but in the next section we will use it to get familiar with Compute1.

.. code-block:: console

   [wustlkey@compute1-client-1 ~]$ wget -q https://raw.githubusercontent.com/Atmospheric-Composition-Analysis-Group/compute1/master/interactive.bsub
