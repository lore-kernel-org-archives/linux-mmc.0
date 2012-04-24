From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/7] mmc: sdhi: implement tmio-mmc clock enable-update and disable callbacks
Date: Tue, 24 Apr 2012 18:41:44 +0200
Message-ID: <1335285707-22707-5-git-send-email-g.liakhovetski@gmx.de>
References: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64266 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824Ab2DXQlv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 12:41:51 -0400
In-Reply-To: <1335285707-22707-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Instead of delivering one static clock frequency value, read from the
hardware during probing, enable the tmio-mmc driver to re-read the
frequency dynamically.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 5ac656e..a746ae8 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -39,6 +39,27 @@ struct sh_mobile_sdhi {
 	struct tmio_mmc_dma dma_priv;
 };
 
+static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int *f)
+{
+	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	int ret = clk_enable(priv->clk);
+	if (ret < 0)
+		return ret;
+
+	*f = clk_get_rate(priv->clk);
+	return 0;
+}
+
+static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
+{
+	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	clk_disable(priv->clk);
+}
+
 static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 {
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
@@ -130,9 +151,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
+	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
+	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
 	if (p) {
 		mmc_data->flags = p->tmio_flags;
-- 
1.7.2.5

