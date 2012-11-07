From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] Revert "mmc: sdhci-s3c: Add clk_(enable/disable) in runtime  suspend/resume"
Date: Wed, 7 Nov 2012 23:57:15 +0100
Message-ID: <201211072357.15572.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:55110 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186Ab2KGXiZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Nov 2012 18:38:25 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chander Kashyap <chander.kashyap@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

This reverts commit 2abeb5c5ded2e7f7d288058426fb0ae852adc77f, as it breaks
machines using the gpio-based card-detect option with a loop of

        mmc0: Timeout waiting for hardware interrupt.
        mmc0: Internal clock never stabilised.
        mmc0: Timeout waiting for hardware interrupt.
        mmc0: Internal clock never stabilised.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This is of course meant for 3.7-rc

 drivers/mmc/host/sdhci-s3c.c |   29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..e019672 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -637,9 +637,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_no_busclks;
 	}
 
-#ifndef CONFIG_PM_RUNTIME
 	clk_enable(sc->clk_bus[sc->cur_clk]);
-#endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
@@ -746,15 +744,10 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	    gpio_is_valid(pdata->ext_cd_gpio))
 		sdhci_s3c_setup_card_detect_gpio(sc);
 
-#ifdef CONFIG_PM_RUNTIME
-	clk_disable(sc->clk_io);
-#endif
 	return 0;
 
  err_req_regs:
-#ifndef CONFIG_PM_RUNTIME
 	clk_disable(sc->clk_bus[sc->cur_clk]);
-#endif
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_put(sc->clk_bus[ptr]);
@@ -793,17 +786,12 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	if (gpio_is_valid(sc->ext_cd_gpio))
 		gpio_free(sc->ext_cd_gpio);
 
-#ifdef CONFIG_PM_RUNTIME
-	clk_enable(sc->clk_io);
-#endif
 	sdhci_remove_host(host, 1);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-#ifndef CONFIG_PM_RUNTIME
 	clk_disable(sc->clk_bus[sc->cur_clk]);
-#endif
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_put(sc->clk_bus[ptr]);
@@ -843,28 +831,15 @@ static int sdhci_s3c_resume(struct device *dev)
 static int sdhci_s3c_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_s3c *ourhost = to_s3c(host);
-	struct clk *busclk = ourhost->clk_io;
-	int ret;
-
-	ret = sdhci_runtime_suspend_host(host);
 
-	clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
-	clk_disable(busclk);
-	return ret;
+	return sdhci_runtime_suspend_host(host);
 }
 
 static int sdhci_s3c_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-	struct sdhci_s3c *ourhost = to_s3c(host);
-	struct clk *busclk = ourhost->clk_io;
-	int ret;
 
-	clk_enable(busclk);
-	clk_enable(ourhost->clk_bus[ourhost->cur_clk]);
-	ret = sdhci_runtime_resume_host(host);
-	return ret;
+	return sdhci_runtime_resume_host(host);
 }
 #endif
 
-- 
1.7.10.4

