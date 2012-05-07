From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 04/10] mmc: mxs-mmc: move header from mach into linux folder
Date: Mon,  7 May 2012 22:43:06 +0800
Message-ID: <1336401793-13753-5-git-send-email-shawn.guo@linaro.org>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46809 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab2EGOnc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 10:43:32 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1335513dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 07:43:32 -0700 (PDT)
In-Reply-To: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Shawn Guo <shawn.guo@linaro.org>

Rename arch/arm/mach-mxs/include/mach/mmc.h to
include/linux/mmc/mxs-mmc.h, so that mxs-mmc driver becomes
<mach/*> inclusion free.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/include/mach/devices-common.h    |    2 +-
 drivers/mmc/host/mxs-mmc.c                         |    3 +--
 .../mach/mmc.h => include/linux/mmc/mxs-mmc.h      |    7 ++++---
 3 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/mach-mxs/include/mach/mmc.h => include/linux/mmc/mxs-mmc.h (81%)

diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 2b37689..6fc0601 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -87,7 +87,7 @@ struct platform_device * __init mxs_add_mxs_i2c(
 		const struct mxs_mxs_i2c_data *data);
 
 /* mmc */
-#include <mach/mmc.h>
+#include <linux/mmc/mxs-mmc.h>
 struct mxs_mxs_mmc_data {
 	const char *devid;
 	int id;
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 54bbb8b..c70c7c7 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -41,8 +41,7 @@
 #include <linux/fsl/mxs-dma.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/stmp_device.h>
-
-#include <mach/mmc.h>
+#include <linux/mmc/mxs-mmc.h>
 
 #define DRIVER_NAME	"mxs-mmc"
 
diff --git a/arch/arm/mach-mxs/include/mach/mmc.h b/include/linux/mmc/mxs-mmc.h
similarity index 81%
rename from arch/arm/mach-mxs/include/mach/mmc.h
rename to include/linux/mmc/mxs-mmc.h
index 211547a..7c2ad3a 100644
--- a/arch/arm/mach-mxs/include/mach/mmc.h
+++ b/include/linux/mmc/mxs-mmc.h
@@ -6,8 +6,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __MACH_MXS_MMC_H__
-#define __MACH_MXS_MMC_H__
+#ifndef __LINUX_MMC_MXS_MMC_H__
+#define __LINUX_MMC_MXS_MMC_H__
 
 struct mxs_mmc_platform_data {
 	int wp_gpio;	/* write protect pin */
@@ -15,4 +15,5 @@ struct mxs_mmc_platform_data {
 #define SLOTF_4_BIT_CAPABLE	(1 << 0)
 #define SLOTF_8_BIT_CAPABLE	(1 << 1)
 };
-#endif /* __MACH_MXS_MMC_H__ */
+
+#endif /* __LINUX_MMC_MXS_MMC_H__ */
-- 
1.7.5.4

