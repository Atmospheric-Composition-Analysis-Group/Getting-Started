.. include:: /fillers/links.rst

.. include:: /fillers/contacts.rst

For Rotation Students
=====================
Depending on the project, you may want to make maps, scatter plots, or animations using Python or MatLab. Below are some example scripts. You can run your scripts on your local machine or :ref:`on Compute1 <running-scripts-on-compute1>` .
For help, contact any current doctoral students. 

Example Python scripts
----------------------
You are encouraged to read the `Python Data Science Handbook <https://jakevdp.github.io/PythonDataScienceHandbook/index.html>`_ if you are new to python. 
Commonly used python libraries inlcude `xarray <https://docs.xarray.dev/en/stable/>`_, `pandas <https://pandas.pydata.org/>`_, `numpy <https://numpy.org/>`_, `matplotlib <https://matplotlib.org/>`_ and `cartopy <https://scitools.org.uk/cartopy/docs/latest/>`_.  

Script to make a map from GCHP output:

.. code-block:: python

    #!/usr/bin/env python3
    # -*- coding: utf-8 -*-
    """
    Created on Thu Feb 16 13:02:46 2023
    @author: yanyu
    edited: Haihui 
    """

    import matplotlib.pyplot as plt
    import cartopy.crs as ccrs  # cartopy version must be >=0.19
    import xarray as xr
    import cartopy.feature as cfeature
    import calendar


    InDir = 'your/input/file/name'
    OutDir = 'your/output/file/name'

    for mon in range(1,13):
        ds = xr.open_dataset(InDir + 'your_file_name_{}.nc'.format(mon))  

        plt.style.use('default')
        plt.figure(figsize=(5, 3))
        left = 0.1   # Adjust the left position as needed
        bottom = 0.2   # Adjust the bottom position as needed
        width = 0.8   # Adjust the width as needed
        height = 0.8   # Adjust the height as needed
        ax = plt.axes([left, bottom, width, height], projection=ccrs.Miller())
        ax.coastlines()
        ax.set_global()
        ax.add_feature(cfeature.BORDERS)
        
        ax.set_extent([-140, 160, -60, 60], crs=ccrs.PlateCarree())# World map without Arctic and Antarctic region

        for face in range(6):
            x = ds.corner_lons.isel(nf=face)
            y = ds.corner_lats.isel(nf=face)
            v = ds.PM25.isel(nf=face) #Change species as needed
            im = ax.pcolormesh(x, y, v, transform=ccrs.PlateCarree(), vmin=0, vmax=100)

        month_str = calendar.month_name[mon]
        ax.text(0.45, 0.1, '{}'.format(month_str), fontsize=10, transform=ax.transAxes)  
        
        plt.title('figure title')
        plt.colorbar(im,label="$PM_{2.5}$ concentrations (\u03bcg/m$\mathregular{^3}$)", orientation="horizontal", pad=0.01, fraction=0.040)
        plt.savefig(OutDir + 'Your_figure_name_{}.png'.format(mon), dpi=500)
        plt.show()



Script to make scatter plots:

.. code-block:: python

    #!/usr/bin/env python3
    # -*- coding: utf-8 -*-
    """
    Created on Thu Feb 16 16:41:56 2023

    @author: yanyu
    edited: Haihui 
    """
    import numpy as np
    import matplotlib.pyplot as plt
    import pandas as pd
    import seaborn as sns
    from scipy import stats, odr

    InDir = 'Your/input/path'
    OutDir = 'Yout/output/path'

    species = pd.Series(['PM25', 'SO4', 'NIT', 'NH4'])
    compr = pd.read_csv(InDir + 'Your_file_name.csv')

    site = compr.site
    PM25=compr.PM25
    SO4=compr.SO4
    NIT=compr.NIT
    NH4=compr.NH4
    PM25_sim=compr.PM25_sim
    SO4_sim=compr.SO4_sim
    NIT_sim=compr.NIT_sim
    NH4_sim=compr.NH4_sim

    fig, ax = plt.subplots(figsize=(5, 5))

    unique_species = species.unique()
    palette = sns.color_palette('Paired', len(unique_species))
    color_dict = dict(zip(unique_species, palette))
    colors = [color_dict[s] for s in species]
        
    plt.scatter(PM25,PM25_sim,s=10, label=r'PM$_{2.5}$', c=colors[0])
    plt.scatter(SO4,SO4_sim,s=10, label='Sulfate',  c=colors[1])
    plt.scatter(NIT,NIT_sim,s=10, label='Nitrate',  c=colors[2])
    plt.scatter(NH4,NH4_sim,s=10, label='Ammonium',  c=colors[3])

    plt.grid(True, alpha=0.2)

    # Add the legend
    font_legend = {'family': 'Arial', 'size': 10}
    plt.legend(loc='lower right', prop=font_legend, frameon=False)
        
    x = PM25 #Observation
    y = PM25_sim #Simulation

    data = odr.Data(x, y)
    odr_obj = odr.ODR(data, odr.unilinear)
    output = odr_obj.run()
    slope = output.beta[0]
    offset = output.beta[1]
    rsq = (stats.linregress(x, y)[2]) ** 2
    plt.plot(np.linspace(0, max(y)+10), slope*np.linspace(0, max(y)+10)+offset,
            linestyle='-', color='black')
    plt.plot([0, max(y)+13], [0, max(y)+13], color='black', linestyle='--')

    if offset > 0:
        t = plt.text(0.02, 0.98, r'$y = {:.2f} x + {:.2f}$''\n''$R^2 = {:.2f}$''\n'.format(slope, offset, rsq)
                        + r'$N$' + f' = {len(x)}', transform=ax.transAxes, va='top', fontsize=10)
    else:
        t = plt.text(0.02, 0.98, r'$y = {:.2f} x {:.2f}$''\n''$R^2 = {:.2f}$''\n'.format(slope, offset, rsq)
                        + r'$N$' + f' = {len(x)}', transform=ax.transAxes, va='top', fontsize=10)

    font = {'fontname': 'Arial'}
    plt.xlabel('Observed  (\u03bcg/m$\mathregular{^3}$)', fontsize=10, fontdict=font)
    plt.ylabel('Simulated  (\u03bcg/m$\mathregular{^3}$)', fontsize=10, fontdict=font)

    ax.set_xlim(left=0, right=max(y)+13)
    ax.set_ylim(bottom=0, top=max(y)+13)   
    ax.set_xticks(np.arange(0, max(y)+13, 10))
    ax.set_yticks(np.arange(0, max(y)+13, 10))
    plt.savefig(OutDir + 'Your_figure_name.png', dpi = 500)
    plt.show()




