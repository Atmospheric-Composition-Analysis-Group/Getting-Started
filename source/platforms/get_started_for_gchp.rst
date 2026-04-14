.. include:: /fillers/links.rst
.. include:: /fillers/contacts.rst

Getting Started with GCHP on Various Platforms
===============================================

For general GCHP questions, please refer to the `GCHP official documentation`_.

As GCHP versions evolve, dependent libraries and environment settings may change. This documentation primarily covers GCHP v14.0.0 to v14.6.x.

The `GCHP operational run script examples`_ provide useful reference examples.

Compute1 (Docker-Based)
------------------------

To run GCHP on Compute1 across multiple nodes using MPI, specify the appropriate pre-built Intel compiler Docker image in your LSF script according to your GCHP version requirements.

:code:`1dandan/gchp-esmf8.0:latest`
   An environment with ESMF v8.0.0 to support compiling/running GCHP v13 simulations based on Intel compilers.

:code:`1dandan/gchp-esmf8.3:latest`
   An environment with ESMF v8.3.1 to support GCHP v14 (< 14.7) simulations based on Intel compilers.

:code:`yuanjian.z/gchp_env:latest`
   An environment with ESMF v8.6.1 to support GCHP v14 (>= 14.7) simulations based on Intel compilers.

**Important:** Starting with GCHP v14.3.0, the introduction of Cloud-J as a submodule requires manually setting stack memory to unlimited in a separate MPI-launched bash script. For details, see the related `GCHP pull request <https://github.com/geoschem/geos-chem/pull/2988>`_.

Compute2 (Module/Spack-Based)
------------------------------

To request access to Compute2, contact |aws-contact| at WashU.

On Compute2, load the required environment using either module or Spack instead of pre-built Docker images. Refer to the `GCHP operational run script examples`_ for specific commands and configurations.

AWS (Module/Spack-Based)
-------------------------

To get started with AWS, follow our :ref:`AWS Quick Start Guide <aws_quickstart>`.

Consult `AWSGuide`_ by `Laura Yang`_ for reference for picking up shared cluster maintained |technical-tools-contact|.

Also consult the `GCHP operational run script examples`_ for platform-specific setup instructions.
