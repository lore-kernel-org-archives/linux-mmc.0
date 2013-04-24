From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v1] mmc-utils: adding support for Android compilation
Date: Wed, 24 Apr 2013 14:51:26 +0300
Message-ID: <1366804286-16571-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
---
 Android.mk |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 Android.mk

diff --git a/Android.mk b/Android.mk
new file mode 100644
index 0000000..7c8cce4
--- /dev/null
+++ b/Android.mk
@@ -0,0 +1,11 @@
+LOCAL_PATH:= $(call my-dir)
+
+include $(CLEAR_VARS)
+LOCAL_MODULE_TAGS := optional
+LOCAL_SRC_FILES:= mmc.c mmc_cmds.c
+LOCAL_MODULE := mmc_utils
+LOCAL_SHARED_LIBRARIES := libcutils libc
+LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
+LOCAL_ADDITIONAL_DEPENDENCIES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
+LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/mmc-utils
+include $(BUILD_EXECUTABLE)
-- 
1.7.6
