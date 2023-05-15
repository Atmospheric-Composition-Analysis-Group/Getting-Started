:code:`registry.gsc.wustl.edu/sleong/base-engineering`
   A general environment for ACAG based on Intel compilers. It contains GEOS-Chem/GCHP dependencies, NetCDF operators, etc.

:code:`registry.gsc.wustl.edu/sleong/base-engineering-gcc`
   A general environment for ACAG based on GNU compilers. It contains GEOS-Chem/GCHP dependencies, NetCDF operators, etc.

:code:`registry.gsc.wustl.edu/sleong/esm:intel-2021.1.2`
   A general environment for ACAG based on Intel compilers. It contains GEOS-Chem/GCHP dependencies, NetCDF operators, etc.

:code:`1dandan/gchp-esmf8.3:latest`
   An environment with ESMF v8.3.1 to support GCHP v14 simulations on the top of :code:`registry.gsc.wustl.edu/sleong/base-engineering`.

:code:`1dandan/gchp-esmf8.3:2023-04`
   An environment with ESMF v8.3.1 to support GCHP v14 simulations on the top of :code:`registry.gsc.wustl.edu/sleong/esm:intel-2021.1.2`.

:code:`geoschem/gcpy:latest`
   Official GCPy container.

:code:`1dandan/netcdf-utils:latest`
   An environment with NetCDF Operators (NCO), Climate Data Operators (CDO), and utilities for regridding data (`gridspec`_, `sparselt`_). Running the container requires activation by :code:`. /etc/bashrc`