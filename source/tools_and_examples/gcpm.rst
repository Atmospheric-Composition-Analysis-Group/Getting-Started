.. include:: /fillers/contacts.rst

GCPM: GEOS-Chem PM\ :sub:`2.5` Calculator
=========================================

`GCPM <https://github.com/yuanjianz/GCPM>`_ is a Python tool that calculates fine particulate
matter (PM\ :sub:`2.5`) mass concentrations from GEOS-Chem chemical transport model output. It
converts species volume mixing ratios (VMR) to mass concentrations in μg/m\ :sup:`3` and
aggregates them into PM\ :sub:`2.5` components.

See the `GCPM GitHub repository <https://github.com/yuanjianz/GCPM>`_ for full documentation
covering the calculation method, species categories, scheme variants, PM\ :sub:`2.5` size cuts,
optional species (HMS, INDIOL), the ALT1 surface diagnostic, and AOD calculation.

For help with GCPM, contact |technical-tools-contact|.

Quick start
-----------

Clone the repository:

.. code-block:: console

   $ git clone https://github.com/yuanjianz/GCPM.git

Basic usage:

.. code-block:: python

   from GCPM import AerosolCalculator

   calculator = AerosolCalculator(ds)        # schemes auto-detected from ds
   pm25 = calculator.calculate_mass('PM25')  # total PM2.5 (wet), in ug/m3

``calculate_mass`` accepts a single name or a list, and returns an ``xarray.Dataset`` whose
variables are prefixed ``AeroMassFine_*`` (units: μg/m\ :sup:`3`):

.. code-block:: python

   # Individual species and common groups
   out = calculator.calculate_mass(['SO4', 'SIA', 'POA', 'SOA', 'BC', 'Dust', 'SS'])

   # Dry (no hygroscopic growth) — dry is a runtime option, not a constructor flag
   pm25_dry = calculator.calculate_mass('PM25', dry=True)

AerosolCalculator parameters
----------------------------

.. code-block:: python

   calculator = AerosolCalculator(
       ds,                          # xarray Dataset read from GEOS-Chem diagnostic
       poa_scheme="auto",           # "auto" | "SVPOA" | "NVPOA"
       soa_scheme="auto",           # "auto" | "simple" | "complex"
       dust_scheme="auto",          # "auto" | "DEAD" | "L23"
       use_alt="auto",              # "auto" | True | False
       include_hms=False,           # Include HMS in SIA
       include_indiol=False,        # Include INDIOL in SOA
       growth_factors=None,         # Override dict, e.g. {"SIA": 1.05, "ORG": 1.02, "SS": 1.2}
       omoc_ratios=None,            # Override dict, e.g. {"POA": 1.6, "OPOA": 2.3}
   )

The ``"auto"`` defaults let GCPM pick a reasonable configuration by probing variable names in
the dataset, so most users don't need to set these explicitly:

* **poa_scheme** — Primary organic aerosol scheme. ``"auto"`` selects ``"SVPOA"`` (semi-volatile,
  POA1/POA2/OPOA1/OPOA2) if ``SpeciesConcVV_POA1`` is in the dataset, or ``"NVPOA"`` (non-volatile,
  OCPO/OCPI) if ``SpeciesConcVV_OCPI`` is present.
* **soa_scheme** — Secondary organic aerosol scheme. ``"auto"`` selects ``"complex"`` (volatility
  basis set: ASOA, TSOA, SOAIE, SOAGX, LVOCOA) if ``SpeciesConcVV_ASOA1`` is in the dataset, or
  ``"simple"`` (lumped SOAS) if ``SpeciesConcVV_SOAS`` is present.
* **dust_scheme** — Dust binning. ``"auto"`` selects ``"L23"`` (7-bin Kok et al. scheme) if
  ``SpeciesConcVV_DSTbin1`` is present, otherwise ``"DEAD"`` (4-bin DEAD scheme).
* **use_alt** — Whether to read ``SpeciesConcALT1_*`` fields (surface concentrations derived via
  dry deposition, available for secondary species only). ``"auto"`` enables this when ALT1 fields
  are present in the dataset. Pass ``True``/``False`` to force on/off.
* **include_hms** — Include hydroxymethanesulfonate (HMS) in SIA. Off by default because its
  classification as PM\ :sub:`2.5` depends on the analysis context.
* **include_indiol** — Include INDIOL (hydrolysis product of organonitrates) in SOA under the
  complex scheme. Off by default because current GEOS-Chem treatment likely overestimates
  isoprene-derived organic aerosol.
* **growth_factors** — Override hygroscopic growth factors per group (``SIA``, ``ORG``, ``SS``)
  for sensitivity analysis. Defaults are loaded from ``species_config.yaml``.
* **omoc_ratios** — Override OM/OC ratios per POA subtype (``POA``, ``OPOA``, ``SOA``). Defaults
  are loaded from ``species_config.yaml``.

A legacy ``AeroMassFine(ds, spcs, dry=False, **kwargs)`` wrapper is also available for backward
compatibility; extra keyword arguments are forwarded to ``AerosolCalculator``.
