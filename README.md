# Shared repository for setting up and running MOM6-NEP

*The content and organizational structure herein are based on Andrew C. Ross's nwa-share repository*

## Demo Run

1. Download initial and boundary condition files. These can be found (temporarily) on the GFDL ftp site: ```ftp://ftp.gfdl.noaa.gov/pub/liz.drenkard/nep_files```
   - I will upload scripts for generating these files in the near future. Until then, I am happy to provide any additional initial condition files needed; the boundary conditions cover the entire SODA period.
2. Download JRA atmospheric forcing using ```wget -i run/demo/jra_urls.txt``` and place the files in ```run/demo/INPUT/```
The model will crash due to the long length of the comment attribute in the RLDS file. To fix, ```ncatted -O -a comment,rlds,d,, rlds_input4MIPs_atmosphericState_OMIP_MRI-JRA55-do-1-5-0_gr_198001010130-198012312230.nc```
3. Create a job script and submit.
   - The demo is set to use 288 processes but can be changed.
   - Make sure the common files from run/common are correctly linked or copied in run/demo/INPUT/
 

