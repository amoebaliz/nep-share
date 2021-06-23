## Clone MOM6-examples respository

```rust
git clone https://github.com/NOAA-GFDL/MOM6-examples.git
```

## General repository/ compile script compatibility instructions:

```rust
cd MOM6-examples
git reset --hard <git_version_in_compile_script> 
git submodule update --recursive
```

## for ae27c868471aaa0cc03a06912137637a2570a8d3:
```
cd MOM6-examples
git reset --hard ae27c868471aaa0cc03a06912137637a2570a8d3
git submodule update --recursive
```
if using the gregorian calendar to initialize (as with demo), make the following changes:
	
- MOM6-examples/src/coupler/coupler_main.F90:
```python
- Line 319: use time_manager_mod,        only: operator (*), THIRTY_DAY_MONTHS, JULIAN
+ Line 319: use time_manager_mod,        only: operator (*), THIRTY_DAY_MONTHS, JULIAN, GREGORIAN

+ Line 1289: case( 'GREGORIAN' )
+ Line 1290:   calendar_type = GREGORIAN
```
