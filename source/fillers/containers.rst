.. include:: /fillers/links.rst

.. :code:`registry.gsc.wustl.edu/sleong/base-engineering`
..    A general environment for ACAG based on Intel compilers. It contains GEOS-Chem/GCHP dependencies, NetCDF operators, etc.

.. :code:`registry.gsc.wustl.edu/sleong/base-engineering-gcc`
..    A general environment for ACAG based on GNU compilers. It contains GEOS-Chem/GCHP dependencies, NetCDF operators, etc.

.. :code:`registry.gsc.wustl.edu/sleong/esm:intel-2021.1.2`
..    A general environment for ACAG based on Intel compilers. It contains GEOS-Chem/GCHP dependencies, NetCDF operators, etc.

:code:`1dandan/gchp-esmf8.0:latest`
   An environment with ESMF v8.0.0 to support compiling/running GCHP v13 simulations based on Intel compilers.

:code:`1dandan/gchp-esmf8.3:latest`
   An environment with ESMF v8.3.1 to support GCHP v14 simulations based on Intel compilers.

:code:`1dandan/gchp-esmf8.3:2023-04`
   An environment with ESMF v8.3.1 to support GCHP v14 simulations based on a newer version of Intel 2021.1.2 compilers.

.. :code:`yidant/gchp_env:14.2.0`
..    An environment with ESMF v8.4.2 to support GCHP v14 simulations based on GNU compilers. 

:code:`geoschem/gcpy:latest`
   Official GCPy container.

:code:`yidant/gchp_env:aws`
   An environment containing AWS CLI packages.

:code:`1dandan/netcdf-utils:latest`
   An environment with NetCDF Operators (NCO), Climate Data Operators (CDO), and utilities for regridding data (`gridspec`_ and `sparselt`_). Running the container requires activation by :code:`. /etc/bashrc`