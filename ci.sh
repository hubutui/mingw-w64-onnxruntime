#!/usr/bin/env bash
git clone https://github.com/microsoft/onnxruntime.git
cd onnxruntime
git submodule update --init --recursive
pushd cmake/external/onnx
patch -p1 -i ../../../../0001.fix-building.patch
popd
cmake -B build-shared \
  -G'MSYS Makefiles' \
  -S cmake \
  -DCMAKE_INSTALL_PREFIX=/mingw64 \
  -Donnxruntime_BUILD_SHARED_LIB=ON \
  -Donnxruntime_ENABLE_PYTHON=OFF \
  -Donnxruntime_ENABLE_TRAINING=OFF \
  -Donnxruntime_PREFER_SYSTEM_LIB=OFF \
  -Donnxruntime_USE_DNNL=OFF \
  -Donnxruntime_USE_MPI=OFF
cmake --build build-shared