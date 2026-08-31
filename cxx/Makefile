PROJ_DIR                 := $(abspath $(CURDIR))
SRC_DIR                  := ${PROJ_DIR}/src
DEPS_DIR                 := ${PROJ_DIR}/deps
BUILD_DIR                := ${PROJ_DIR}/build
PROJ_CC                  := $(shell which cc)
PROJ_CXX                 := $(shell which c++)
PROJ_CMAKE               := cmake
PROJ_CMAKE_GENERATOR     := Ninja
RM                       := rm -fr
MKDIR                    := mkdir -p
.DEFAULT_GOAL            := build

export NINJA_STATUS      := [%f/%t running:%r elapsed:%es] 

all: deps build
build: generate
	${PROJ_CMAKE} --build "${BUILD_DIR}" --parallel
generate: clean
	${PROJ_CMAKE} -B "${BUILD_DIR}" -S "${PROJ_DIR}" \
	-G "${PROJ_CMAKE_GENERATOR}" \
	-DCMAKE_C_COMPILER="${PROJ_CC}" \
	-DCMAKE_CXX_COMPILER="${PROJ_CXX}" \
	-DCMAKE_MESSAGE_LOG_LEVEL=FATAL_ERROR -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
deps: clean
	${RM} "${DEPS_DIR}" && mkdir -p "${DEPS_DIR}" && ${PROJ_DIR}/entry.sh time_ms build-deps
clean:
	${RM} "${BUILD_DIR}"
run: build
	DYLD_LIBRARY_PATH=${BUILD_DIR}/lib ${BUILD_DIR}/bin/bin-feat-qt-api
gdb: build
	DYLD_LIBRARY_PATH=${BUILD_DIR}/lib lldb ${BUILD_DIR}/bin/bin-leetcode
print-%:
	@echo $* = $($*)
.PHONY: all clean build deps run generate