Example MatLab scripts
----------------------
Matlab provides many powerful toolboxes and built-in functions, which are well documented on its `website <https://www.mathworks.com/products.html?s_tid=gn_ps>`_. You can also use the :code:`help` function to look up the definition and examples of a built-in function. 
For example, type :code:`help interp2` in your command window to learn about the `interp2 <https://www.mathworks.com/help/matlab/ref/interp2.html?s_tid=srchtitle_interp2_1>`_ funciton, which is commonly used for mapping.

Example script to make maps:

.. code-block:: MatLab

    clear % clear variables in workspace, comment out if you don't want to do so
    close all % close all figure windows, comment out if you don't want to do so

    SimYear = 2019;
    InDir = 'Your/Input/Dir';
    
    for Mon = 1:12
    fname = sprintf('%s/your_file_name_%d%.2d.mat',InDir,SimYear,Mon);
    load (fname,'mapdata_PM25','mapdata_AOD','lat','lon')
    
    figure('WindowState','maximized');

    % sub figure 1
    spec = 'PM2.5'; units = '\mug/m^3'; rng = [0 80];
    Label = 'PM_{2.5}';
    make_submap(1,mapdata_PM25,lat,lon,spec,rng,units,Label);

    % sub figure 2
    spec = 'AOD'; units = 'unitless'; rng = [0 0.8];
    Label = 'AOD';
    make_submap(2,mapdata_AOD,lat,lon,spec,rng,units,Label);
    
    % sub figure 3
    spec = 'ETA'; units = '\mug/m^3'; rng = [0 300];
    Label = '\eta';
    mapdata = mapdata_PM25./mapdata_AOD; 
    make_submap(3,mapdata,lat,lon,spec,rng,units,Label);
    
    % Save figure
    saveas(gcf,sprintf('%s/your_figure_name_%d%.2d.png',SaveDir,SimYear,Mon))


    % below is a user-built function called in the previous codes:

    function map = make_submap(Position,mapdata,lat,lon,spec,rng,units,Label)

        fz = 14; % define font size

        subplot(3,1,Position)
        map = worldmap([-50 60],[-150 160]); 
        surfm(lat, lon, mapdata);
        setm(gca,'Grid','off','MapProjection','miller','parallellabel','off','meridianlabel','off')
        load coastlines
        plotm(coastlat,coastlon,'k')

        % define a color scheme if you don't want to use the default one
        cm = flip(cbrewer('div','RdYlBu',12,'spline'));
        colormap(gca,map);
        set(gca,'clim',rng);

        % adding color bar
        cb1=colorbar('vertical', 'fontsize',fz, 'fontweight', 'bold','Ticks',rng(1):(rng(2)-rng(1))/4:rng(2));
        colorbar_label = sprintf('%s (%s)',spec,units);
        set(get(cb1,'YLabel'),'string',colorbar_label,'fontsize',fz,'fontweight','bold','FontName','Helvetica');
        
        % adding label to the figure
        text(max(xlim)-0.1*(max(xlim)-min(xlim)), min(ylim)+0.1*(max(ylim)-min(ylim)),...
                Region,'fontsize',fz,'fontweight','bold','Horiz','right', 'Vert','bottom');
    end





.. _running-scripts-on-compute1:

Running your scripts on Compute1
--------------------------------

You can run your python scripts on compute1 interactively or on the background by submitting an interactive or batch job using the :code:`geoschem/gcpy:latest` docker. 

To run MatLab on Compute1, refer to :ref:`Using MatLab <using-matlab>`