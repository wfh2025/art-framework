#!/usr/bin/env bash
export PROJ_ROOT=$(cd "$(dirname -- "$0")" && pwd -P)
export PROJ_BUILD=${PROJ_ROOT}/build
export PROJ_DEPS=${PROJ_ROOT}/deps
export PROJ_SRC=${PROJ_ROOT}/src
export PROJ_CMAKE=$(which cmake)
export PROJ_CMAKE_GENERATOR="Ninja"  # Unix Makefiles
export PROJ_CC=$(which cc)
export PROJ_CXX=$(which c++)
export NINJA_STATUS="[%f/%t running:%r elapsed:%es] "

function time_ms() {
    local func_name="$1"
    local start_s start_ns end_s end_ns
    # %s 秒，%N 纳秒(000000000‑999999999)
    read -r start_s start_ns <<< $(date +"%s %N")
    "$@"
    read -r end_s end_ns <<< $(date +"%s %N")

    # 转成总毫秒
    local start_ms=$(( start_s * 1000 + ${start_ns:0:3} ))
    local end_ms=$(( end_s * 1000 + ${end_ns:0:3} ))
    local cost_ms=$(( end_ms - start_ms ))

    local total_sec=$(( cost_ms / 1000 ))
    local min=$(( total_sec / 60 ))
    local sec=$(( total_sec % 60 ))
    local ms=$(( cost_ms % 1000 ))

    printf "[time] %-20s | %02d:%02d.%03d | total: %d ms\n" \
        "${func_name}" "${min}" "${sec}" "${ms}" "${cost_ms}"
}

function build-deps() {
    build-googletest
    build-spdlog
    build-ogdf
}

function build-qt-configure() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/qt"
    local src="${PROJ_ROOT}/vendor/qt-everywhere-src-6.5.9"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}" && mkdir -p "${build_dir}"

    (
        cd "${build_dir}"
        "${src}/configure" -prefix "${install_dir}" \
            -opensource \
            -confirm-license \
            -release -nomake tests -force-debug-info -make examples \
            -skip qtwebengine -skip qtquick3d -shared
        ninja
        ninja install
    )
    rm -fr "${build_dir}"
}

function build-qt-cmake() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/qt"
    local src="${PROJ_ROOT}/vendor/qt-everywhere-src-6.5.9"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}"

    ${PROJ_CMAKE} -B "${build_dir}" \
          -S "${src}" \
          -G "${PROJ_CMAKE_GENERATOR}" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_CXX_COMPILER="${PROJ_CXX}" \
          -DCMAKE_INSTALL_PREFIX="${install_dir}" \
          -Wno-dev \
          -DBUILD_SHARED_LIBS=ON \
          -DQT_BUILD_TESTS=OFF \
          -DQT_BUILD_EXAMPLES=ON \
          -DBUILD_qtwebengine=OFF \
          -DBUILD_qtquick3d=OFF
    ${PROJ_CMAKE} --build "${build_dir}" --parallel --target install

    rm -fr "${build_dir}"
}

function build-ogdf() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/ogdf"
    local src="${PROJ_ROOT}/vendor/ogdf-foxglove-202510"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}"

    ${PROJ_CMAKE} -B "${build_dir}" \
          -S "${src}" \
          -G "${PROJ_CMAKE_GENERATOR}" \
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
          -DCMAKE_CXX_FLAGS="-Werror -Wno-deprecated-declarations -Wno-sign-compare -Wno-unused-variable"
    ${PROJ_CMAKE} --build "${build_dir}" --parallel --target install

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
          -G "${PROJ_CMAKE_GENERATOR}" \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_CXX_COMPILER="${PROJ_CXX}" \
          -DCMAKE_INSTALL_PREFIX="${install_dir}" -DSPDLOG_BUILD_SHARED=OFF
    ${PROJ_CMAKE} --build "${build_dir}" --parallel --target install

    rm -fr "${build_dir}"
}

function build-googletest() {
    local build_dir="${PROJ_BUILD}"
    local install_dir="${PROJ_DEPS}/googletest"
    local src="${PROJ_ROOT}/vendor/googletest-1.17.0"

    rm -fr "${build_dir}" "${install_dir}" && mkdir -p "${install_dir}"
    ${PROJ_CMAKE} -B "${build_dir}" \
          -S "${src}" \
          -G "${PROJ_CMAKE_GENERATOR}" \
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
