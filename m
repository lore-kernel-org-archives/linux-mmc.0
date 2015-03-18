From: Yaniv Gardi <ygardi@codeaurora.org>
Subject: [PATCH v1] qcom: opensource: mmc-utils: fix building errors
Date: Wed, 18 Mar 2015 11:35:51 +0200
Message-ID: <1426671352-5529-1-git-send-email-ygardi@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@printf.net, linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

3rd party HMAC SHA256 implementation has been added to the driver,
and since driver common code (mmc_cmds.c) includes calling to
routines and data structures that reside in these 3rd party files
(under 3rdparty\hmac_sha) these files should be compiled as well
in Android.mk makefile.

Change-Id: Ica1ea5e4c7b8efecfba07c35f87ea6bb6716b668
Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
---
 Android.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Android.mk b/Android.mk
index 7c8cce4..4b7afb1 100644
--- a/Android.mk
+++ b/Android.mk
@@ -3,6 +3,7 @@ LOCAL_PATH:= $(call my-dir)
 include $(CLEAR_VARS)
 LOCAL_MODULE_TAGS := optional
 LOCAL_SRC_FILES:= mmc.c mmc_cmds.c
+LOCAL_SRC_FILES += 3rdparty/hmac_sha/sha2.c 3rdparty/hmac_sha/hmac_sha2.c
 LOCAL_MODULE := mmc_utils
 LOCAL_SHARED_LIBRARIES := libcutils libc
 LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
-- 
1.8.5.2

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
