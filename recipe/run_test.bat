@echo on
@setlocal EnableDelayedExpansion

for /F "tokens=1,2 delims=. " %%a in ("%PKG_VERSION%") do (
    set so_version=%%a.%%b
)

set vtkm_modules=^
    cont^
    filter_clean_grid^
    filter_connected_components^
    filter_contour^
    filter_core^
    filter_density_estimate^
    filter_entity_extraction^
    filter_field_conversion^
    filter_field_transform^
    filter_flow^
    filter_geometry_refinement^
    filter_image_processing^
    filter_mesh_info^
    filter_multi_block^
    filter_resampling^
    filter_scalar_topology^
    filter_vector_analysis^
    filter_zfp^
    io^
    rendering^
    source^
    worklet

for %%a in (%vtkm_modules%) do (
    call:check_lib %%a
)

if not exist %LIBRARY_PREFIX%\include\vtkm-%so_version% exit 1

goto :eof

:check_lib
set lib_name=%~1
if not exist %LIBRARY_PREFIX%\bin\vtkm_%lib_name%-%so_version%.dll exit 1
if not exist %LIBRARY_PREFIX%\lib\vtkm_%lib_name%-%so_version%.lib exit 1
goto :eof
