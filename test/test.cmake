#------------------------------------
# Test

# Source files of the CLI and GUI(no Kernel and no Shared, they are linked)
set(SOURCE_FILES_TEST ${SOURCE_FILES_TEST} ${SOURCE_FILES_GUI} ${SOURCE_FILES_CLI})

if(OPENPSTD_TEST_FILE)
    message(STATUS "Test file: ${OPENPSTD_TEST_FILE}")
    # the single test file that must be compiled
    set(SOURCE_FILES_TEST ${SOURCE_FILES_TEST} ${OPENPSTD_TEST_FILE})
else()
    message(STATUS "Test file: ALL")

    # GUI test files
    set(SOURCE_FILES_TEST ${SOURCE_FILES_TEST} test/GUI/Edges-test.cpp test/GUI/LongOperationRunner-test.cpp)
    # Kernel test files
    set(SOURCE_FILES_TEST ${SOURCE_FILES_TEST} test/Kernel/kernel_functions.cpp
            test/Kernel/Speaker.cpp test/Kernel/Scene.cpp test/Kernel/Geometry.cpp test/Kernel/Domain.cpp
            test/Kernel/WisdomCache.cpp)
endif()


add_executable(OpenPSTD-test test/main.cpp ${SOURCE_FILES_TEST})

# create extra Qt5 code
set_target_properties(OpenPSTD-test
        PROPERTIES AUTOMOC ON
        AUTOUIC ON
        AUTORCC ON)

target_include_directories(OpenPSTD PUBLIC ${Qt5_INCLUDE_DIRS})
target_include_directories(OpenPSTD PUBLIC unqlite)
target_include_directories(OpenPSTD PUBLIC ${Boost_INCLUDE_DIR})
target_include_directories(OpenPSTD PUBLIC ${OPENGL_INCLUDE_DIR})

target_link_libraries(OpenPSTD-test OpenPSTD)
target_link_libraries(OpenPSTD-test OpenPSTD-shared)
target_link_libraries(OpenPSTD-test ${Boost_LIBRARIES})
target_link_libraries(OpenPSTD-test ${Qt5_LIBRARIES})
target_link_libraries(OpenPSTD-test unqlite)
target_link_libraries(OpenPSTD-test ${OPENGL_LIBRARIES})