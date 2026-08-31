set(TARGET_NAME "tgt-cxx-feat")
set(EXEC_NAME "bin-cxx-feat")

find_package(GTest CONFIG REQUIRED PATHS "${ART_CXX_DEPS_DIR}/googletest" NO_DEFAULT_PATH)
find_package(spdlog CONFIG REQUIRED PATHS "${ART_CXX_DEPS_DIR}/spdlog" NO_DEFAULT_PATH)

add_executable("${TARGET_NAME}" "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp")
set_target_properties("${TARGET_NAME}" PROPERTIES CXX_STANDARD 20
                                                  CXX_STANDARD_REQUIRED ON
                                                  CXX_EXTENSIONS OFF
                                                  OUTPUT_NAME "${EXEC_NAME}"
)

target_include_directories("${TARGET_NAME}" PRIVATE "${CMAKE_SOURCE_DIR}"
                                                    "${CMAKE_CURRENT_SOURCE_DIR}"
)

target_sources("${TARGET_NAME}" PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/stack.cpp"
)

target_compile_definitions("${TARGET_NAME}" PRIVATE
                            SPDLOG_ACTIVE_LEVEL=SPDLOG_LEVEL_DEBUG
)

target_compile_options("${TARGET_NAME}" PRIVATE -pthread
                                                -ggdb
                                                -Wno-unused-value
                                                -Wno-unused-parameter
                                                -Wno-return-stack-address
                                                -Wno-tautological-undefined-compare
)

target_link_libraries("${TARGET_NAME}" PRIVATE -pthread
                                               GTest::gtest
                                               GTest::gmock
                                               spdlog::spdlog
)
