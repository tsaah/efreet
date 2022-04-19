find_package(Git REQUIRED)

string(TIMESTAMP YEAR "%Y")
string(TIMESTAMP CMAKE_TIMESTAMP "%d-%m-%Y %H:%M:%S")
message("CMAKE_TIMESTAMP: ${CMAKE_TIMESTAMP}")

execute_process(COMMAND ${GIT_EXECUTABLE} branch --show-current WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_BRANCH OUTPUT_STRIP_TRAILING_WHITESPACE )
message("GIT_BRANCH: ${GIT_BRANCH}")

execute_process(COMMAND ${GIT_EXECUTABLE} describe --always --tags --candidates 1 --long WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_DESCRIPTION OUTPUT_STRIP_TRAILING_WHITESPACE )
message("GIT_DESCRIPTION: ${GIT_DESCRIPTION}")

execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse --short HEAD WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" OUTPUT_VARIABLE GIT_HASH OUTPUT_STRIP_TRAILING_WHITESPACE)
message("GIT_HASH: ${GIT_HASH}")

execute_process(COMMAND ${GIT_EXECUTABLE} rev-parse HEAD WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" OUTPUT_VARIABLE GIT_COMMIT_ID OUTPUT_STRIP_TRAILING_WHITESPACE )
message("GIT_COMMIT_ID: ${GIT_COMMIT_ID}")


string(REGEX MATCH "([A-Z0-9_\.]+)-([0-9]+)-[a-z0-9]+" MATCH_OUTPUT "${GIT_DESCRIPTION}")
set(GIT_TAG ${CMAKE_MATCH_1})
message("GIT_TAG: ${GIT_TAG}")

set(GIT_TAG_DISTANCE ${CMAKE_MATCH_2})
message("GIT_TAG_DISTANCE: ${GIT_TAG_DISTANCE}")

string(REGEX MATCH "([A-Z]+)_([0-9]+)\.([0-9]+)\.([0-9]+)_?([A-Z0-9]+)?" MATCH_OUTPUT "${GIT_TAG}")
set(GIT_TAG_PREFIX "${CMAKE_MATCH_1}")
message("GIT_TAG_PREFIX: ${GIT_TAG_PREFIX}")

set(TARGET_VERSION_MAJOR "${CMAKE_MATCH_2}")
set(TARGET_VERSION_MINOR "${CMAKE_MATCH_3}")
set(TARGET_VERSION_PATCH "${CMAKE_MATCH_4}")
set(TARGET_VERSION_BUILD ${GIT_TAG_DISTANCE})

if(TARGET_VERSION_MAJOR STREQUAL "")
    set(TARGET_VERSION_MAJOR "${YEAR}")
endif()

if(TARGET_VERSION_MINOR STREQUAL "")
    string(TIMESTAMP TEMP_VERSION_MINOR "%m")
    set(TARGET_VERSION_MINOR "${TEMP_VERSION_MINOR}")
endif()

if(TARGET_VERSION_PATCH STREQUAL "")
    string(TIMESTAMP TEMP_VERSION_PATCH "%d")
    set(TARGET_VERSION_PATCH "${TEMP_VERSION_PATCH}")
endif()

if(NOT DEFINED TARGET_VERSION_BUILD)
    string(TIMESTAMP TEMP_VERSION_BUILD "%H%M%S")
    set(TARGET_VERSION_BUILD "${TEMP_VERSION_BUILD}")
endif()

set(GIT_TAG_VERSION_SUFFIX "${CMAKE_MATCH_5}")
message("GIT_TAG_VERSION_SUFFIX: ${GIT_TAG_VERSION_SUFFIX}")




set(VERSION "${TARGET_VERSION_MAJOR}.${TARGET_VERSION_MINOR}.${TARGET_VERSION_PATCH}.${TARGET_VERSION_BUILD}")

if(GIT_BRANCH MATCHES "^release/")
    set(IS_RELEASE "release")
else()
    set(IS_RELEASE "not-release")
endif()

set(TARGET_COMPANY "Efreet inc")
set(TARGET_PRODUCT "Efreet ${GIT_TAG} ${IS_RELEASE} ${CMAKE_TIMESTAMP} ${GIT_COMMIT_ID}")
set(TARGET_DESCRIPTION "Yet another game engine.")
set(TARGET_COPYRIGHT "(c)${YEAR} Efreet inc")
set(TARGET_VERSION_REPO "WhisEfreetper")
set(TARGET_ICON_PATH "${PROJECT_DIR}/efreet.ico")
set(TARGET_VERSION_REPO "")

message("VERSION: ${VERSION}")

set(TARGET_PRODUCT_VERSION_MAJOR "${TARGET_VERSION_MAJOR}")
set(TARGET_PRODUCT_VERSION_MINOR "${TARGET_VERSION_MINOR}")
set(TARGET_PRODUCT_VERSION_PATCH "${TARGET_VERSION_PATCH}")
set(TARGET_PRODUCT_VERSION_BUILD "${TARGET_VERSION_BUILD}")




