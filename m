Return-Path: <SRS0=qSan=CQ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBFBC43461
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F35E21473
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Sep 2020 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599476004;
	bh=ThKW+TJAvXsEawfQDKH67ikL2SFZLnmlMOChoh4t09A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OyQpOJnVvDoR98cE51404MeWrEkxbHK+jlrCFGHgIt/vkAjxdvaHnvwQ4xbu4axf7
	 kmHmtaE5KrPT/uQz8R5DT5LDXX+Hx/Xa/TKsiI8kDd6SqTGzdiPKno2XGHpoLpvhJL
	 H+vGFSRUrFp5zPZGneP+4xvTD4YarH2QW1G/z6D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgIGKxG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgIGKxE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 7 Sep 2020 06:53:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C32206D4;
        Mon,  7 Sep 2020 10:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599475983;
        bh=ThKW+TJAvXsEawfQDKH67ikL2SFZLnmlMOChoh4t09A=;
        h=From:To:Cc:Subject:Date:From;
        b=2s4iJzOAw0AwfDl3+vGO63NsZ/wes/p5awzY0787hAdKN7DWSQBN+dujhUorptTgs
         B/MGVeDfGBYd7CBs+MN+St91SKdMBoWlU0j3JO5YVxLgKjqDjxleNc4wcbgIh40HO/
         0eeBWlD+1ooQHeudSrz5DoptJXgnymkcgKelCHrU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3] mmc: host: Enable compile testing of multiple drivers
Date:   Mon,  7 Sep 2020 12:52:54 +0200
Message-Id: <20200907105254.31097-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Multiple MMC host controller driver can be compile tested as they do not
depend on architecture specific headers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Rebase.

Please expect conflicts around MMC_SDHCI_S3C with:
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=next/soc-s3c-cleanup

Possible resolution:
-depends on PLAT_SAMSUNG || COMPILE_TEST
+depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
---
 drivers/mmc/host/Kconfig | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index ddbed6f41c41..dc646359b4ff 100644
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
-	depends on MMC_SDHCI && PLAT_SAMSUNG
+	depends on MMC_SDHCI
+	depends on PLAT_SAMSUNG || COMPILE_TEST
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
@@ -422,7 +424,7 @@ config MMC_SDHCI_IPROC
 
 config MMC_MESON_GX
 	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
-	depends on ARCH_MESON
+	depends on ARCH_MESON|| COMPILE_TEST
 	help
 	  This selects support for the Amlogic SD/MMC Host Controller
 	  found on the S905/GX*/AXG family of SoCs.  This controller is
@@ -458,7 +460,7 @@ config MMC_MESON_MX_SDIO
 
 config MMC_MOXART
 	tristate "MOXART SD/MMC Host Controller support"
-	depends on ARCH_MOXART
+	depends on ARCH_MOXART || COMPILE_TEST
 	help
 	  This selects support for the MOXART SD/MMC Host Controller.
 	  MOXA provides one multi-functional card reader which can
@@ -467,7 +469,7 @@ config MMC_MOXART
 
 config MMC_SDHCI_ST
 	tristate "SDHCI support on STMicroelectronics SoC"
-	depends on ARCH_STI || FSP2
+	depends on ARCH_STI || FSP2 || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
@@ -587,7 +589,7 @@ config MMC_TIFM_SD
 
 config MMC_MVSDIO
 	tristate "Marvell MMC/SD/SDIO host driver"
-	depends on PLAT_ORION
+	depends on PLAT_ORION || (COMPILE_TEST && ARM)
 	depends on OF
 	help
 	  This selects the Marvell SDIO host driver.
@@ -599,7 +601,7 @@ config MMC_MVSDIO
 
 config MMC_DAVINCI
 	tristate "TI DAVINCI Multimedia Card Interface support"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || COMPILE_TEST
 	help
 	  This selects the TI DAVINCI Multimedia card Interface.
 	  If you have an DAVINCI board with a Multimedia Card slot,
@@ -628,7 +630,7 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX
+	depends on ARCH_S3C24XX || COMPILE_TEST
 	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
@@ -681,7 +683,7 @@ config MMC_SDRICOH_CS
 
 config MMC_SDHCI_SPRD
 	tristate "Spreadtrum SDIO host Controller"
-	depends on ARCH_SPRD
+	depends on ARCH_SPRD || COMPILE_TEST
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	select MMC_HSQ
@@ -698,7 +700,7 @@ config MMC_TMIO_CORE
 
 config MMC_TMIO
 	tristate "Toshiba Mobile IO Controller (TMIO) MMC/SD function support"
-	depends on MFD_TMIO || MFD_ASIC3
+	depends on MFD_TMIO || MFD_ASIC3 || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SD/MMC cell found in TC6393XB,
@@ -971,7 +973,7 @@ config MMC_REALTEK_USB
 
 config MMC_SUNXI
 	tristate "Allwinner sunxi SD/MMC Host Controller support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || COMPILE_TEST
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Allwinner sunxi SoCs.
-- 
2.17.1

