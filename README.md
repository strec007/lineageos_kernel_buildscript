# lineageos_kernel_buildscript

Build LineageOS kernel with KernelSU (or not) without having to download unnecessary AOSP or LineageOS source code.

## How to use

```bash
build.sh download_sources
# build.sh kernel_defconfig  # optional
# build.sh kernel_menuconfig # optional: basically "make menuconfig"
build.sh build_kernel
build.sh make_anykernel3_zip
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
