.. include:: /fillers/contacts.rst
.. include:: /fillers/links.rst

Get access to Compute1
======================

Compute1 is the cluster we use for most of our computing work. Compute1 is located here at WashU,
and is administered by Research Infrastructure Services (RIS).

If you need help getting set up on Compute1, or if you notice something on this page is out of date,
please contact |compute1-getting-started-contact|.

Set up VPN access
-----------------
To access Compute1 from off-campus, you will need to use a VPN. Instructions for accessing
the WashU VPNs can be found here: |vpn-instructions|. For help with the VPNs you should contact
|vpn-contact|.

.. note::
   WashU has several VPNs. Compute1 can be accessed from the following VPNs:

   .. include:: /fillers/compute1_vpns.rst


.. _access-request:

Request access
--------------

To get access to Compute1 you need to submit the following: `Compute1 Access Request`_. To submit
this form from off-campus, you might have to be on the VPN to submit this form.

You can copy-paste these into the form:

:Summary: Request for access to Compute1

:Description: Please add to the "storage-rvmartin" and "compute-rvmartin" groups.

:Storage Allocation: rvmartin_active

:WUSTL Key List: <Your WUSTL Key>

:CC: Randall Martin

.. note::
   This request may take RIS several days to process.


Log on to Compute1
------------------
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