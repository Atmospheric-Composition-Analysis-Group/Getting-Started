.. _setup_public_key:

Instruction to set up public key (for Mac)

To set up SSH public key authentication on Linux, macOS, or Windows Subsystem for Linux (WSL), follow these steps to generate a key pair and configure it.

Goal to Achieve
-----------------------------------

Before generating a new SSH key, open Terminal and check if one already exists on your system:
.. code-block:: console
    $ ls -al ~/.ssh

We will create :code:`id_rsa` (private key) and :code:`id_rsa.pub` (public key) on your local home directory for your SSH connect to Compute1.
By the end of this section, you will be able to log on to Compute1 without entering your account number and password, just with:
.. code-block:: console
    $ ssh compute1

Generate a New SSH Key Pair
-------------------------------------
To create a new SSH key pair, run

.. code-block:: console
    $ ssh-keygen -t rsa -b 4096 -C "your_wustl_username@wustl.edu"

When prompted, you can press :code:`Enter` to accept the default file location (:code:`~/.ssh/id_rsa`). If you want to save the key to a different location, specify the path.

You'll also be prompted to set a passphrase. This adds an extra layer of security. You can press :code:`Enter` to leave it empty.

Copy the Public Key to the Remote Server
--------------------------------------

.. code-block:: console
    $ ssh-copy-id -i ~/.ssh/id_rsa.pub username@compute1-client-1.ris.wustl.edu

To manage your SSH keys, add the new key to the SSH agent:

- Replace :code:`username` with your actual username on Compute1.
- If you created your key pair with a different filename or path, replace :code:`~/.ssh/id_rsa.pub` with your actual public key path.

Login Using SSH Key
-----------------------------

Once your public key is in the remote server's authorized keys, you can log in without needing to enter your password (unless you set a passphrase for your key, in which case you'll need to enter that):

.. code-block:: console
    $ ssh your_username@compute1-client-1.ris.wustl.edu

So now this creates the public key ssh 

Troubleshooting
------------------------------
- **Permissions**: Make sure your `~/.ssh` directory and its contents have strict permissions set. Your private key should be `600`, and your public key should be `644`.
- chmod 600 ~/.ssh/id_rsa
- chmod 644 ~/.ssh/id_rsa.pub
- **SSH Config**: Ensure the SSH configuration on the remote server allows public key authentication. This is usually controlled in the `/etc/ssh/sshd_config` file with the directive `PubkeyAuthentication yes`.
- **Firewall and Connectivity**: Verify that there are no network issues or firewalls blocking your access.

### Creating an alias for existing SSH configuration

To create an alias named `compute1` for your existing SSH configuration, follow these steps:

Open the SSH configuration file in your home directory:

.. code-block:: console
    $ nano ~/.ssh/config

### Add the following entry to the configuration file:

.. code-block:: console
    Host compute1
        HostName compute1-client-1.ris.wustl.edu
        User yourusername
        IdentityFile ~/.ssh/id_rsa

- **Host**: The alias name you want to use (ex: `compute1`).
- **HostName**: The full server name or IP address (`compute1-client-1.ris.wustl.edu`).
- **yourusername**: Your username .
- **IdentityFile**: The path to your SSH key (`~/.ssh/id_rsa`).

Save the changes and exit the editor (in nano, press `CTRL + X`, then `Y`, and hit `Enter`).

### Use the Alias
Now you can connect to your server using the alias:

.. code-block:: console
    $ ssh compute1

This will automatically use the settings you've specified for the compute1 alias.

### Troubleshooting
If you get a "Permission denied" error, ensure your SSH key is added to the agent:

.. code-block:: console
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa   

