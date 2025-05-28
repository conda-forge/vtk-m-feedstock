@echo on
@setlocal EnableDelayedExpansion

if %cuda_compiler_version% NEQ None (
    set CMAKE_ARGS=%CMAKE_ARGS% -DCMAKE_CUDA_SEPARABLE_COMPILATION=ON -DVTKm_ENABLE_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES='70-real;86-virtual' -DCMAKE_CUDA_FLAGS='-Xptxas --disable-optimizer-constants'"
) else (
    set CMAKE_ARGS=%CMAKE_ARGS% -DVTKm_ENABLE_CUDA=OFF
)

cmake -GNinja -S %SRC_DIR% -B build ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_VERBOSE_MAKEFILE=ON ^
    -Wno-dev ^
    -DVTKm_ENABLE_EXAMPLES=OFF ^
    -DVTKm_INSTALL_EXAMPLES=OFF ^
    %CMAKE_ARGS%

cmake --build build -j%CPU_COUNT%
cmake --install build
