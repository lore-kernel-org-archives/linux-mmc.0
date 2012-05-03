From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 26/29] mmc: sdhi: add OF support, make platform data optional
Date: Thu,  3 May 2012 17:05:55 +0200
Message-ID: <1336057558-11031-27-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-mmc@vger.kernel.org

Now, that most parameters, required to configure the TMIO MMC driver can be
obtained from OF, we can also add support for it to the SDHI glue, which
also makes it necessary to be able to run without platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ae2e3da..b20c637 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
@@ -132,9 +133,8 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	}
 
 	mmc_data = &priv->mmc_data;
-	p->pdata = mmc_data;
 
-	if (p->init) {
+	if (p && p->init) {
 		ret = p->init(pdev, &sdhi_ops);
 		if (ret)
 			goto einit;
@@ -147,10 +147,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	if (p->set_pwr)
-		mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
-	if (p->get_cd)
-		mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
 	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
@@ -161,6 +157,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->ocr_mask = p->tmio_ocr_mask;
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->cd_gpio = p->cd_gpio;
+		if (p->set_pwr)
+			mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+		if (p->get_cd)
+			mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			priv->param_tx.slave_id = p->dma_slave_tx;
@@ -266,7 +266,7 @@ eirq_card_detect:
 eprobe:
 	clk_put(priv->clk);
 eclkget:
-	if (p->cleanup)
+	if (p && p->cleanup)
 		p->cleanup(pdev);
 einit:
 	kfree(priv);
@@ -281,7 +281,8 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	int i = 0, irq;
 
-	p->pdata = NULL;
+	if (p)
+		p->pdata = NULL;
 
 	tmio_mmc_host_remove(host);
 
@@ -294,7 +295,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 
 	clk_put(priv->clk);
 
-	if (p->cleanup)
+	if (p && p->cleanup)
 		p->cleanup(pdev);
 
 	kfree(priv);
@@ -309,11 +310,18 @@ static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
 	.runtime_resume = tmio_mmc_host_runtime_resume,
 };
 
+static const struct of_device_id sh_mobile_sdhi_of_match[] = {
+	{ .compatible = "renesas,shmobile-sdhi" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
+
 static struct platform_driver sh_mobile_sdhi_driver = {
 	.driver		= {
 		.name	= "sh_mobile_sdhi",
 		.owner	= THIS_MODULE,
 		.pm	= &tmio_mmc_dev_pm_ops,
+		.of_match_table = sh_mobile_sdhi_of_match,
 	},
 	.probe		= sh_mobile_sdhi_probe,
 	.remove		= __devexit_p(sh_mobile_sdhi_remove),
-- 
1.7.2.5

