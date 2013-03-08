From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: sdhci-pxav3: enhance device tree parser code
Date: Fri,  8 Mar 2013 12:53:53 +0800
Message-ID: <1362718433-3052-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47245 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759557Ab3CHExB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Mar 2013 23:53:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

1. seperate device tree parsing from platform data handling which
can make further work easy when platform data can be removed.
2. add calling mmc_of_parse which can parse more of property and
pxav3_get_mmc_pdata can be shrinked a lot.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index da3952d..d83343d 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -195,29 +195,16 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 {
 	struct sdhci_pxa_platdata *pdata;
 	struct device_node *np = dev->of_node;
-	u32 bus_width;
 	u32 clk_delay_cycles;
-	enum of_gpio_flags gpio_flags;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-	if (of_find_property(np, "non-removable", NULL))
-		pdata->flags |= PXA_FLAG_CARD_PERMANENT;
-
-	of_property_read_u32(np, "bus-width", &bus_width);
-	if (bus_width == 8)
-		pdata->flags |= PXA_FLAG_SD_8_BIT_CAPABLE_SLOT;
-
 	of_property_read_u32(np, "mrvl,clk-delay-cycles", &clk_delay_cycles);
 	if (clk_delay_cycles > 0)
 		pdata->clk_delay_cycles = clk_delay_cycles;
 
-	pdata->ext_cd_gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &gpio_flags);
-	if (gpio_flags != OF_GPIO_ACTIVE_LOW)
-		pdata->host_caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
-
 	return pdata;
 }
 #else
@@ -264,10 +251,11 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
 	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
-	if (match)
+	if (match) {
+		mmc_of_parse(host->mmc);
+		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
-
-	if (pdata) {
+	} else if (pdata) {
 		/* on-chip device */
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT)
 			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
@@ -297,8 +285,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		}
 	}
 
-	sdhci_get_of_property(pdev);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
@@ -316,7 +302,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	if (pdata->pm_caps & MMC_PM_KEEP_POWER) {
+	if (host->mmc->pm_caps & MMC_PM_KEEP_POWER) {
 		device_init_wakeup(&pdev->dev, 1);
 		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
 	} else {
-- 
1.7.9.5

