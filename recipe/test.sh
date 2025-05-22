#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

soversion=

check_lib() {
    lib_name=$1
    test -f ${PREFIX}/
}

vtkm_modules=(
    cont
    filter_clean_grid
    filter_connected_components
    filter_contour
    filter_core
    filter_density_estimate
    filter_entity_extraction
    filter_field_conversion
    filter_field_transform
    filter_flow
    filter_geometry_refinement
    filter_image_processing
    filter_mesh_info
    filter_multi_block
    filter_resampling
    filter_scalar_topology
    filter_vector_analysis
    filter_zfp
    io
    rendering
    source
    worklet
)
