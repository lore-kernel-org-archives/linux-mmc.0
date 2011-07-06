From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] ARM i.MX dma: Fix burstsize settings
Date: Wed, 6 Jul 2011 11:18:33 +0200
Message-ID: <20110706091833.GT6069@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33620 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab1GFJSn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 05:18:43 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@openso>

dmaengine expects the maxburst parameter in words, not bytes.
The imxdma driver and its users do this wrong. Fix this.

As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
with imx-dma. This broke the driver with imx-sdma support which
correctly takes the maxburst parameter in words. This patch
puts the sdma based sound back to work.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

I made this as a cross subsystem patch to maintain bisectability. I
suggest to push it either via my tree or the dmaengine tree.

 drivers/dma/imx-dma.c           |    3 ++-
 drivers/mmc/host/mxcmmc.c       |    8 ++++----
 sound/soc/imx/imx-pcm-dma-mx2.c |    4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index e18eaab..d99f71c 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -135,7 +135,8 @@ static int imxdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		if (ret)
 			return ret;
 
-		imx_dma_config_burstlen(imxdmac->imxdma_channel, imxdmac->watermark_level);
+		imx_dma_config_burstlen(imxdmac->imxdma_channel,
+				imxdmac->watermark_level * imxdmac->word_size);
 
 		return 0;
 	default:
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index cc20e02..14aa213 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -715,13 +715,13 @@ static void mxcmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	int burstlen, ret;
 
 	/*
-	 * use burstlen of 64 in 4 bit mode (--> reg value  0)
-	 * use burstlen of 16 in 1 bit mode (--> reg value 16)
+	 * use burstlen of 64 (16 words) in 4 bit mode (--> reg value  0)
+	 * use burstlen of 16 (4 words) in 1 bit mode (--> reg value 16)
 	 */
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
-		burstlen = 64;
-	else
 		burstlen = 16;
+	else
+		burstlen = 4;
 
 	if (mxcmci_use_dma(host) && burstlen != host->burstlen) {
 		host->burstlen = burstlen;
diff --git a/sound/soc/imx/imx-pcm-dma-mx2.c b/sound/soc/imx/imx-pcm-dma-mx2.c
index 4173b3d..43fdc24f 100644
--- a/sound/soc/imx/imx-pcm-dma-mx2.c
+++ b/sound/soc/imx/imx-pcm-dma-mx2.c
@@ -110,12 +110,12 @@ static int imx_ssi_dma_alloc(struct snd_pcm_substream *substream,
 		slave_config.direction = DMA_TO_DEVICE;
 		slave_config.dst_addr = dma_params->dma_addr;
 		slave_config.dst_addr_width = buswidth;
-		slave_config.dst_maxburst = dma_params->burstsize * buswidth;
+		slave_config.dst_maxburst = dma_params->burstsize;
 	} else {
 		slave_config.direction = DMA_FROM_DEVICE;
 		slave_config.src_addr = dma_params->dma_addr;
 		slave_config.src_addr_width = buswidth;
-		slave_config.src_maxburst = dma_params->burstsize * buswidth;
+		slave_config.src_maxburst = dma_params->burstsize;
 	}
 
 	ret = dmaengine_slave_config(iprtd->dma_chan, &slave_config);
-- 
1.7.5.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
