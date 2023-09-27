#!/usr/bin/env bash

SCRIPT_PATH=$(dirname $(realpath ${BASH_SOURCE:-$0}))
set -o errexit -o pipefail -o noclobber -o nounset

export ROS_DISTRO=iron
CLEAN_BUILD=false
TOOLCHAIN_FILE=$(pwd)/toolchain-riscv.cmake
COLCON_ARGS=""
VERBOSE_CMAKE=OFF
COLCON_EV_HANDLERS=""
CMAKE_BUILD_TYPE=Release

while [[ "$#" -gt 0 ]]; do
    case $1 in
    -c | --clean) CLEAN_BUILD=true ;;
    -t | --toolchain-file) TOOLCHAIN_FILE=$2 shift ;;
    -v | --verbose) VERBOSE_CMAKE=ON COLCON_EV_HANDLERS="--event-handlers console_direct+" ;;
    -r | --release) CMAKE_BUILD_TYPE=Release ;;
    *) COLCON_ARGS=("$COLCON_ARGS $1") ;;
    esac
    shift
done

if [ "$CLEAN_BUILD" = true ]; then
    rm -rf ros2_ws/build ros2_ws/install ros2_ws/log
fi

CMAKE_ARGS="-DROOT_FS_DIR=$SCRIPT_PATH/root_fs \
    -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN_FILE \
    -DCMAKE_VERBOSE_MAKEFILE=$VERBOSE_CMAKE \
    -DBUILD_TESTING:BOOL=OFF \
    -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE"

pushd ros2_ws
colcon build $COLCON_EV_HANDLERS \
    $COLCON_ARGS \
    --merge-install \
    --cmake-force-configure \
    --cmake-args $CMAKE_ARGS
popd
