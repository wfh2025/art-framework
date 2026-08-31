set(TARGET_NAME "tgt-feat-qt-api")
set(EXEC_NAME "bin-feat-qt-api")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Threads REQUIRED)
find_package(GTest CONFIG REQUIRED PATHS "${ART_CXX_DEPS_DIR}/googletest" NO_DEFAULT_PATH)
find_package(spdlog CONFIG REQUIRED PATHS "${ART_CXX_DEPS_DIR}/spdlog" NO_DEFAULT_PATH)
find_package(Qt6 CONFIG REQUIRED PATHS "${ART_CXX_DEPS_DIR}/qt" NO_DEFAULT_PATH COMPONENTS Core Gui Widgets Network)

add_executable("${TARGET_NAME}" "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")
set_target_properties("${TARGET_NAME}" PROPERTIES CXX_STANDARD 20
                                                  CXX_STANDARD_REQUIRED ON
                                                  CXX_EXTENSIONS OFF
                                                  UNITY_BUILD OFF
                                                  OUTPUT_NAME "${EXEC_NAME}"
)

target_include_directories("${TARGET_NAME}" PRIVATE "${CMAKE_SOURCE_DIR}"
)

file(GLOB MVP_FILES CONFIGURE_DEPENDS 
    "${CMAKE_CURRENT_SOURCE_DIR}/mvp/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/mvp/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/mvp/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/mvp/*.cxx"
)
file(GLOB PROBLEMS_FILES CONFIGURE_DEPENDS 
    "${CMAKE_CURRENT_SOURCE_DIR}/problems/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/problems/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/problems/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/problems/*.cxx"
)
file(GLOB TESTDATA_FILES CONFIGURE_DEPENDS 
    "${CMAKE_CURRENT_SOURCE_DIR}/testdata/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/testdata/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/testdata/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/testdata/*.cxx"
)
file(GLOB PRACTICES_FILES CONFIGURE_DEPENDS 
    "${CMAKE_CURRENT_SOURCE_DIR}/practices/*.h"
    "${CMAKE_CURRENT_SOURCE_DIR}/practices/*.hpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/practices/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/practices/*.cxx"
)
target_sources("${TARGET_NAME}" PRIVATE ${MVP_FILES}
                                        ${PRACTICES_FILES}
                                        ${PROBLEMS_FILES}
                                        ${TESTDATA_FILES}
                                        
)

target_compile_definitions("${TARGET_NAME}" PRIVATE
                            SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_DEBUG
)

target_compile_options("${TARGET_NAME}" PRIVATE -ggdb
                                                -Wno-unused-value
                                                -Wno-unused-parameter
                                                -Wno-return-stack-address
                                                -Wno-tautological-undefined-compare
)

target_link_libraries("${TARGET_NAME}" PRIVATE Threads::Threads
                                               GTest::gtest
                                               GTest::gmock
                                               spdlog::spdlog
                                               Qt6::Core
                                               Qt6::Gui
                                               Qt6::Widgets
                                               Qt6::Network
)
