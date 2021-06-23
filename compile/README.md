# Clone MOM6-examples respository
git clone https://github.com/NOAA-GFDL/MOM6-examples.git


# General notes for repository compatible with compile script
cd MOM6-examples
git reset --hard <git_version in_compile_script> 
git submodule update --recursive

# JUN-23-2021: Specific instructions for MOM6-examples ae27c868471aaa0cc03a06912137637a2570a8d3
cd MOM6-examples
git reset --hard ae27c868471aaa0cc03a06912137637a2570a8d3
git submodule update --recursive

if using the gregorian calendar to initialize (as with demo), make the following changes:
	
	in MOM6-examples/src/coupler/coupler_main.F90:

        	- Line 319: use time_manager_mod,        only: operator (*), THIRTY_DAY_MONTHS, JULIAN
		+ Line 319: use time_manager_mod,        only: operator (*), THIRTY_DAY_MONTHS, JULIAN, GREGORIAN

		+ Line 1289: case( 'GREGORIAN' )
		+ Line 1290:   calendar_type = GREGORIAN

