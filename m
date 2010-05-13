From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4b/9 v4] sh: prepare the SDHI MFD driver to pass DMA
 configuration to tmio_mmc.c
Date: Thu, 13 May 2010 16:15:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005131607240.4671@axis700.grange>
References: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756570Ab0EMOPe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 May 2010 10:15:34 -0400
In-Reply-To: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Pass DMA slave IDs from platform down to the tmio_mmc driver, to be used
for dmaengine configuration.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3 -> v4:
 
sdhi part of [PATCH 4a/9 v3], no changes in the code.

 drivers/mfd/sh_mobile_sdhi.c       |   24 ++++++++++++++++++++----
 include/linux/mfd/sh_mobile_sdhi.h |    2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index 468fd36..dafa988 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -25,11 +25,15 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/sh_dma.h>
 
 struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
 	struct mfd_cell cell_mmc;
+	struct sh_dmae_slave param_tx;
+	struct sh_dmae_slave param_rx;
+	struct tmio_mmc_dma dma_priv;
 };
 
 static struct resource sh_mobile_sdhi_resources[] = {
@@ -63,6 +67,8 @@ static void sh_mobile_sdhi_set_pwr(struct platform_device *tmio, int state)
 static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	struct sh_mobile_sdhi *priv;
+	struct tmio_mmc_data *mmc_data;
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct resource *mem;
 	char clk_name[8];
 	int ret, irq;
@@ -84,6 +90,8 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	mmc_data = &priv->mmc_data;
+
 	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
 	priv->clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(priv->clk)) {
@@ -95,12 +103,20 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	clk_enable(priv->clk);
 
-	priv->mmc_data.hclk = clk_get_rate(priv->clk);
-	priv->mmc_data.set_pwr = sh_mobile_sdhi_set_pwr;
-	priv->mmc_data.capabilities = MMC_CAP_MMC_HIGHSPEED;
+	mmc_data->hclk = clk_get_rate(priv->clk);
+	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
+
+	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
+		priv->param_tx.slave_id = p->dma_slave_tx;
+		priv->param_rx.slave_id = p->dma_slave_rx;
+		priv->dma_priv.chan_priv_tx = &priv->param_tx;
+		priv->dma_priv.chan_priv_rx = &priv->param_rx;
+		mmc_data->dma = &priv->dma_priv;
+	}
 
 	memcpy(&priv->cell_mmc, &sh_mobile_sdhi_cell, sizeof(priv->cell_mmc));
-	priv->cell_mmc.driver_data = &priv->mmc_data;
+	priv->cell_mmc.driver_data = mmc_data;
 	priv->cell_mmc.platform_data = &priv->cell_mmc;
 	priv->cell_mmc.data_size = sizeof(priv->cell_mmc);
 
diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
index 3bcd716..c305461 100644
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ b/include/linux/mfd/sh_mobile_sdhi.h
@@ -2,6 +2,8 @@
 #define __SH_MOBILE_SDHI_H__
 
 struct sh_mobile_sdhi_info {
+	int dma_slave_tx;
+	int dma_slave_rx;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 };
 
-- 
1.6.2.4

