From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 11/20] ARM i.MX dma: Fix burstsize settings
Date: Thu, 14 Jul 2011 16:04:14 +0200
Message-ID: <1310652263-27948-11-git-send-email-s.hauer@pengutronix.de>
References: <1310652263-27948-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43051 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1GNOEd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 10:04:33 -0400
In-Reply-To: <1310652263-27948-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: juergen.lambrecht@gmail.com
Cc: Wolfram Sang <w.sang@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org

From: Wolfram Sang <w.sang@pengutronix.de>

Already upstreamed.

dmaengine expects the maxburst parameter in words, not bytes.
The imxdma driver and its users do this wrong. Fix this.

As a side note the imx-pcm-dma-mx2 driver was 'fixed' to work
with imx-dma. This broke the driver with imx-sdma support which
correctly takes the maxburst parameter in words. This patch
puts the sdma based sound back to work.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
---
 drivers/dma/imx-dma.c           |    3 ++-
 sound/soc/imx/imx-pcm-dma-mx2.c |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

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
1.7.5.4

