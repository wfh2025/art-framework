#!/usr/bin/env bash
export PROJ_ROOT=$(cd "$(dirname -- "$0")" && pwd -P)
export PROJ_BUILD=${PROJ_ROOT}/build
export PROJ_VENDOR=${PROJ_ROOT}/vendor

SWIFT_LOG_REPO=https://gitclone.com/github.com/apple/swift-log.git  # 直连: https://github.com/apple/swift-log.git
SWIFT_LOG_VERSION=1.5.4
SWIFT_ARGUMENT_PARSER_REPO=https://gitclone.com/github.com/apple/swift-argument-parser.git  # 直连: https://github.com/apple/swift-argument-parser.git
SWIFT_ARGUMENT_PARSER_VERSION=1.8.2

function packages() {
    local manifest pkg
    for manifest in "${PROJ_ROOT}"/*/Package.swift; do
        pkg=$(dirname "${manifest}")
        case "${pkg}" in "${PROJ_VENDOR}"*) continue ;; esac
        printf '%s\n' "${pkg}"
    done
}

# macOS 的 date 不支持 %N
function now_ms() {
    perl -MTime::HiRes=time -e 'print int(time()*1000)'
}

function time_ms() {
    local func_name="$1"
    shift
    local start_ms end_ms
    start_ms=$(now_ms)
    "$@"
    end_ms=$(now_ms)

    local cost_ms=$(( end_ms - start_ms ))
    local total_sec=$(( cost_ms / 1000 ))
    local min=$(( total_sec / 60 ))
    local sec=$(( total_sec % 60 ))
    local ms=$(( cost_ms % 1000 ))

    printf "[time] %-20s | %02d:%02d.%03d | total: %d ms\n" \
        "${func_name}" "${min}" "${sec}" "${ms}" "${cost_ms}"
}

function deps() {
    fetch-vendor swift-log "${SWIFT_LOG_REPO}" "${SWIFT_LOG_VERSION}"
    fetch-vendor swift-argument-parser "${SWIFT_ARGUMENT_PARSER_REPO}" "${SWIFT_ARGUMENT_PARSER_VERSION}"
}

function fetch-vendor() {
    local name="$1" repo="$2" version="$3"
    local dst="${PROJ_VENDOR}/${name}"
    if [ -d "${dst}/Sources" ]; then
        echo "[deps] ${name} already at ${dst}"
        return 0
    fi
    rm -fr "${dst}" && mkdir -p "${PROJ_VENDOR}"
    git clone --depth 1 --branch "${version}" "${repo}" "${dst}" || return 1
    rm -fr "${dst}/.git"
}

function build() {
    local pkg name
    for pkg in $(packages); do
        name=$(basename "${pkg}")
        time_ms "build-${name}" swift build --package-path "${pkg}" --scratch-path "${PROJ_BUILD}/${name}"
    done
    link-bin
}

# 可执行文件统一入口: build/bin/<名字> -> 各包真实产物(路径由 SPM 告知, 不硬编码目录结构)
function link-bin() {
    mkdir -p "${PROJ_BUILD}/bin"
    local pkg name bin_dir rel
    for pkg in $(packages); do
        name=$(basename "${pkg}")
        bin_dir=$(swift build --package-path "${pkg}" --scratch-path "${PROJ_BUILD}/${name}" --show-bin-path)
        if [ -x "${bin_dir}/${name}" ]; then
            rel="${bin_dir#"${PROJ_BUILD}/"}"
            ln -f -s "../${rel}/${name}" "${PROJ_BUILD}/bin/${name}"
        fi
    done
}

function test() {
    local pkg name
    for pkg in $(packages); do
        name=$(basename "${pkg}")
        time_ms "test-${name}" swift test --package-path "${pkg}" --scratch-path "${PROJ_BUILD}/${name}"
    done
}

function format() {
    local pkg
    for pkg in $(packages); do
        swift-format -i --configuration "${PROJ_ROOT}/.swift-format" -r "${pkg}/Sources" "${pkg}/Tests"
    done
}

function clean() {
    rm -fr "${PROJ_BUILD}"
    local pkg
    for pkg in $(packages); do
        rm -fr "${pkg}/.build"
    done
}

function run() {
    swift run --package-path "${PROJ_ROOT}/Playground" --scratch-path "${PROJ_BUILD}/Playground" Playground "$@"
}

function leetcode() {
    swift run --package-path "${PROJ_ROOT}/LeetCode" --scratch-path "${PROJ_BUILD}/LeetCode" LeetCode "$@"
}

function wordcount() {
    swift run --package-path "${PROJ_ROOT}/WordCount" --scratch-path "${PROJ_BUILD}/WordCount" WordCount "$@"
}

function script() {
    local fileName=$1
    swift-format -i --configuration "${PROJ_ROOT}/.swift-format" "${PROJ_ROOT}/${fileName}"
    swift "${PROJ_ROOT}/${fileName}"
}

function main() {
    local funcName="$1"
    shift
    "$funcName" "$@"
}
main "$@"
