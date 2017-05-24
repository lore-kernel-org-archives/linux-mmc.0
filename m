From: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] mmc: host: tighten some of the dependencies on SoC drivers
Date: Wed, 24 May 2017 13:15:56 +0100
Message-ID: <20170524121556.27819-1-pbrobinson@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34758 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763740AbdEXMQD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2017 08:16:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so46914142wmf.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2017 05:16:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>

Cleanup and tighten some of the dependencies for SoC specific hardware, remove a
duplication on MMC_SDHI, and add COMPILE_TEST where we add SoC specifics to
ensure continued build coverage.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/mmc/host/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2db84dd664d7..a2818c813499 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -134,6 +134,7 @@ config MMC_SDHCI_OF_ARASAN
 config MMC_SDHCI_OF_AT91
 	tristate "SDHCI OF support for the Atmel SDMMC controller"
 	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_AT91 || COMPILE_TEST
 	depends on OF
 	help
 	  This selects the Atmel SDMMC driver
@@ -572,7 +573,6 @@ config MMC_TMIO
 
 config MMC_SDHI
 	tristate "SH-Mobile SDHI SD/SDIO controller support"
-	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
@@ -634,7 +634,7 @@ config MMC_CAVIUM_OCTEON
 
 config MMC_CAVIUM_THUNDERX
 	tristate "Cavium ThunderX SD/MMC Card Interface support"
-	depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
+	depends on PCI && 64BIT && (ARCH_THUNDER || COMPILE_TEST)
 	depends on GPIOLIB
 	depends on OF_ADDRESS
 	help
@@ -836,6 +836,7 @@ config MMC_BCM2835
 
 config MMC_MTK
 	tristate "MediaTek SD/MMC Card Interface support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on HAS_DMA
 	help
 	  This selects the MediaTek(R) Secure digital and Multimedia card Interface.
@@ -866,6 +867,7 @@ config MMC_SDHCI_BRCMSTB
 
 config MMC_SDHCI_XENON
 	tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects Marvell Xenon eMMC/SD/SDIO SDHCI.
-- 
2.13.0

