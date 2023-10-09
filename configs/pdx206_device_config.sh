#!/bin/sh

aosp_version="android-13.0.0_r75" # from LineageOS/android/default.xml
lineageos_version="lineage-20.0" # from LineageOS/android.git's branch name
older_lineageos_version="lineage-19.1" # from LineageOS/android_prebuilts_gcc_linux-x86_{aarch64_aarch64,arm_arm}-linux-android-4.9.git's branch name
alt_lineageos_version="lineage-20" # from LineageOS/android_kernel_sony_sm8250.git's branch name

kernel_name="android_kernel_sony_sm8250" # LineageOS/android_kernel_sony_sm8250.git
device_name="pdx206" # device codename

# from LineageOS/android_kernel_sony_sm8250/arch/arm64/configs/pdx203_defconfig
# VERSION.PATCHLEVEL.SUBLEVEL-kernelsu-CONFIG_LOCALVERSION
kernel_version="4.19.275-kernelsu-perf"

# Downloads kernel source
download_kernel() {
    download_extract_and_clean \
	"$kernel_name" \
	"$kernel_name-$alt_lineageos_version.tar.gz" \
	"https://github.com/LineageOS/$kernel_name/archive/refs/heads/$alt_lineageos_version.tar.gz" \
	"github" \
	"$kernel_name-$alt_lineageos_version"
}

# Downloads AnyKernel3 configuration
download_anykernel3() {
	download_extract_and_clean \
	"AnyKernel3" \
	"AnyKernel3-$device_name.tar.gz" \
	"https://github.com/th1nhhdk/AnyKernel3/archive/refs/heads/$device_name.tar.gz" \
	"github" \
	"AnyKernel3-$device_name"
}

# from LineageOS/android_vendor_lineage/build/tasks/kernel.mk and LineageOS/android_vendor_lineage/config/BoardConfigKernel.mk
need_clang="true"
need_aarch64_gcc="true"
need_arm_gcc="true" # Add 32-bit GCC to PATH so that arm-linux-androidkernel-as is available for CONFIG_COMPAT_VDSO
need_tools_lineage="true"
need_build_tools="true"
need_misc="true" # from LineageOS/android_device_sony_sm8250-common/BoardConfigCommon.mk
want_kernelsu="true" # I want this

# also from LineageOS/android_vendor_lineage/build/tasks/kernel.mk and LineageOS/android_vendor_lineage/config/BoardConfigKernel.mk
path_override="PATH=$workdir/build/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$workdir/build/prebuilts/clang/kernel/linux-x86/clang-r416183b/bin:$workdir/build/prebuilts/tools-lineage/linux-x86/bin:$workdir/build/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin:$PATH \
			   LD_LIBRARY_PATH=$workdir/build/prebuilts/clang/kernel/linux-x86/clang-r416183b/lib64:$LD_LIBRARY_PATH \
			   PERL5LIB=$workdir/build/prebuilts/tools-lineage/common/perl-base \
			   BISON_PKGDATADIR=$workdir/build/prebuilts/build-tools/common/bison"
kernel_make_cmd="$workdir/build/prebuilts/build-tools/linux-x86/bin/make"

# from LineageOS/android_device_sony_sm8250-common/BoardConfigCommon.mk
kernel_make_flags="DTC_EXT=$workdir/build/prebuilts/misc/linux-x86/dtc/dtc \
		   		   DTC_OVERLAY_TEST_EXT=$workdir/build/prebuilts/misc/linux-x86/libufdt/ufdt_apply_overlay \
		   		   LLVM=1 \
		   		   LLVM_IAS=1"
kernel_build_out_prefix="out"
kernel_arch="arm64"
kernel_cross_compile="aarch64-linux-android-"
kernel_clang_triple="aarch64-linux-gnu-"
kernel_cc="'ccache clang --cuda-path=/dev/null'" # Without '' it will cause errors
