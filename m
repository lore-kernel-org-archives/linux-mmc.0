From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/8 v3] mmc: sdhi: implement tmio-mmc clock enable-update and disable callbacks
Date: Fri, 25 May 2012 17:45:30 +0200
Message-ID: <1337960752-4944-16-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Instead of delivering one static clock frequency value, read from the
hardware during probing, enable the tmio-mmc driver to re-read the
frequency dynamically.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 934b68e..d8b167c 100644
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
@@ -132,9 +153,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
