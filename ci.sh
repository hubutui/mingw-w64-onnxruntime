#!/usr/bin/env bash
wget https://github.com/hubutui/mingw-w64-onnx/releases/download/v1.10.2/mingw-w64-x86_64-onnx-1.10.2-1-any.pkg.tar.zst
pacman -U --noconfirm mingw-w64-x86_64-onnx-1.10.2-1-any.pkg.tar.zst
git clone https://github.com/microsoft/onnxruntime.git
cd onnxruntime
git submodule update --init --recursive
# pushd cmake/external/onnx
# patch -p1 -i ../../../../0001.fix-building.patch
# popd
cmake -B build-shared \
  -G'MSYS Makefiles' \
  -S cmake \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/mingw64 \
  -DDeigen_SOURCE_PATH=/mingw64/include/eigen3 \
  -Donnxruntime_BUILD_BENCHMARKS=OFF \
  -Donnxruntime_BUILD_SHARED_LIB=ON \
  -Donnxruntime_BUILD_UNIT_TESTS=OFF \
  -Donnxruntime_ENABLE_PYTHON=OFF \
  -Donnxruntime_ENABLE_STATIC_ANALYSIS=OFF \
  -Donnxruntime_ENABLE_TRAINING=OFF \
  -Donnxruntime_GENERATE_TEST_REPORTS=OFF \
  -Donnxruntime_PREFER_SYSTEM_LIB=ON \
  -Donnxruntime_RUN_ONNX_TESTS=OFF \
  -Donnxruntime_USE_AVX2=ON \
  -Donnxruntime_USE_AVX512=ON \
  -Donnxruntime_USE_AVX=ON \
  -Donnxruntime_USE_CUDA=OFF \
  -Donnxruntime_USE_DNNL=OFF \
  -Donnxruntime_USE_FULL_PROTOBUF=ON \
  -Donnxruntime_USE_MPI=ON \
  -Donnxruntime_USE_OPENMP=ON \
  -Donnxruntime_USE_PREINSTALLED_EIGEN=ON
cmake --build build-shared