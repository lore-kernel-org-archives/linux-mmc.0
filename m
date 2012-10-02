From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] mmc: sdhci-s3c: use clk_prepare_enable and clk_disable_unprepare
Date: Wed,  3 Oct 2012 08:35:43 +0900
Message-ID: <1349220943-2636-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..a093e2e 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -211,8 +211,8 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (ourhost->cur_clk != best_src) {
 		struct clk *clk = ourhost->clk_bus[best_src];
 
-		clk_enable(clk);
-		clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
+		clk_prepare_enable(clk);
+		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
 
 		/* turn clock off to card before changing clock source */
 		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
@@ -607,7 +607,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	}
 
 	/* enable the local io clock and keep it running for the moment. */
-	clk_enable(sc->clk_io);
+	clk_prepare_enable(sc->clk_io);
 
 	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		struct clk *clk;
@@ -638,7 +638,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	}
 
 #ifndef CONFIG_PM_RUNTIME
-	clk_enable(sc->clk_bus[sc->cur_clk]);
+	clk_prepare_enable(sc->clk_bus[sc->cur_clk]);
 #endif
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -747,13 +747,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		sdhci_s3c_setup_card_detect_gpio(sc);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_disable(sc->clk_io);
+	clk_disable_unprepare(sc->clk_io);
 #endif
 	return 0;
 
  err_req_regs:
 #ifndef CONFIG_PM_RUNTIME
-	clk_disable(sc->clk_bus[sc->cur_clk]);
+	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
 #endif
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		if (sc->clk_bus[ptr]) {
@@ -762,7 +762,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	}
 
  err_no_busclks:
-	clk_disable(sc->clk_io);
+	clk_disable_unprepare(sc->clk_io);
 	clk_put(sc->clk_io);
 
  err_io_clk:
@@ -794,7 +794,7 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 		gpio_free(sc->ext_cd_gpio);
 
 #ifdef CONFIG_PM_RUNTIME
-	clk_enable(sc->clk_io);
+	clk_prepare_enable(sc->clk_io);
 #endif
 	sdhci_remove_host(host, 1);
 
@@ -802,14 +802,14 @@ static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 #ifndef CONFIG_PM_RUNTIME
-	clk_disable(sc->clk_bus[sc->cur_clk]);
+	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
 #endif
 	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
 		if (sc->clk_bus[ptr]) {
 			clk_put(sc->clk_bus[ptr]);
 		}
 	}
-	clk_disable(sc->clk_io);
+	clk_disable_unprepare(sc->clk_io);
 	clk_put(sc->clk_io);
 
 	if (pdev->dev.of_node) {
@@ -849,8 +849,8 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
-	clk_disable(ourhost->clk_bus[ourhost->cur_clk]);
-	clk_disable(busclk);
+	clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
+	clk_disable_unprepare(busclk);
 	return ret;
 }
 
@@ -861,8 +861,8 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
 	struct clk *busclk = ourhost->clk_io;
 	int ret;
 
-	clk_enable(busclk);
-	clk_enable(ourhost->clk_bus[ourhost->cur_clk]);
+	clk_prepare_enable(busclk);
+	clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
 	ret = sdhci_runtime_resume_host(host);
 	return ret;
 }
-- 
1.7.4.1
