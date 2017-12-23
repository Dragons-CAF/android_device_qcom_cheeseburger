#
# Copyright (C) 2017 The DRAGONS-CAF Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

DEVICE_MANIFEST_FILE 	:= device/qcom/msm8998/manifest.xml
DEVICE_MATRIX_FILE   	:= device/qcom/common/compatibility_matrix.xml
DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8998/overlay

TARGET_KERNEL_VERSION := 4.4

TARGET_DISABLE_DASH := true

ifneq ($(TARGET_DISABLE_DASH), true)
   PRODUCT_BOOT_JARS += qcmediaplayer
endif

# Add support for whitelisted apps
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/whitelistedapps.xml:system/etc/whitelistedapps.xml

#Add soft home, back and multitask keys
PRODUCT_PROPERTY_OVERRIDES += \
   qemu.hw.mainkeys=0

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
   dalvik.vm.heapgrowthlimit=256m

$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/qcom/common/common64.mk)

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

#Android EGL implementation
PRODUCT_PACKAGES  += libGLES_android

PRODUCT_PACKAGES  += telephony-ext
PRODUCT_BOOT_JARS += tcmiface
PRODUCT_BOOT_JARS += telephony-ext
#PRODUCT_BOOT_JARS += WfdCommon
#PRODUCT_BOOT_JARS += oem-services

# Audio configuration file
-include $(TOPDIR)hardware/qcom/audio/configs/msm8998/msm8998.mk

#ANT+ stack
PRODUCT_PACKAGES += \
   AntHalService \
   libantradio \
   antradio_app \
   libvolumelistener

#Android_filesystem_config.h
PRODUCT_PACKAGES += \
   fs_config_files

#Android_net
PRODUCT_PACKAGES += \
   libandroid_net \
   libandroid_net_32

#Bluetooth SOC type
PRODUCT_PROPERTY_OVERRIDES += \
   qcom.bluetooth.soc=cherokee

#Camera
PRODUCT_PACKAGES += \
   camera.device@3.2-impl \
   camera.device@1.0-impl \
   android.hardware.camera.provider@2.4-impl \
   android.hardware.camera.provider@2.4-service

# Display/Graphics
PRODUCT_PACKAGES += \
   android.hardware.graphics.allocator@2.0-impl \
   android.hardware.graphics.allocator@2.0-service \
   android.hardware.graphics.mapper@2.0-impl \
   android.hardware.graphics.composer@2.1-impl \
   android.hardware.graphics.composer@2.1-service \
   android.hardware.memtrack@1.0-impl \
   android.hardware.memtrack@1.0-service \
   android.hardware.light@2.0-impl \
   android.hardware.light@2.0-service \
   android.hardware.configstore@1.0-service \
   android.hardware.broadcastradio@1.0-impl

PRODUCT_PACKAGES += \
   vendor.display.color@1.0-service \
   vendor.display.color@1.0-impl

#FBE Support
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/init.qti.qseecomd.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.qti.qseecomd.sh

#Healthd packages
PRODUCT_PACKAGES += \
   android.hardware.health@1.0-impl \
   android.hardware.health@1.0-convert \
   android.hardware.health@1.0-service \
   libhealthd.msm

#HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.manager@1.0

# Media/Video Codec configuration files
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/media_profiles.xml:system/etc/media_profiles.xml \
   device/qcom/msm8998/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml \
   device/qcom/msm8998/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
   device/qcom/msm8998/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
endif

#Media
PRODUCT_PACKAGES += \
   android.hardware.media.omx@1.0-impl

#Exclude TOF sensor from InputManager
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/excluded-input-devices.xml:system/etc/excluded-input-devices.xml

#MIDI feature
PRODUCT_COPY_FILES += \
   frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

#MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

#OpenGLES EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
   frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

#OpenGLES
PRODUCT_PROPERTY_OVERRIDES  += \
   ro.opengles.version=196610

#Powerhint configuration file
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

#Power
PRODUCT_PACKAGES += \
   android.hardware.power@1.0-service \
   android.hardware.power@1.0-impl

#RIL
PRODUCT_PROPERTY_OVERRIDES += \
   rild.libpath=/system/vendor/lib64/libril-qc-qmi-1.so

#Sensor features
PRODUCT_COPY_FILES += \
   frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
   frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
   frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
   frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
   frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
   frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
   frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
   frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
   frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
   frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
   frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml

#Sensor HAL conf file
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

#Sensor Packages
PRODUCT_PACKAGES += \
   libsensor1_system \
   libsensor_reg_system \
   libqmi_cci_system \
   libdiag_system

#Thermal
PRODUCT_PACKAGES += \
   android.hardware.thermal@1.0-impl \
   android.hardware.thermal@1.0-service

#USB
PRODUCT_PACKAGES += \
   android.hardware.usb@1.0-service

#Vibrator
PRODUCT_PACKAGES += \
   android.hardware.vibrator@1.0-impl \
   android.hardware.vibrator@1.0-service

#Video Seccomp policy files
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
   device/qcom/msm8998/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

#VR
PRODUCT_COPY_FILES += \
   frameworks/native/data/etc/android.hardware.vr.high_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.high_performance.xml

#VR Packages
PRODUCT_PACKAGES += \
   android.hardware.vr@1.0-impl \
   android.hardware.vr@1.0-service

# List of AAPT configurations
PRODUCT_AAPT_CONFIG += xlarge large

#Wifi
PRODUCT_PACKAGES += \
   wificond \
   wifilogd \
   wpa_supplicant_overlay.conf \
   p2p_supplicant_overlay.conf

# WLAN host driver
ifneq ($(WLAN_CHIPSET),)
PRODUCT_PACKAGES += $(WLAN_CHIPSET)_wlan.ko
endif

# WLAN driver configuration file
PRODUCT_COPY_FILES += \
   device/qcom/msm8998/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini \
   device/qcom/msm8998/wifi/wifi_concurrency_cfg.txt:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wifi_concurrency_cfg.txt

#Enable QTI KEYMASTER and GATEKEEPER HIDLs
ifeq ($(ENABLE_VENDOR_IMAGE), true)
KMGK_USE_QTI_SERVICE := true
endif

#Enable AOSP KEYMASTER and GATEKEEPER HIDLs
ifneq ($(KMGK_USE_QTI_SERVICE), true)
PRODUCT_PACKAGES += \
   android.hardware.gatekeeper@1.0-impl \
   android.hardware.gatekeeper@1.0-service \
   android.hardware.keymaster@3.0-impl \
   android.hardware.keymaster@3.0-service
endif

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

$(call inherit-product-if-exists, vendor/oneplus/prebuilt.mk)
$(call inherit-product-if-exists, device/qcom/msm8998/device-vendor.mk)
