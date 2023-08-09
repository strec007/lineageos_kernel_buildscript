# lineageos_kernel_buildscript

Build LineageOS kernel with KernelSU (or not) without having to download unnecessary AOSP or LineageOS source code.

## How to use

Rename device configuration file to `device_config.sh` before running `build.sh`, for example:

```bash
mv device_config.sh pdx203_device_config.sh # avoid conflict
mv pdx206_device_config.sh device_config.sh # we are now building for pdx206
```

```bash
build.sh download_sources
# build.sh kernel_defconfig  # optional: build_kernel will check and run it for you if it can't find .config
# build.sh kernel_menuconfig # optional: basically "make menuconfig"
build.sh build_kernel
build.sh make_anykernel3_zip
```

Or use this command to build for both `pdx203` and `pdx206`:

```bash
rm -rf ./build && ./build.sh download_sources && ./build.sh build_kernel && ./build.sh make_anykernel3_zip && mv device_config.sh pdx203_device_config.sh && mv pdx206_device_config.sh device_config.sh && rm -rf build/android_kernel_sony_sm8250/out build/AnyKernel3 && ./build.sh download_sources && ./build.sh build_kernel && ./build.sh make_anykernel3_zip && mv device_config.sh pdx206_device_config.sh && mv pdx203_device_config.sh device_config.sh && rm -rf build/android_kernel_sony_sm8250/out build/AnyKernel3 && ./build.sh download_sources
```

## Notices for WSL users

please remove `/mnt/?` from your `PATH` because it can and will cause conflicts

```
echo $PATH
# only get parts that don't have /mnt/<something>
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/wsl/lib"
```

## Differences compared to building by the LineageOS way

- none (as far as I know)

## Roadblocks for macOS support

- `sed` commands might not work.
- I don't have a macOS machine to test on
