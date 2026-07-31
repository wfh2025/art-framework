#!/usr/bin/env bash
export PROJ_ROOT=$(cd "$(dirname -- "$0")" && pwd -P)
export PROJ_BUILD=${PROJ_ROOT}/build
export PROJ_DEPS=${PROJ_ROOT}/deps
export PROJ_SRC=${PROJ_ROOT}/src
export PROJ_CMAKE=$(which cmake)
export PROJ_CC=$(which cc)
export PROJ_CXX=$(which c++)

function build-deps() {
    build-googletest
    build-spdlog
    build-ogdf
}

function build-ogdf() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/ogdf"
    local src="${PROJ_ROOT}/vendor/ogdf-foxglove-202510"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}"

    ${PROJ_CMAKE} -B "${build_dir}" \
          -S "${src}" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_CXX_COMPILER="${PROJ_CXX}" \
          -DCMAKE_INSTALL_PREFIX="${install_dir}" \
          -DBUILD_SHARED_LIBS=OFF \
          -DDOC_INSTALL=OFF \
          -DOGDF_ENABLE_CLANG_TIDY=OFF \
          -DOGDF_LIBRARY_TARGETS_ONLY=ON \
          -DOGDF_USE_ASSERT_EXCEPTIONS=ON \
          -DOGDF_SEPARATE_TESTS=OFF \
          -DOGDF_WARNING_ERRORS=OFF \
          -DCMAKE_CXX_FLAGS="-Werror -Wno-deprecated-declarations -Wno-sign-compare -Wno-unused-variable" \
          -DCMAKE_C_FLAGS="-Werror -Wno-deprecated-declarations -Wno-sign-compare -Wno-unused-variable" 
    ${PROJ_CMAKE} --build "${PROJ_BUILD}" --parallel --target install

    rm -fr "${build_dir}"
}

function build-tinyformat() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/tinyformat"
    local src="${PROJ_ROOT}/vendor/tinyformat-2.3.0"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}/include"
    ln -f -s "${src}" "${install_dir}/include/tinyformat"
    rm -fr "${build_dir}"
}

function build-spdlog() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/spdlog"
    local src="${PROJ_ROOT}/vendor/spdlog-1.15.3"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}"

    ${PROJ_CMAKE} -B "${build_dir}" \
          -S "${src}" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_CXX_COMPILER="${PROJ_CXX}" \
          -DCMAKE_INSTALL_PREFIX="${install_dir}" -DSPDLOG_BUILD_SHARED=OFF
    ${PROJ_CMAKE} --build "${PROJ_BUILD}" --parallel --target install

    rm -fr "${build_dir}"
}

function build-googletest() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/googletest"
    local src="${PROJ_ROOT}/vendor/googletest-1.17.0"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}"
    ${PROJ_CMAKE} -B "${build_dir}" \
          -S "${src}" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_C_COMPILER="${PROJ_CC}" \
          -DCMAKE_CXX_COMPILER="${PROJ_CXX}" \
          -DBUILD_SHARED_LIBS=OFF \
          -DCMAKE_INSTALL_PREFIX="${install_dir}"
    ${PROJ_CMAKE} --build "${build_dir}" --parallel --target install
    rm -fr "${build_dir}"
}

function main() {
    local funcName="$1"
    shift
    "$funcName" "$@"
}
main "$@"
