From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/3] mmc: sdhi: allow platforms to power down the controller
 with no card inserted
Date: Wed, 11 May 2011 18:51:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105111850200.5557@axis700.grange>
References: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63993 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab1EKQvV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 12:51:21 -0400
In-Reply-To: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>

Supply a link to TMIO private data for platforms to implement own
card detection.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c  |    6 ++++++
 include/linux/mmc/sh_mobile_sdhi.h |    4 ++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index d264bbe..b365429 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -71,6 +71,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	}
 
 	mmc_data = &priv->mmc_data;
+	p->pdata = mmc_data;
 
 	snprintf(clk_name, sizeof(clk_name), "sdhi%d", pdev->id);
 	priv->clk = clk_get(&pdev->dev, clk_name);
@@ -159,8 +160,11 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	int i, irq;
 
+	p->pdata = NULL;
+
 	for (i = 0; i < 3; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq >= 0)
@@ -178,6 +182,8 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	.suspend = tmio_mmc_host_suspend,
 	.resume = tmio_mmc_host_resume,
+	.runtime_suspend = tmio_mmc_host_runtime_suspend,
+	.runtime_resume = tmio_mmc_host_runtime_resume,
 };
 
 static struct platform_driver sh_mobile_sdhi_driver = {
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index c981b95..faf32b6 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -3,12 +3,16 @@
 
 #include <linux/types.h>
 
+struct platform_device;
+struct tmio_mmc_data;
+
 struct sh_mobile_sdhi_info {
 	int dma_slave_tx;
 	int dma_slave_rx;
 	unsigned long tmio_flags;
 	unsigned long tmio_caps;
 	u32 tmio_ocr_mask;	/* available MMC voltages */
+	struct tmio_mmc_data *pdata;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 	int (*get_cd)(struct platform_device *pdev);
 };
-- 
1.7.2.5

