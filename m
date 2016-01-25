From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 9/9] mmc: sdhi: Add r8a7795 support
Date: Mon, 25 Jan 2016 20:15:16 +0100
Message-ID: <1453749316-1848-10-git-send-email-wsa@the-dreams.de>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33090 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757960AbcAYTPa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 14:15:30 -0500
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Registers are 64bit apart, so we refactor bus_shift handling a little
and set it based on the DT compatible. Also, EXT_ACC is different.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

@MMC maintainers: I set the MMC_CAP_WAIT_WHILE_BUSY flage here and it is needed
to probe the eMMC (implementing RSP_R1 without CRC would also work). However, I
can't find an explicit statement in the documentation saying that it really
waits when the bus is busy. Is my "it works, let's use it" approach enough, or
is there more I can do to verify that setting MMC_CAP_WAIT_WHILE_BUSY is valid
for this hardware?

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
 drivers/mmc/host/Kconfig                           |  2 +-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 47 ++++++++++++++++------
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 400b640fabc768..7fb746dd1a68ca 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -22,6 +22,7 @@ Required properties:
 		"renesas,sdhi-r8a7792" - SDHI IP on R8A7792 SoC
 		"renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
+		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
 
 Optional properties:
 - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1526b8a10b094e..dd1499bd218b16 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -560,7 +560,7 @@ config MMC_TMIO
 
 config MMC_SDHI
 	tristate "SH-Mobile SDHI SD/SDIO controller support"
-	depends on SUPERH || ARM
+	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
 	select MMC_TMIO_CORE
 	help
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 557e2b9dadeec7..f7eff5f53e0013 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -1,6 +1,8 @@
 /*
  * SuperH Mobile SDHI
  *
+ * Copyright (C) 2016 Sang Engineering, Wolfram Sang
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
  * Copyright (C) 2009 Magnus Damm
  *
  * This program is free software; you can redistribute it and/or modify
@@ -43,6 +45,7 @@ struct sh_mobile_sdhi_of_data {
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
 	dma_addr_t dma_rx_offset;
+	unsigned bus_shift;
 };
 
 static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
@@ -65,6 +68,13 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 	.dma_rx_offset	= 0x2000,
 };
 
+static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
+			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_FAST_CLK_CHG,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY,
+	.bus_shift	= 2,
+};
+
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
@@ -78,6 +88,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
+	{ .compatible = "renesas,sdhi-r8a7795", .data = &of_rcar_gen3_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
@@ -103,6 +114,15 @@ static void sh_mobile_sdhi_sdbuf_width(struct tmio_mmc_host *host, int width)
 	case 0xCB0D:
 		val = (width == 32) ? 0x0000 : 0x0001;
 		break;
+	case 0xCC10: /* Gen3, SD only */
+	case 0xCD10: /* Gen3, SD + MMC */
+		if (width == 64)
+			val = 0x0000;
+		else if (width == 32)
+			val = 0x0101;
+		else
+			val = 0x0001;
+		break;
 	default:
 		/* nothing to do */
 		return;
@@ -233,16 +253,26 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eprobe;
 	}
 
+	if (of_id && of_id->data) {
+		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
+
+		mmc_data->flags |= of_data->tmio_flags;
+		mmc_data->capabilities |= of_data->capabilities;
+		mmc_data->capabilities2 |= of_data->capabilities2;
+		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		dma_priv->dma_buswidth = of_data->dma_buswidth;
+		host->bus_shift = of_data->bus_shift;
+	}
+
 	host->dma		= dma_priv;
 	host->write16_hook	= sh_mobile_sdhi_write16_hook;
 	host->clk_enable	= sh_mobile_sdhi_clk_enable;
 	host->clk_disable	= sh_mobile_sdhi_clk_disable;
 	host->multi_io_quirk	= sh_mobile_sdhi_multi_io_quirk;
-	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
-	if (resource_size(res) > 0x100)
+
+	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
+	if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
 		host->bus_shift = 1;
-	else
-		host->bus_shift = 0;
 
 	if (mmd)
 		*mmc_data = *mmd;
@@ -274,15 +304,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
 
-	if (of_id && of_id->data) {
-		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
-		mmc_data->flags |= of_data->tmio_flags;
-		mmc_data->capabilities |= of_data->capabilities;
-		mmc_data->capabilities2 |= of_data->capabilities2;
-		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
-		dma_priv->dma_buswidth = of_data->dma_buswidth;
-	}
-
 	ret = tmio_mmc_host_probe(host, mmc_data);
 	if (ret < 0)
 		goto efree;
-- 
2.1.4

