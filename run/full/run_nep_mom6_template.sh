#!/bin/bash
#SBATCH --ntasks=812
#SBATCH --clusters=c4
#SBATCH --job-name=nep
#SBATCH --time=720

y=<RUN_YEAR>


if (( $y == 1980 )) ; then
	r="n" 
        rm -f INPUT/MOM.res.nc
        rm -f INPUT/coupler.res
        rm -f INPUT/ice_model.res.nc	
else
	r="r"
	cp RESTART/MOM.res.nc INPUT/
        cp RESTART/coupler.res INPUT/
        cp RESTART/ice_model.res.nc INPUT/
fi

mr=12; dr=0; hr=0; m=1; d=1; h=0

rm INPUT/obcs.nc
ln -s /lustre/f2/scratch/gfdl/Liz.Drenkard/NEP_input/obcs/nep_10km_obcs_$y.nc INPUT/obcs.nc

cat MOM_input.template | sed -e "s/<YEAR>/$y/g" -e "s/<SPONGE>/False/g" > MOM_input
cat data_table.template | sed -e "s/<YEAR>/$y/g" > data_table
cat MOM_override.template | sed -e "s/<YEAR>/$y/g" > MOM_override
cat input.nml.template | sed -e "s/<RESTART>/$r/g" -e "s/<MONTH_RUN>/$mr/g" -e "s/<DAY_RUN>/$dr/g" -e "s/<HR_RUN>/$hr/g" -e "s/<YEAR>/$y/g" -e "s/<MONTH>/$m/g" -e "s/<DAY>/$d/g" -e "s/<HOUR>/$h/g" -e "s/<ICE>/true/g"> input.nml

# run one year
srun ./MOM6

# if run completed, save duplicates of restarts
# otherwise, exit
if [ $? -eq 0 ]; then
   rm -rf restarts_$y	
   cp -r RESTART restarts_$y
   cp MOM_IC.nc restarts_$y
   ./relaunch.sh "$((y+1))"
else
   exit 1
fi

