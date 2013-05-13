From: merez@codeaurora.org
Subject: Re: [PATCH v1] mmc-utils: adding support for Android compilation
Date: Mon, 13 May 2013 13:44:48 -0700
Message-ID: <0516225f37312c1ad8f68ecb14c01d6a.squirrel@www.codeaurora.org>
References: <1366804286-16571-1-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1366804286-16571-1-git-send-email-ygardi@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Can you please merge this patch to mmc-utils?

Thanks,
Maya
> Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
> ---
>  Android.mk |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>  create mode 100644 Android.mk
>
> diff --git a/Android.mk b/Android.mk
> new file mode 100644
> index 0000000..7c8cce4
> --- /dev/null
> +++ b/Android.mk
> @@ -0,0 +1,11 @@
> +LOCAL_PATH:= $(call my-dir)
> +
> +include $(CLEAR_VARS)
> +LOCAL_MODULE_TAGS := optional
> +LOCAL_SRC_FILES:= mmc.c mmc_cmds.c
> +LOCAL_MODULE := mmc_utils
> +LOCAL_SHARED_LIBRARIES := libcutils libc
> +LOCAL_C_INCLUDES+= $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
> +LOCAL_ADDITIONAL_DEPENDENCIES +=
> $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
> +LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/mmc-utils
> +include $(BUILD_EXECUTABLE)
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Maya Erez
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
