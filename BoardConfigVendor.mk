#
# Qualcomm Technologies proprietary product specific compile-time definitions
#

USE_SOC_HW_VERSION := true
SOC_HW_VERSION := 0x30020000
SOC_VERS := 0x3005

DEVICE_PACKAGE_OVERLAYS += vendor/qcom/proprietary/common/msm8998/overlay

#QCNE 
BOARD_USES_QCNE := true
BOARD_USES_LIBC_WRAPPER := true
BOARD_USES_DPM := true

TARGET_USES_IMS := true
TARGET_FASTCV_DISABLED := true

# GenSec Image generation of signed apps bootloader
USESECIMAGETOOL := true
QTI_GENSECIMAGE_MSM_IDS := msm8998
QTI_GENSECIMAGE_SIGNED_DEFAULT := msm8998

#SECIMAGE tool feature flags
USES_SEC_POLICY_MULTIPLE_DEFAULT_SIGN := 1
USES_SEC_POLICY_INTEGRITY_CHECK := 1

CONFIG_EAP_PROXY := dummy
CONFIG_EAP_PROXY_DUAL_SIM := true
CONFIG_EAP_PROXY_AKA_PRIME := true
CONFIG_EAP_PROXY_MDM_DETECT := true

# TODO: Bring-up exception - all modules must be fixed by corresponding teams
INTERNAL_LOCAL_CLANG_EXCEPTION_PROJECTS += \
  $(abspath $(TOPDIR)vendor/qcom/proprietary/gles/adreno200) \
  vendor/qcom/proprietary/gles/adreno200 \
  vendor/qcom/proprietary/fastcv-noship \
  vendor/qcom/proprietary/kernel-tests \
  vendor/qcom/proprietary/mare-noship \
  vendor/qcom/proprietary/mm-camera-lib \
  vendor/qcom/proprietary/mm-camera/mm-camera2/media-controller/modules/imglib \
  vendor/qcom/proprietary/mm-camera/mm-camera2/tests \
  vendor/qcom/proprietary/mm-mux

# TODO: Bring-up exception - all modules must be fixed by corresponding teams
TARGET_CINCLUDES_EXCEPTION_PROJECTS := \
  $(abspath $(TOPDIR)vendor/qcom/proprietary/gles/adreno200) \
  vendor/qcom/proprietary/gles/adreno200 \
  disregard/filesystems/mtd-utils

possible_cvv_dirs = $(QCPATH)/prebuilt_HY11 $(QCPATH)/prebuilt_HY22 $(QCPATH)/prebuilt_grease
prebuilt_cvv_dirs =  $(wildcard $(possible_cvv_dirs))
ifneq ($(prebuilt_cvv_dirs),)
ifneq ($(TARGET_BOARD_SUFFIX),)
$(shell for i in $(prebuilt_cvv_dirs);do echo -e "optional_subdirs = [\n    \"target/product/$(TARGET_BOARD_PLATFORM)$(TARGET_BOARD_SUFFIX)\",\n]" > $$i/Android.bp;done)
else
$(shell for i in $(prebuilt_cvv_dirs);do echo -e "optional_subdirs = [\n    \"target/product/$(TARGET_BOARD_PLATFORM)\",\n]" > $$i/Android.bp;done;)
endif
endif
