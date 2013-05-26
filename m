From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v1] mmc-utils: adding support for Android compilation
Date: Sun, 26 May 2013 13:22:51 -0400
Message-ID: <87li71r6z8.fsf@octavius.laptop.org>
References: <1366804286-16571-1-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1366804286-16571-1-git-send-email-ygardi@codeaurora.org> (Yaniv
	Gardi's message of "Wed, 24 Apr 2013 14:51:26 +0300")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Apr 24 2013, Yaniv Gardi wrote:
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
> +LOCAL_ADDITIONAL_DEPENDENCIES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
> +LOCAL_MODULE_PATH := $(TARGET_OUT_DATA)/mmc-utils
> +include $(BUILD_EXECUTABLE)

Thanks, pushed to mmc-utils.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
