From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2 v3] mmc: sdhi: add OF support, make platform data optional
Date: Fri, 25 May 2012 17:45:47 +0200
Message-ID: <1337960752-4944-33-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Add primitive support for OF to the SDHI TMIO glue, which also makes it
necessary to be able to run without platform data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 1e7c5c4..3defd77 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mmc/host.h>
@@ -133,9 +134,8 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	}
 
 	mmc_data = &priv->mmc_data;
-	p->pdata = mmc_data;
 
-	if (p->init) {
+	if (p && p->init) {
 		ret = p->init(pdev, &sdhi_ops);
 		if (ret)
 			goto einit;
@@ -149,10 +149,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	if (p->set_pwr)
-		mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
-	if (p->get_cd)
-		mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 	mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
 	mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
@@ -164,6 +160,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->capabilities |= p->tmio_caps;
 		mmc_data->capabilities2 |= p->tmio_caps2;
 		mmc_data->cd_gpio = p->cd_gpio;
+		if (p->set_pwr)
+			mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
+		if (p->get_cd)
+			mmc_data->get_cd = sh_mobile_sdhi_get_cd;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
 			priv->param_tx.slave_id = p->dma_slave_tx;
@@ -269,7 +269,7 @@ eirq_card_detect:
 eprobe:
 	clk_put(priv->clk);
 eclkget:
-	if (p->cleanup)
+	if (p && p->cleanup)
 		p->cleanup(pdev);
 einit:
 	kfree(priv);
@@ -284,7 +284,8 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	int i = 0, irq;
 
-	p->pdata = NULL;
+	if (p)
+		p->pdata = NULL;
 
 	tmio_mmc_host_remove(host);
 
@@ -297,7 +298,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 
 	clk_put(priv->clk);
 
-	if (p->cleanup)
+	if (p && p->cleanup)
 		p->cleanup(pdev);
 
 	kfree(priv);
@@ -312,11 +313,18 @@ static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
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

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
