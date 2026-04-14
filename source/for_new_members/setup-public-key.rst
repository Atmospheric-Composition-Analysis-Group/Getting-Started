.. _setup_public_key:

Set Up SSH Public Key (Mac/Linux/WSL)
=====================================

Setting up SSH public key authentication lets you log in to Compute1 without
entering your password every time. This guide walks you through generating a
key pair, copying it to Compute1, and optionally creating an SSH alias so you
can connect with a short command.

By the end of this section, you will be able to log in with:

.. code-block:: console

   $ ssh compute1

Check for Existing Keys
-----------------------

Before generating a new SSH key, check if one already exists on your system:

.. code-block:: console

   $ ls -al ~/.ssh

If you see files named :code:`id_rsa` (private key) and :code:`id_rsa.pub`
(public key), you can skip ahead to :ref:`copy-public-key`.

Generate a New SSH Key Pair
---------------------------

To create a new SSH key pair, run:

.. code-block:: console

   $ ssh-keygen -t rsa -b 4096 -C "your_wustl_username@wustl.edu"

When prompted, press :code:`Enter` to accept the default file location
(:code:`~/.ssh/id_rsa`). You will also be prompted to set a passphrase; this
adds an extra layer of security, but you can press :code:`Enter` to leave it
empty.

.. _copy-public-key:

Copy the Public Key to Compute1
-------------------------------

Copy your public key to Compute1:

.. code-block:: console

   $ ssh-copy-id -i ~/.ssh/id_rsa.pub username@compute1-client-1.ris.wustl.edu

Replace :code:`username` with your actual WUSTL key. If you used a different
filename or path for your key, update :code:`~/.ssh/id_rsa.pub` accordingly.

Log In Using Your SSH Key
-------------------------

Once your public key is in the server's authorized keys, you can log in
without a password (unless you set a passphrase):

.. code-block:: console

   $ ssh your_username@compute1-client-1.ris.wustl.edu

Create an SSH Alias (Optional)
------------------------------

To connect with just :code:`ssh compute1`, add an alias to your SSH config.

Open (or create) :code:`~/.ssh/config`:

.. code-block:: console

   $ nano ~/.ssh/config

Add the following entry:

.. code-block:: none

   Host compute1
       HostName compute1-client-1.ris.wustl.edu
       User yourusername
       IdentityFile ~/.ssh/id_rsa

Fields:

* **Host**: the alias name (e.g., :code:`compute1`)
* **HostName**: the full server address (:code:`compute1-client-1.ris.wustl.edu`)
* **User**: your WUSTL key
* **IdentityFile**: the path to your SSH private key (:code:`~/.ssh/id_rsa`)

Save and exit (in nano, press :code:`CTRL + X`, then :code:`Y`, then
:code:`Enter`).

You can now connect using the alias:

.. code-block:: console

   $ ssh compute1

Troubleshooting
---------------

**Permissions.** Your :code:`~/.ssh` directory and its contents need strict
permissions. The private key should be :code:`600` and the public key
:code:`644`:

.. code-block:: console

   $ chmod 600 ~/.ssh/id_rsa
   $ chmod 644 ~/.ssh/id_rsa.pub

**SSH agent.** If you get a "Permission denied" error, make sure your SSH key
is added to the agent:

.. code-block:: console

   $ eval "$(ssh-agent -s)"
   $ ssh-add ~/.ssh/id_rsa

**Server SSH config.** Public key authentication must be enabled on the
remote server. This is usually controlled by :code:`PubkeyAuthentication yes`
in :code:`/etc/ssh/sshd_config`.

**Network.** Verify that no firewall or network issues are blocking your
access.
