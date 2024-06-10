# GetGn.cmake
#
# A utility to acquire and compile GN as a local project dependency

set(DEPS_GN_REPO https://gn.googlesource.com/gn)
set(DEPS_GN_TAG b3a0bff47dd81073bfe67a402971bad92e4f2423)


# if(GN_ROOT MATCHES "")
#     message(FATAL_ERROR "GN_ROOT is not defined" )
# endif()
if("${CPM_SOURCE_CACHE}" STREQUAL "")
    message(FATAL_ERROR "CPM_SOURCE_CACHE is not defined" )
endif()

# download the code
CPMAddPackage( 
    NAME googleGn
    DOWNLOAD_ONLY TRUE
    GIT_REPOSITORY ${DEPS_GN_REPO}
    GIT_TAG ${DEPS_GN_TAG}
)

if(googleGn_ADDED)

    execute_process(
        COMMAND python3 build/gen.py --out-path ${googleGn_BINARY_DIR}
        RESULT_VARIABLE result 
        # COMMAND_ECHO STDOUT
        OUTPUT_VARIABLE cmd_out
        WORKING_DIRECTORY ${googleGn_SOURCE_DIR} 
    )

    execute_process(
        COMMAND ninja -C ${googleGn_BINARY_DIR}
        RESULT_VARIABLE result 
        # COMMAND_ECHO STDOUT
        OUTPUT_VARIABLE cmd_out
        WORKING_DIRECTORY ${googleGn_SOURCE_DIR} 
    )

    message(STATUS "GN binary: ${googleGn_BINARY_DIR} ")
    
endif()


# python build/gen.py # --allow-warning if you want to build with warnings.
# ninja -C out
# # To run tests:
# out/gn_unittests


### ------------

# https://github.com/holepunchto/cmake-gn.git
#
# set(GN_DIR "" CACHE PATH "Path to the GN root directory")
# 
# set(GN_OUT_DIR "" CACHE PATH "Path to the GN output directory")
# 
# function(add_gn_library name target type)
#   add_library(${name} ${type} IMPORTED)
# 
#   find_gn(gn)
# 
#   execute_process(
#     COMMAND ${gn} desc ${GN_OUT_DIR} ${target} --format=json
#     WORKING_DIRECTORY ${GN_DIR}
#     OUTPUT_VARIABLE json
#     COMMAND_ERROR_IS_FATAL ANY
#   )
# 
#   string(JSON output ERROR_VARIABLE error GET "${json}" "//${target}" "outputs" 0)
# 
#   if(error MATCHES "NOTFOUND")
#     set(output "${GN_DIR}${output}")
# 
#     cmake_path(NORMAL_PATH output)
# 
#     set_target_properties(
#       ${name}
#       PROPERTIES
#       IMPORTED_LOCATION ${output}
#     )
#   endif()
# 
#   string(JSON len ERROR_VARIABLE error LENGTH "${json}" "//${target}" "include_dirs")
# 
#   if(error MATCHES "NOTFOUND")
#     foreach(i RANGE ${len})
#       if(NOT i EQUAL len)
#         string(JSON dir GET "${json}" "//${target}" "include_dirs" ${i})
# 
#         set(dir "${GN_DIR}${dir}")
# 
#         cmake_path(NORMAL_PATH dir)
# 
#         target_include_directories(${name} INTERFACE "${dir}")
#       endif()
#     endforeach()
#   endif()
# 
#   string(JSON len ERROR_VARIABLE error LENGTH "${json}" "//${target}" "defines")
# 
#   if(error MATCHES "NOTFOUND")
#     foreach(i RANGE ${len})
#       if(NOT i EQUAL len)
#         string(JSON definition GET "${json}" "//${target}" "defines" ${i})
# 
#         target_compile_definitions(${name} INTERFACE ${definition})
#       endif()
#     endforeach()
#   endif()
# 
#   string(JSON len ERROR_VARIABLE error LENGTH "${json}" "//${target}" "libs")
# 
#   if(error MATCHES "NOTFOUND")
#     foreach(i RANGE ${len})
#       if(NOT i EQUAL len)
#         string(JSON lib GET "${json}" "//${target}" "libs" ${i})
# 
#         cmake_path(IS_ABSOLUTE lib is_absolute)
# 
#         if(is_absolute)
#           set(lib "${GN_DIR}${lib}")
# 
#           cmake_path(NORMAL_PATH lib)
#         endif()
# 
#         target_link_libraries(${name} INTERFACE "$<LINK_LIBRARY:DEFAULT,${lib}>")
#       endif()
#     endforeach()
#   endif()
# 
#   string(JSON len ERROR_VARIABLE error LENGTH "${json}" "//${target}" "weak_frameworks")
# 
#   if(error MATCHES "NOTFOUND")
#     foreach(i RANGE ${len})
#       if(NOT i EQUAL len)
#         string(JSON framework GET "${json}" "//${target}" "weak_frameworks" ${i})
# 
#         list(APPEND frameworks ${framework})
# 
#         target_link_libraries(${name} INTERFACE "$<LINK_LIBRARY:WEAK_FRAMEWORK,${framework}>")
#       endif()
#     endforeach()
#   endif()
# 
#   string(JSON len ERROR_VARIABLE error LENGTH "${json}" "//${target}" "frameworks")
# 
#   if(error MATCHES "NOTFOUND")
#     foreach(i RANGE ${len})
#       if(NOT i EQUAL len)
#         string(JSON framework GET "${json}" "//${target}" "frameworks" ${i})
# 
#         if(NOT framework IN_LIST frameworks)
#           target_link_libraries(${name} INTERFACE "$<LINK_LIBRARY:FRAMEWORK,${framework}>")
#         endif()
#       endif()
#     endforeach()
#   endif()
# endfunction()
# 
# function(find_gn result)
#   find_program(gn NAMES gn.bat gn REQUIRED)
# 
#   set(${result} ${gn})
# 
#   return(PROPAGATE ${result})
# endfunction()
# 
