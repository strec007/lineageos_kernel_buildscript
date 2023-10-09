#!/bin/sh
set -e

echo "=> Building for all device configuration in ./configs/ ..."

for cfg in $(ls ./configs/); do
    echo "==> Now building for $cfg ..."
    ln -sf ./configs/$cfg ./device_config.sh
    rm -rf ./build
    ./build.sh download_sources
    ./build.sh build_kernel
    ./build.sh make_anykernel3_zip
done

echo "=> Done!"