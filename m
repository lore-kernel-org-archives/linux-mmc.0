Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E06C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64872083B
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599075525;
	bh=qxHpI9VyGlXpIWP3hwXS5+ef8YBl4vmhkjD5Ax1kZz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B25if0vGsbxV5fDOsluZvTGyv/PTmqEQIXQZ6KoQq1daQmbgSnZVz2kwdIvpo//Ro
	 /ei6Q1FuisM6y8U69G/8AWih33bN2H+3Qd584VNbko6+ts/kJcfaOOHiK+VHuSApW2
	 ODb5DMOeNFd62uIdb9DmvM7mLZwKhc2Iq+dJoirI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIBTip (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:38:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgIBTin (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Sep 2020 15:38:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D215A208C7;
        Wed,  2 Sep 2020 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599075522;
        bh=qxHpI9VyGlXpIWP3hwXS5+ef8YBl4vmhkjD5Ax1kZz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aeasc5JCSciX/htg5ZgdWqiYw3u7H+lqBBKWvWicy7LIxztFECBY8U+6neLf3OdVK
         jN7O2wtWA9wCYdQy76WzC6mB64ObA2O0uG3boBg9H2IpGXnyY9vzInvnJOgs8kXWyG
         NpHPToWJ4OQpIA0egcbpORdAstDIl66QU+LvbZBQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 11/11] mmc: host: Enable compile testing of multiple drivers
Date:   Wed,  2 Sep 2020 21:36:58 +0200
Message-Id: <20200902193658.20539-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902193658.20539-1-krzk@kernel.org>
References: <20200902193658.20539-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Multiple MMC host controller driver can be compile tested as they do not
depend on architecture specific headers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/Kconfig | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b95f79f53395..ff5a88faf877 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -178,7 +178,7 @@ config MMC_SDHCI_OF_AT91
 config MMC_SDHCI_OF_ESDHC
 	tristate "SDHCI OF support for the Freescale eSDHC controller"
 	depends on MMC_SDHCI_PLTFM
-	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
+	depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE || COMPILE_TEST
 	select MMC_SDHCI_IO_ACCESSORS
 	select FSL_GUTS
 	help
@@ -216,7 +216,7 @@ config MMC_SDHCI_OF_DWCMSHC
 config MMC_SDHCI_OF_SPARX5
 	tristate "SDHCI OF support for the MCHP Sparx5 SoC"
 	depends on MMC_SDHCI_PLTFM
-	depends on ARCH_SPARX5
+	depends on ARCH_SPARX5 || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  found in the MCHP Sparx5 SoC.
@@ -238,7 +238,7 @@ config MMC_SDHCI_CADENCE
 
 config MMC_SDHCI_CNS3XXX
 	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
-	depends on ARCH_CNS3XXX
+	depends on ARCH_CNS3XXX || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects the SDHCI support for CNS3xxx System-on-Chip devices.
@@ -262,7 +262,7 @@ config MMC_SDHCI_ESDHC_MCF
 
 config MMC_SDHCI_ESDHC_IMX
 	tristate "SDHCI support for the Freescale eSDHC/uSDHC i.MX controller"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
@@ -276,7 +276,7 @@ config MMC_SDHCI_ESDHC_IMX
 
 config MMC_SDHCI_DOVE
 	tristate "SDHCI support on Marvell's Dove SoC"
-	depends on ARCH_DOVE || MACH_DOVE
+	depends on ARCH_DOVE || MACH_DOVE || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -289,7 +289,7 @@ config MMC_SDHCI_DOVE
 
 config MMC_SDHCI_TEGRA
 	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
-	depends on ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_CQHCI
@@ -301,7 +301,8 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS)
+	depends on MMC_SDHCI
+	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
@@ -313,7 +314,7 @@ config MMC_SDHCI_S3C
 
 config MMC_SDHCI_SIRF
 	tristate "SDHCI support on CSR SiRFprimaII and SiRFmarco SoCs"
-	depends on ARCH_SIRF
+	depends on ARCH_SIRF || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -351,7 +352,8 @@ config MMC_SDHCI_PXAV2
 
 config MMC_SDHCI_SPEAR
 	tristate "SDHCI support on ST SPEAr platform"
-	depends on MMC_SDHCI && PLAT_SPEAR
+	depends on MMC_SDHCI
+	depends on PLAT_SPEAR || COMPILE_TEST
 	depends on OF
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
@@ -374,7 +376,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
-	depends on ARCH_BCM_MOBILE
+	depends on ARCH_BCM_MOBILE || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
@@ -422,7 +424,8 @@ config MMC_SDHCI_IPROC
 
 config MMC_MESON_GX
 	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
-	depends on ARCH_MESON && MMC
+	depends on MMC
+	depends on ARCH_MESON|| COMPILE_TEST
 	help
 	  This selects support for the Amlogic SD/MMC Host Controller
 	  found on the S905/GX*/AXG family of SoCs.  This controller is
@@ -458,7 +461,8 @@ config MMC_MESON_MX_SDIO
 
 config MMC_MOXART
 	tristate "MOXART SD/MMC Host Controller support"
-	depends on ARCH_MOXART && MMC
+	depends on MMC
+	depends on ARCH_MOXART || COMPILE_TEST
 	help
 	  This selects support for the MOXART SD/MMC Host Controller.
 	  MOXA provides one multi-functional card reader which can
@@ -467,7 +471,7 @@ config MMC_MOXART
 
 config MMC_SDHCI_ST
 	tristate "SDHCI support on STMicroelectronics SoC"
-	depends on ARCH_STI || FSP2
+	depends on ARCH_STI || FSP2 || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -587,7 +591,7 @@ config MMC_TIFM_SD
 
 config MMC_MVSDIO
 	tristate "Marvell MMC/SD/SDIO host driver"
-	depends on PLAT_ORION
+	depends on PLAT_ORION || (COMPILE_TEST && ARM)
 	depends on OF
 	help
 	  This selects the Marvell SDIO host driver.
@@ -599,7 +603,7 @@ config MMC_MVSDIO
 
 config MMC_DAVINCI
 	tristate "TI DAVINCI Multimedia Card Interface support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || COMPILE_TEST
 	help
 	  This selects the TI DAVINCI Multimedia card Interface.
 	  If you have an DAVINCI board with a Multimedia Card slot,
@@ -628,7 +632,7 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX
+	depends on ARCH_S3C24XX || COMPILE_TEST
 	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
@@ -681,7 +685,7 @@ config MMC_SDRICOH_CS
 
 config MMC_SDHCI_SPRD
 	tristate "Spreadtrum SDIO host Controller"
-	depends on ARCH_SPRD
+	depends on ARCH_SPRD || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_HSQ
@@ -698,7 +702,7 @@ config MMC_TMIO_CORE
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3
+	depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
@@ -971,7 +975,7 @@ config MMC_REALTEK_USB
 
 config MMC_SUNXI
 	tristate "Allwinner sunxi SD/MMC Host Controller support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Allwinner sunxi SoCs.
-- 
2.17.1

