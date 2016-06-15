From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 1/4] mmc: renesas_sdhi: rename sh_mobile_sdhi as renesas_sdhi
Date: Wed, 15 Jun 2016 13:01:54 +0900
Message-ID: <1465963317-28672-2-git-send-email-horms+renesas@verge.net.au>
References: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47886 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbcFOEC3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2016 00:02:29 -0400
In-Reply-To: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

The SDHI driver is applicable to a wider range of SoCs than SH-Mobile,
Renesas seems to be a more appropriate name.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/Kconfig                              | 4 ++--
 drivers/mmc/host/Makefile                             | 2 +-
 drivers/mmc/host/{sh_mobile_sdhi.c => renesas_sdhi.c} | 0
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/mmc/host/{sh_mobile_sdhi.c => renesas_sdhi.c} (100%)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 0aa484c10c0a..840b17150263 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -560,13 +560,13 @@ config MMC_TMIO
 	  T7L66XB and also HTC ASIC3
 
 config MMC_SDHI
-	tristate "SH-Mobile SDHI SD/SDIO controller support"
+	tristate "Renesas SDHI SD/SDIO controller support"
 	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
-	  SuperH and ARM SH-Mobile SoCs
+	  SuperH, and Renesas ARM and arm64 based SoCs.
 
 config MMC_CB710
 	tristate "ENE CB710 MMC/SD Interface support"
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index af918d261ff9..206233218781 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 tmio_mmc_core-y			:= tmio_mmc_pio.o
 tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))	+= tmio_mmc_dma.o
-obj-$(CONFIG_MMC_SDHI)		+= sh_mobile_sdhi.o
+obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/renesas_sdhi.c
similarity index 100%
rename from drivers/mmc/host/sh_mobile_sdhi.c
rename to drivers/mmc/host/renesas_sdhi.c
-- 
2.1.4

