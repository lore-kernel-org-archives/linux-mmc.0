From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 32/32] mmc: sdhci: fix SDHCI dependencies
Date: Fri, 25 Apr 2014 14:27:24 +0100
Message-ID: <E1WdgA0-00080w-1s@rmk-PC.arm.linux.org.uk>
References: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50714 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751606AbaDYN11 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 09:27:27 -0400
In-Reply-To: <20140425132245.GO26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/Kconfig | 63 ++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8aaf8c1f3f63..d8c1f31ab37f 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -25,8 +25,7 @@ config MMC_PXA
 	  If unsure, say N.
 
 config MMC_SDHCI
-	tristate "Secure Digital Host Controller Interface support"
-	depends on HAS_DMA
+	tristate
 	help
 	  This selects the generic Secure Digital Host Controller Interface.
 	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)
@@ -59,7 +58,8 @@ config MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
 
 config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
-	depends on MMC_SDHCI && PCI
+	depends on PCI && HAS_DMA
+	select MMC_SDHCI
 	help
 	  This selects the PCI Secure Digital Host Controller Interface.
 	  Most controllers found today are PCI devices.
@@ -83,7 +83,8 @@ config MMC_RICOH_MMC
 
 config MMC_SDHCI_ACPI
 	tristate "SDHCI support for ACPI enumerated SDHCI controllers"
-	depends on MMC_SDHCI && ACPI
+	depends on ACPI && HAS_DMA
+	select MMC_SDHCI
 	help
 	  This selects support for ACPI enumerated SDHCI controllers,
 	  identified by ACPI Compatibility ID PNP0D40 or specific
@@ -94,8 +95,8 @@ config MMC_SDHCI_ACPI
 	  If unsure, say N.
 
 config MMC_SDHCI_PLTFM
-	tristate "SDHCI platform and OF driver helper"
-	depends on MMC_SDHCI
+	tristate
+	select MMC_SDHCI
 	help
 	  This selects the common helper functions support for Secure Digital
 	  Host Controller Interface based platform and OF drivers.
@@ -106,8 +107,8 @@ config MMC_SDHCI_PLTFM
 
 config MMC_SDHCI_OF_ARASAN
 	tristate "SDHCI OF support for the Arasan SDHCI controllers"
-	depends on MMC_SDHCI_PLTFM
-	depends on OF
+	depends on OF && HAS_DMA
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
 	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
@@ -118,9 +119,9 @@ config MMC_SDHCI_OF_ARASAN
 
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
-	depends on MMC_SDHCI_PLTFM
-	depends on PPC_OF
+	depends on PPC_OF && HAS_DMA
 	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Freescale eSDHC controller support.
 
@@ -130,9 +131,9 @@ config MMC_SDHCI_OF_ESDHC
 
 config MMC_SDHCI_OF_HLWD
 	tristate "SDHCI OF support for the Nintendo Wii SDHCI controllers"
-	depends on MMC_SDHCI_PLTFM
-	depends on PPC_OF
+	depends on PPC_OF && HAS_DMA
 	select MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  found in the "Hollywood" chipset of the Nintendo Wii video game
@@ -144,8 +145,8 @@ config MMC_SDHCI_OF_HLWD
 
 config MMC_SDHCI_CNS3XXX
 	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
-	depends on ARCH_CNS3XXX
-	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_CNS3XXX && HAS_DMA
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the SDHCI support for CNS3xxx System-on-Chip devices.
 
@@ -155,9 +156,9 @@ config MMC_SDHCI_CNS3XXX
 
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
-	depends on ARCH_MXC
-	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_MXC && HAS_DMA
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Freescale eSDHC/uSDHC controller support
 	  found on i.MX25, i.MX35 i.MX5x and i.MX6x.
@@ -168,9 +169,9 @@ config MMC_SDHCI_ESDHC_IMX
 
 config MMC_SDHCI_DOVE
 	tristate "SDHCI support on Marvell's Dove SoC"
-	depends on ARCH_DOVE
-	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_DOVE && HAS_DMA
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Secure Digital Host Controller Interface in
 	  Marvell's Dove SoC.
@@ -181,9 +182,9 @@ config MMC_SDHCI_DOVE
 
 config MMC_SDHCI_TEGRA
 	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
-	depends on ARCH_TEGRA
-	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_TEGRA && HAS_DMA
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Tegra SD/MMC controller. If you have a Tegra
 	  platform with SD or MMC devices, say Y or M here.
@@ -192,7 +193,8 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG && HAS_DMA
+	select MMC_SDHCI
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
@@ -204,8 +206,8 @@ config MMC_SDHCI_S3C
 
 config MMC_SDHCI_SIRF
 	tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
-	depends on ARCH_SIRF
-	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_SIRF && HAS_DMA
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the SDHCI support for SiRF System-on-Chip devices.
 
@@ -215,8 +217,7 @@ config MMC_SDHCI_SIRF
 
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
-	depends on CLKDEV_LOOKUP
-	select MMC_SDHCI
+	depends on CLKDEV_LOOKUP && HAS_DMA
 	select MMC_SDHCI_PLTFM
 	default CPU_MMP2
 	help
@@ -228,8 +229,7 @@ config MMC_SDHCI_PXAV3
 
 config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
-	depends on CLKDEV_LOOKUP
-	select MMC_SDHCI
+	depends on CLKDEV_LOOKUP && HAS_DMA
 	select MMC_SDHCI_PLTFM
 	default CPU_PXA910
 	help
@@ -241,7 +241,8 @@ config MMC_SDHCI_PXAV2
 
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
-	depends on MMC_SDHCI && PLAT_SPEAR
+	depends on PLAT_SPEAR && HAS_DMA
+	select MMC_SDHCI
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the ST SPEAR range
@@ -263,7 +264,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE && HAS_DMA
 	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
@@ -274,9 +275,9 @@ config MMC_SDHCI_BCM_KONA
 
 config MMC_SDHCI_BCM2835
 	tristate "SDHCI platform support for the BCM2835 SD/MMC Controller"
-	depends on ARCH_BCM2835
-	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_BCM2835 && HAS_DMA
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the BCM2835 SD/MMC controller. If you have a BCM2835
 	  platform with SD or MMC devices, say Y or M here.
-- 
1.8.3.1

