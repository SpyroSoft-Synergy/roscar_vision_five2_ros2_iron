cmake_minimum_required(VERSION 3.13)

if(RISCV_TOOLCHAIN_INCLUDED)
  return()
endif(RISCV_TOOLCHAIN_INCLUDED)
set(RISCV_TOOLCHAIN_INCLUDED true)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR riscv64)
set(CMAKE_SYSROOT ${ROOT_FS_DIR})
set(RISCV_HOST_TAG linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_CROSSCOMPILING 1)
set(CMAKE_LIBRARY_ARCHITECTURE riscv64-linux-gnu)
set(ROS_DISTRO iron)

set(RISCV_TOOLCHAIN_PREFIX "riscv64-linux-gnu" CACHE STRING "RISC-V toolchain prefix")

set(CMAKE_C_COMPILER "${RISCV_TOOLCHAIN_PREFIX}-gcc-12")
set(CMAKE_CXX_COMPILER "${RISCV_TOOLCHAIN_PREFIX}-g++-12")
set(CMAKE_LINKER "${RISCV_TOOLCHAIN_PREFIX}-ld")
set(CMAKE_AR "${RISCV_TOOLCHAIN_PREFIX}-ar")
set(CMAKE_RANLIB "${RISCV_TOOLCHAIN_PREFIX}-ranlib")
set(CMAKE_STRIP "${RISCV_TOOLCHAIN_PREFIX}-strip")

include_directories(SYSTEM
    ${ROOT_FS_DIR}/usr/lib/gcc/riscv64-linux-gnu/12/include/
    ${ROOT_FS_DIR}/usr/include/riscv64-linux-gnu/c++/12
    ${ROOT_FS_DIR}/usr/include/riscv64-linux-gnu
    ${ROOT_FS_DIR}/usr/include/c++/12
    ${ROOT_FS_DIR}/usr/include
)

set(EIGEN3_INCLUDE_DIR "${ROOT_FS_DIR}/usr/include/eigen3")
set(EIGEN3_INCLUDE_DIRS "${EIGEN3_INCLUDE_DIR}")

set(CMAKE_SYSTEM_LIBRARY_PATH "${ROOT_FS_DIR}/usr/lib")
set(RISCV_LINKER_FLAGS "${RISCV_COMPILER_FLAGS} -L${ROOT_FS_DIR}/usr/lib/ -L${ROOT_FS_DIR}/usr/lib/riscv64-linux-gnu/ -L${ROOT_FS_DIR}/usr/lib/gcc/riscv64-linux-gnu/13/")

set(CMAKE_C_FLAGS             "${RISCV_COMPILER_FLAGS} ${CMAKE_C_FLAGS}")
set(CMAKE_CXX_FLAGS           "${RISCV_COMPILER_FLAGS} ${RISCV_COMPILER_FLAGS_CXX} ${CMAKE_CXX_FLAGS}")
set(CMAKE_ASM_FLAGS           "${RISCV_COMPILER_FLAGS} ${CMAKE_ASM_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG       "${RISCV_COMPILER_FLAGS_DEBUG} ${CMAKE_C_FLAGS_DEBUG}")
set(CMAKE_CXX_FLAGS_DEBUG     "${RISCV_COMPILER_FLAGS_DEBUG} ${CMAKE_CXX_FLAGS_DEBUG}")
set(CMAKE_ASM_FLAGS_DEBUG     "${RISCV_COMPILER_FLAGS_DEBUG} ${CMAKE_ASM_FLAGS_DEBUG}")
set(CMAKE_C_FLAGS_RELEASE     "${RISCV_COMPILER_FLAGS_RELEASE} ${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_RELEASE   "${RISCV_COMPILER_FLAGS_RELEASE} ${CMAKE_CXX_FLAGS_RELEASE}")
set(CMAKE_ASM_FLAGS_RELEASE   "${RISCV_COMPILER_FLAGS_RELEASE} ${CMAKE_ASM_FLAGS_RELEASE}")
set(CMAKE_SHARED_LINKER_FLAGS "${RISCV_LINKER_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS}")
set(CMAKE_MODULE_LINKER_FLAGS "${RISCV_LINKER_FLAGS} ${CMAKE_MODULE_LINKER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS    "${RISCV_LINKER_FLAGS} ${RISCV_LINKER_FLAGS_EXE} ${CMAKE_EXE_LINKER_FLAGS} -Wl,-rpath-link,/home/rosdev/git/starfive_ros2/ros2_ws/install/lib")

set(THREADS_PTHREAD_ARG "0" CACHE STRING "Result from TRY_RUN" FORCE)
# https://github.com/eProsima/Fast-DDS/issues/1262
#set(CMAKE_CXX_FLAGS "-latomic")

# set(CMAKE_INSTALL_RPATH ${ROOT_FS_DIR}/opt/ros/${ROS_DISTRO}/lib)
# set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

list(APPEND CMAKE_MODULE_PATH
    "/usr/share/cmake-3.22/Modules/"
    "/home/rosdev/git/starfive_ros2/ros2_ws/install/share/"
    "/home/rosdev/git/starfive_ros2/ros2_ws/install/share/ament_cmake_core/cmake"
    "${ROOT_FS_DIR}/usr/lib/riscv64-linux-gnu/cmake"
    "${ROOT_FS_DIR}/usr/share/eigen3"
)
# list(APPEND CMAKE_PREFIX_PATH
#     "/home/rosdev/git/starfive_ros2/ros2_ws/install/share"
#     "${ROOT_FS_DIR}/usr/lib/riscv64-linux-gnu/cmake"
#     "${ROOT_FS_DIR}/usr/share/eigen3"
# )
set(CMAKE_FIND_ROOT_PATH "/home/rosdev/git/starfive_ros2/ros2_ws/install;${ROOT_FS_DIR}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(PYTHON_SOABI cpython-311-x86_64-linux-gnu)
# set(PYTHON_SOABI cpython-311-riscv64-linux-gnu)
