#!/bin/bash


# Working compile for MOM6-examples git version: 



MOM6_installdir=/lustre/f2/dev/gfdl/Liz.Drenkard/MOM6-examples
MOM6_rundir=/lustre/f2/dev/gfdl/Liz.Drenkard/MOM6-examples

FMS_dir=$MOM6_installdir/src/FMS

compile_fms=1
compile_mom=1

module unload PrgEnv-pathscale
module unload PrgEnv-pgi
module unload PrgEnv-intel
module unload PrgEnv-gnu
module unload PrgEnv-cray

module load PrgEnv-intel
module swap intel intel/19.0.5.281
module unload netcdf
module load cray-netcdf
module load cray-hdf5

module unload darshan

cd $MOM6_rundir

if [ $compile_fms == 1 ] ; then
    rm -rf build/intel/shared/repro/
    mkdir -p build/intel/shared/repro/
    cd build/intel/shared/repro/
    rm -f path_names
    $MOM6_rundir/src/mkmf/bin/list_paths $FMS_dir
    $MOM6_rundir/src/mkmf/bin/mkmf -t $MOM6_rundir/src/mkmf/templates/ncrc-intel.mk -p libfms.a -c "-Duse_libMPI -Duse_netCDF -DSPMD" path_names
    make NETCDF=3 REPRO=1 libfms.a -j 4
fi

cd $MOM6_rundir

if [ $compile_mom == 1 ] ; then

    rm -rf build/intel/ice_ocean_SIS2/repro/
    mkdir -p build/intel/ice_ocean_SIS2/repro/
    cd build/intel/ice_ocean_SIS2/repro/
    rm -f path_names

    $MOM6_rundir/src/mkmf/bin/list_paths -l $MOM6_installdir/src/MOM6/config_src/{infra/FMS1,memory/dynamic_symmetric,drivers/FMS_cap,external} $MOM6_installdir/src/MOM6/src/{*,*/*}/ $MOM6_installdir/src/{coupler,atmos_null,land_null,ice_param,icebergs,SIS2,FMS/coupler,FMS/include}/

    $MOM6_rundir/src/mkmf/bin/mkmf -t $MOM6_rundir/src/mkmf/templates/ncrc-intel.mk -o '-I../../shared/repro' -p 'MOM6 -L../../shared/repro -lfms' -c '-Duse_libMPI -Duse_netCDF -DSPMD -DUSE_LOG_DIAG_FIELD_INFO -D_USE_LEGACY_LAND_ -Duse_AM3_physics' path_names
    make NETCDF=3 REPRO=1 MOM6 -j 4
fi


