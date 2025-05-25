#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

if [[ ${cuda_compiler_version:=None} != "None" ]]; then
    export EXTRA_CMAKE_FLAGS="-DCMAKE_CUDA_SEPARABLE_COMPILATION=ON -DVTKm_ENABLE_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES='70-real;86-virtual'"
else
    export EXTRA_CMAKE_FLAGS="-DVTKm_ENABLE_CUDA=OFF"
fi

cmake -GNinja -S ${SRC_DIR} -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -Wno-dev \
    -DVTKm_ENABLE_OPENMP=ON \
    -DVTKm_ENABLE_EXAMPLES=OFF \
    -DVTKm_INSTALL_EXAMPLES=OFF \
    ${EXTRA_CMAKE_FLAGS} \
    ${CMAKE_ARGS}

cmake --build build -j${CPU_COUNT}
cmake --install build

# Smoke test can only be run when we are *not* cross-compiling.
if [[ ${CONDA_BUILD_CROSS_COMPILATION:-0} == 0 ]]; then
    VTKm_DIR=$PREFIX cmake -GNinja -S ${SRC_DIR}/examples/smoke_test/ -B smoke_test_build
    cmake --build smoke_test_build
    ./smoke_test_build/smoke_test
fi
