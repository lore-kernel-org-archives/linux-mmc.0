From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 4/5] mmc: msm_sdcc: Rename config MMC_MSM7X00A to MMC_MSM
Date: Thu, 29 Jul 2010 16:58:01 +0530
Message-ID: <1280402881-9331-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:36306 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934Ab0G2L2J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 07:28:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: san@google.com, Sahitya Tummala <stummala@codeaurora.org>

SD/MMC host controller driver is same for all MSM and QSD
platforms. Hence, rename the config to reflect the same.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 drivers/mmc/host/Kconfig  |    7 ++++---
 drivers/mmc/host/Makefile |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e171e77..2167e2f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -247,12 +247,13 @@ config MMC_IMX
 
 	  If unsure, say N.
 
-config MMC_MSM7X00A
-	tristate "Qualcomm MSM 7X00A SDCC Controller Support"
+config MMC_MSM
+	tristate "Qualcomm SDCC Controller Support"
 	depends on MMC && ARCH_MSM
 	help
 	  This provides support for the SD/MMC cell found in the
-          MSM 7X00A controllers from Qualcomm.
+	  MSM and QSD SOCs from Qualcomm. The controller also has
+	  support for SDIO devices.
 
 config MMC_MXC
 	tristate "Freescale i.MX2/3 Multimedia Card Interface support"
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e30c2ee..deb1918 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_MMC_OMAP_HS)	+= omap_hsmmc.o
 obj-$(CONFIG_MMC_AT91)		+= at91_mci.o
 obj-$(CONFIG_MMC_ATMELMCI)	+= atmel-mci.o
 obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
-obj-$(CONFIG_MMC_MSM7X00A)	+= msm_sdcc.o
+obj-$(CONFIG_MMC_MSM)		+= msm_sdcc.o
 obj-$(CONFIG_MMC_MVSDIO)	+= mvsdio.o
 obj-$(CONFIG_MMC_DAVINCI)       += davinci_mmc.o
 obj-$(CONFIG_MMC_SPI)		+= mmc_spi.o
-- 
1.7.1

--
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum.
