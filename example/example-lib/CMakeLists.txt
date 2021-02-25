cmake_minimum_required (VERSION 3.2)



set(DEVELOPMENT_PROJECT_NAME "example-ios")                     # <== Set to your project name, e.g. 

set(ENABLE_BITCODE "-fembed-bitcode")
project (${DEVELOPMENT_PROJECT_NAME})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fembed-bitcode")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fembed-bitcode")
set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "13.0")

set(IOS)

MESSAGE( STATUS "CMAKE_CXX_FLAGS: " ${CMAKE_CXX_FLAGS} )

# Add some sanitary checks that the toolchain is actually working!
include(CheckCXXSymbolExists)
check_cxx_symbol_exists(kqueue sys/event.h HAVE_KQUEUE)
if(NOT HAVE_KQUEUE)
  message(FATAL_ERROR "kqueue NOT found!")
else()
  message(STATUS "kqueue found!")
endif()

find_library(HAVE_UIKIT UIKit)
if (NOT HAVE_UIKIT)
  message(FATAL_ERROR "UIKit.framework NOT found!")
else()
  message(STATUS "UIKit.framework found!")
endif()

# Hook up XCTest for the supported plaforms (all but WatchOS)
if(NOT PLATFORM MATCHES ".*WATCHOS.*")
  # Use the standard find_package, broken between 3.14.0 and 3.14.4 at least for XCtest...
  find_package(XCTest)
  # Fallback: Try to find XCtest as host package via toochain macro (should always work)
  find_host_package(XCTest REQUIRED)
endif()

# Includes
include_directories(${example-ios_SOURCE_DIR})

# Make sure try_compile() works
include(CheckTypeSize)
check_type_size(time_t SIZEOF_TIME_T)

# Source files
set(SOURCES

  HelloWorldIOS.mm
)

# Headers
set(HEADERS

  HelloWorldIOS.h
)

# Library
if(BUILD_SHARED)
  add_library (example SHARED ${SOURCES} ${HEADERS})
  message(STATUS "Building shared version...")
else()
  add_library (example STATIC ${SOURCES} ${HEADERS})
  message(STATUS "Building static version...")
endif()

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  set(CMAKE_INSTALL_PREFIX ${example-ios_SOURCE_DIR}/../example-app/example-lib CACHE PATH "Install path" FORCE)
endif(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

# Executable
#add_executable (helloworld main.cpp)
include_directories(${CMAKE_SOURCE_DIR}/../depends/lib)
link_directories(${CMAKE_SOURCE_DIR}/../depends/lib)


# Link the library with the executable
#target_link_libraries(helloworld example)
add_subdirectory(libnunchuk)
target_link_libraries(example PUBLIC nunchuk)

set(CMAKE_SHARED_LINKER_FLAGS "-Wall")

set_target_properties(example PROPERTIES
    FRAMEWORK TRUE
    MACOSX_FRAMEWORK_INFO_PLIST "${PROJECT_SOURCE_DIR}/Info.plist"
    PUBLIC_HEADER "${example-ios_SOURCE_DIR}/HelloWorldIOS.h"
    XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "com.nunchuk.nunchuksdk"
    XCODE_ATTRIBUTE_CURRENT_PROJECT_VERSION "0.1"
    XCODE_ATTRIBUTE_DEFINES_MODULE "YES"
    XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC "YES"
    XCODE_ATTRIBUTE_CLANG_CXX_LANGUAGE_STANDARD "c++14"
    XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++"
)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  target_compile_options(example
    PRIVATE
    -stdlib=libc++
    -Wno-shorten-64-to-32
    -Wall
    -Wno-reorder
    -Wreturn-type
    -Wsign-compare
    -Wignored-qualifiers
    -Wtype-limits
    -Wmissing-field-initializers
    -Wc++17-extensions
    ${ENABLE_BITCODE})
endif()

