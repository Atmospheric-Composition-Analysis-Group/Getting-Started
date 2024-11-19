.. include:: /fillers/contacts.rst

.. _aws_quickstart:

AWS Quickstart
=============================================

AWS offers a range of computing resources and becomes an additional option for our group. The services that we will primarily use are EC2 ParallelCluster, AWS storage(EBS, FSx and S3) and other network services. 
Using GCHP on AWS ParallelCluster is similar to using GCHP on any other HPC like Compute1. You will need to manage your own infrastructure, gaining access to scalable and dedicated compute resources.

For more information, refer to the GCHP documentation `Set up AWS ParallelCluster <https://gchp.readthedocs.io/en/latest/supplement/setting-up-aws-parallelcluster.html>`_. If you have any questions or notice outdated information on this page, please contact |aws-contact|. 


Request AWS Console Access and CLI Credentials
----------------------------------------------------

Before getting started, you'll need to request access to the AWS group account. Submit your request through `WashU ServiceNow <https://it.wustl.edu/items/servicenow/>`_. You can open the request under Existing Cloud Subscription Change. 

Include the following information in your request: 

:Summary: Request for console access and CLI credentials to AWS account

:Description: For AWS CLI credentials, access is required for EC2 ParallelCluster, AWS storage (EBS, FSx, and S3), and other network services.

:AWS Account: <AWS Group Account>

:WUSTL Key List: <Your WUSTL Key>

:CC: Randall Martin

Once you have console access, log in to AWS at https://connect.wustl.edu/awsconsole. 

With CLI credentials in place, you’re ready to proceed to the next step.


Install AWS CLI and AWS ParallelCluster
----------------------------------------------------

To continue, ensure you have both the AWS CLI and AWS ParallelCluster installed and configured.

1. **Install AWS CLI** 

Follow the official AWS CLI installation guide: `AWS CLI installation Guide <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>`_

2. **Configure AWS CLI**

After installation, configure the AWS CLI with your account credentials.

.. code-block:: console

   $ aws configure

:AWS Access Key ID: <Your CLI Credentials (Public Key)>
:AWS Secret Access Key: <Your CLI Credentials (Secret Key)>
:Default region name: us-east-1
:Default output format: None 

3. **Install AWS ParallelCluster with a specific version**

.. note::
If you're using an AMI created with AWS ParallelCluster 3.7.0, ensure you install the matching version. Check the `AMI list <https://github.com/yidant/GCHP-cloud/blob/main/aws/ami.md>`_ in advance. 

.. code-block:: console
    
    $ pip install aws-parallelcluster==3.7.0

Confirming the ParallelCluster version with: 

.. code-block:: console

    $ pcluster version

The output should display: 

.. code-block:: console
    
    { "version": "3.7.0" }


Create Key Pair
----------------------------------------------------

Now you can create your key pair using the AWS CLI:

.. code-block:: console
    
    $ aws ec2 create-key-pair --key-name <Your Key Name (Please include your name or wustl ID)> --query 'KeyMaterial' --output text > MyKeyPair.pem

Store your :code:`.pem` key in a secure location. It is only accessible at creation and cannot be recovered later. If you lose the private key, you will need to create a new key pair.

To :code:`ssh` into your parallelcluster later, adjust the permissions of your private key file:

.. code-block:: console

    chmod 400 MyKeyPair.pem


Create GCHP ParallelCluster
----------------------------------------------------

You will use the :code:`pcluster` command to performs actions such as creating a cluster, temporarily shutting it down, or destroying it. 

First, create a cluster configuration file by running the :code:`pcluster configure` command:

.. code-block:: console
    
    $ pcluster configure --config cluster-config.yaml

For information about configuring the pcluster, please refer to `GCHP documentation <https://gchp.readthedocs.io/en/latest/supplement/setting-up-aws-parallelcluster.html#create-your-aws-parallelcluster>`_ or `AWS documentation <https://docs.aws.amazon.com/parallelcluster/latest/ug/install-v3-configuring.html>`_

Alternatively, you can download a template:  

.. code-block:: console

    $ wget -q https://raw.githubusercontent.com/yidant/GCHP-cloud/refs/heads/main/template/pcluster-template.yaml

If you need to use large amount of cores, please refer to this `template <https://github.com/yidant/GCHP-cloud/blob/main/template/pcluster-multiAZ-nht-template.yaml>`_ to enable cross-AZs and disable hyperthreading. 

Make sure you have replaced the AMI ID and key pair with the ones you wish to use. The AMI list can be find here: https://github.com/yidant/GCHP-cloud/blob/main/aws/ami.md

Optionally, you may adjust settings like storage size (EBS volume), compute resources, and network configurations. For details on instance types, refer to `AWS Instance Types <https://aws.amazon.com/ec2/instance-types/>`_. 

When ready, run the :code:`pcluster create-cluster` command to create your parallelcluster.

.. code-block:: console

    $ pcluster create-cluster --cluster-name <your_pcluster_name> --cluster-configuration pcluster-template.yaml

It may take several minutes up to an hour for your cluster's status to update to :code:`CREATE_COMPLETE`. You can check the status of you cluster with the following command: 

.. code-block:: console

    $ pcluster describe-cluster --cluster-name <your_pcluster_name>

Once your cluster's status is :code:`CREATE_COMPLETE`, run the pcluster ssh command or ssh command.

.. code-block:: console

    $ ssh -i ~/<path_to_your_key_pair> ec2-user@<ip_address>


Running GCHP on ParallelCluster
----------------------------------------------------

Your cluster setup is complete, and you can use it like any other HPC. The home directory is your working directory, and :code:`/ExtData` is the shared data directory. 

To reduce costs, consider pausing your ParallelCluster instance when not in use. You can restart it anytime. If you decide to terminate the instances, remember that this will also delete your EBS volume (home directory) due to the default :code:`DeleteOnTermination` setting. You can disable this, but please ensure to delete any unnecessary resources to avoid ongoing costs.

AWS ParallelCluster supports Slurm schedulers, and your cluster is configured to use the Slurm scheduler. It might require the root permission to run Slurm commands or restart Slurm. Before you submit your job, you can start a shell as superuser by running :code:`sudo -s`. 
For examples of Slurm run scripts, see `GCHP runScriptSamples <https://github.com/geoschem/geos-chem/tree/main/run/GCHP/runScriptSamples>`_. 

