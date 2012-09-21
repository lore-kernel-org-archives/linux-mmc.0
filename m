From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v2 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Fri, 21 Sep 2012 11:12:08 +0530
Message-ID: <1348206128-11083-1-git-send-email-chander.kashyap@linaro.org>
References: <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1347613731-29428-4-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org, Chander Kashyap <chander.kashyap@gmail.com>, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Chander Kashyap <chander.kashyap@gmail.com>

Perform clock disable/enable in runtime suspend/resume.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog:
v2:
- Wrapped clk_disable in probe and clk_enable in remove with
  #ifdef CONFIG_PM_RUNTIME conditional check.

 drivers/mmc/host/sdhci-s3c.c |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index e019672..3726c18 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -637,7 +637,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_no_busclks;
 	}
 
+#ifndef CONFIG_PM_RUNTIME
 	clk_enable(sc->clk_bus[sc->cur_clk]);
+#endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->ioaddr = devm_request_and_ioremap(&pdev->dev, res);
@@ -744,10 +746,15 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	    gpio_is_valid(pdata->ext_cd_gpio))
 		sdhci_s3c_setup_card_detect_gpio(sc);
 
+#ifdef CONFIG_PM_RUNTIME
+	clk_disable(sc->clk_io);
+#endif
 	return 0;
 
  err_req_regs:
+#ifndef CONFIG_PM_RUNTIME
 	clk_disable(sc->clk_bus[sc->cur_clk]);
+#endif
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_put(sc->clk_bus[ptr]);
@@ -786,12 +793,17 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	if (gpio_is_valid(sc->ext_cd_gpio))
 		gpio_free(sc->ext_cd_gpio);
 
+#ifdef CONFIG_PM_RUNTIME
+	clk_enable(sc->clk_io);
+#endif
 	sdhci_remove_host(host, 1);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+#ifndef CONFIG_PM_RUNTIME
 	clk_disable(sc->clk_bus[sc->cur_clk]);
+#endif
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_put(sc->clk_bus[ptr]);
@@ -831,15 +843,28 @@ static int sdhci_s3c_resume(struct device *dev)
 static int sdhci_s3c_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct clk *busclk = ourhost->clk_io;
+	int ret;
+
+	ret = sdhci_runtime_suspend_host(host);
 
-	return sdhci_runtime_suspend_host(host);
+	clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
+	clk_disable(busclk);
+	return ret;
 }
 
 static int sdhci_s3c_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_s3c *ourhost = to_s3c(host);
+	struct clk *busclk = ourhost->clk_io;
+	int ret;
 
-	return sdhci_runtime_resume_host(host);
+	clk_enable(busclk);
+	clk_enable(ourhost->clk_bus[ourhost->cur_clk]);
+	ret = sdhci_runtime_resume_host(host);
+	return ret;
 }
 #endif
 
-- 
1.7.9.5
