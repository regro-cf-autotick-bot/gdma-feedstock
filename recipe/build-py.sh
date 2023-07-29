if [ "$(uname)" == "Darwin" ]; then
    ARCH_ARGS=""

    # c-f-provided CMAKE_ARGS handles CMAKE_OSX_DEPLOYMENT_TARGET, CMAKE_OSX_SYSROOT
fi
if [ "$(uname)" == "Linux" ]; then
    ARCH_ARGS=""

fi

IS_PYPY=$(${PYTHON} -c "import platform; print(int(platform.python_implementation() == 'PyPy'))")

${BUILD_PREFIX}/bin/cmake ${CMAKE_ARGS} ${ARCH_ARGS} \
  -S ${SRC_DIR}/pygdma \
  -B build_py${PY_VER}${IS_PYPY} \
  -G Ninja \
  -D CMAKE_INSTALL_PREFIX=${PREFIX} \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_CXX_COMPILER=${CXX} \
  -D CMAKE_CXX_FLAGS="${CXXFLAGS}" \
  -D CMAKE_INSTALL_LIBDIR=lib \
  -D PYMOD_INSTALL_LIBDIR="/python${PY_VER}/site-packages" \
  -D Python_EXECUTABLE=${PYTHON} \
  -D CMAKE_VERBOSE_MAKEFILE=OFF \
  -D CMAKE_PREFIX_PATH="${PREFIX}"

cmake --build build_py${PY_VER}${IS_PYPY} --target install -j${CPU_COUNT}

