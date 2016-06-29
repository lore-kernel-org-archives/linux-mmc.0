From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v2 4/5] mmc: sh_mobile_sdhi: add some SoC specific data for R-Car Gen3
Date: Thu, 30 Jun 2016 00:05:39 +0200
Message-ID: <1467237940-24388-5-git-send-email-horms+renesas@verge.net.au>
References: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54990 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbcF2WF6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2016 18:05:58 -0400
In-Reply-To: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

To avoid complicate code in own dma code for gen3, this patch
adds set max_segs to 1. Then, the tmio driver will get requests
as sg_len = 1 only.

In the performance point of view, the CONFIG_MMC_BLOCK_BOUNCE should
be set. Otherwise, mmc block layer will set 4-kbyte each as a request.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2
* First post
---
 drivers/mmc/host/sh_mobile_sdhi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 320059c61c6c..51b5327557fa 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -54,6 +54,8 @@ struct sh_mobile_sdhi_of_data {
 	enum dma_slave_buswidth dma_buswidth;
 	dma_addr_t dma_rx_offset;
 	unsigned bus_shift;
+	unsigned int max_blk_count;
+	unsigned short max_segs;
 };
 
 static const struct sh_mobile_sdhi_of_data of_default_cfg = {
@@ -79,6 +81,9 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 			  TMIO_MMC_CLK_ACTUAL | TMIO_MMC_MIN_RCAR2,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.bus_shift	= 2,
+	/* Gen3 SDHI DMAC can handle 0xffffffff blk count, but seg = 1 */
+	.max_blk_count  = 0xffffffff,
+	.max_segs = 1,
 };
 
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
@@ -368,6 +373,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		mmc_data->max_blk_count = of_data->max_blk_count;
+		mmc_data->max_segs = of_data->max_segs;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 	}
-- 
2.7.0.rc3.207.g0ac5344

