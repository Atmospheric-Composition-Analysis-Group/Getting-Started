.. include:: /fillers/links.rst

Log on to Compute1
==================
Once your :ref:`access request <access-request>` is approved, you should be able to :code:`ssh` in to
Compute1.

.. note::
   If you are on-campus you need to be on one of the following WiFi networks to access Compute1:

   .. include:: /fillers/compute1_wifis.rst

   If you are off-campus you need to be on one of the following VPNs to access Compute1:

   .. include:: /fillers/compute1_vpns.rst


Try to :code:`ssh` into Compute1

.. code-block:: console

   $ ssh wustlkey@compute1-client-1.ris.wustl.edu

A successful log in will look similar to this

.. code-block:: none

   You are connecting to RIS Compute services.
   Membership in a compute-* AD group is required.

   Users are responsible for acting in accordance with
   policies applicable to Washington University St. Louis.

   https://confluence.ris.wustl.edu/display/RSUM/RIS+Compute+%3A+User+Agreement
   Last login: Fri Sep 11 16:47:45 2020 from workstation.dhcp.wustl.edu
   [wustlkey@compute1-client-1 ~]$

If you get an error you will have to |ris-open-a-ticket| with RIS. They will be able to fix whatever 
problem is preventing you from logging on.

Once you can log on, you are ready to use Compute1!

