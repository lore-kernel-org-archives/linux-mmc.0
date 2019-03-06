From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] drivers: mmc: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 19:27:51 +0100
Message-ID: <1551896871-30654-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/mmc/host/Kconfig | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 28fcd8f..de7a38d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -437,7 +437,7 @@ config MMC_WBSD
 	depends on ISA_DMA_API
 	help
 	  This selects the Winbond(R) W83L51xD Secure digital and
-          Multimedia card Interface.
+	  Multimedia card Interface.
 	  If you have a machine with a integrated W83L518D or W83L519D
 	  SD/MMC card reader, say Y or M here.
 
@@ -515,7 +515,7 @@ config MMC_TIFM_SD
 	  'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
 	  (TIFM_7XX1)'.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called tifm_sd.
 
 config MMC_MVSDIO
@@ -531,12 +531,12 @@ config MMC_MVSDIO
 	  module will be called mvsdio.
 
 config MMC_DAVINCI
-        tristate "TI DAVINCI Multimedia Card Interface support"
-        depends on ARCH_DAVINCI
-        help
-          This selects the TI DAVINCI Multimedia card Interface.
-          If you have an DAVINCI board with a Multimedia Card slot,
-          say Y or M here.  If unsure, say N.
+	tristate "TI DAVINCI Multimedia Card Interface support"
+	depends on ARCH_DAVINCI
+	help
+	  This selects the TI DAVINCI Multimedia card Interface.
+	  If you have an DAVINCI board with a Multimedia Card slot,
+	  say Y or M here.  If unsure, say N.
 
 config MMC_GOLDFISH
 	tristate "goldfish qemu Multimedia Card Interface support"
@@ -565,18 +565,18 @@ config MMC_S3C
 	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
-          Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
+	  Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
 	  If you have a board based on one of those and a MMC/SD
 	  slot, say Y or M here.
 
 	  If unsure, say N.
 
 config MMC_S3C_HW_SDIO_IRQ
-       bool "Hardware support for SDIO IRQ"
-       depends on MMC_S3C
-       help
-         Enable the hardware support for SDIO interrupts instead of using
-	 the generic polling code.
+	bool "Hardware support for SDIO IRQ"
+	depends on MMC_S3C
+	help
+	  Enable the hardware support for SDIO interrupts instead of using
+	  the generic polling code.
 
 choice
 	prompt "Samsung S3C SD/MMC transfer code"
@@ -948,15 +948,16 @@ config MMC_MTK
 	  If unsure, say N.
 
 config MMC_SDHCI_MICROCHIP_PIC32
-        tristate "Microchip PIC32MZDA SDHCI support"
-        depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
-        help
-          This selects the Secure Digital Host Controller Interface (SDHCI)
-          for PIC32MZDA platform.
+	tristate "Microchip PIC32MZDA SDHCI support"
+	depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  for PIC32MZDA platform.
+
+	  If you have a controller with this interface, say Y or M here.
 
-          If you have a controller with this interface, say Y or M here.
+	  If unsure, say N.
 
-          If unsure, say N.
 config MMC_SDHCI_BRCMSTB
 	tristate "Broadcom SDIO/SD/MMC support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
-- 
1.9.1
