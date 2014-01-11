From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH 5/6] mmc: sdhci-s3c: Fix handling of bus clock switching
Date: Sat, 11 Jan 2014 22:39:05 +0100
Message-ID: <1389476346-20396-6-git-send-email-tomasz.figa@gmail.com>
References: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:32940 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbaAKVj0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jan 2014 16:39:26 -0500
In-Reply-To: <1389476346-20396-1-git-send-email-tomasz.figa@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>

Currently the driver assumes at probe that controller is configured for
last valid enumerated bus clock. This assumption is completely wrong, as
there is no way to ensure such configuration until the hardware gets
first configured (by calling sdhci_s3c_set_clock()).

This patch modifies the driver to set current clock at probe to unknown
state (represented by negative value) and make sure that the hardware
gets actually configured to selected clock in sdhci_s3c_set_clock().

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c | 78 ++++++++++----------------------------------
 1 file changed, 17 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7e14db0..bad0e00 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -51,7 +51,7 @@ struct sdhci_s3c {
 	struct platform_device	*pdev;
 	struct resource		*ioarea;
 	struct s3c_sdhci_platdata *pdata;
-	unsigned int		cur_clk;
+	int			cur_clk;
 	int			ext_cd_irq;
 	int			ext_cd_gpio;
 
@@ -78,32 +78,6 @@ static inline struct sdhci_s3c *to_s3c(struct sdhci_host *host)
 }
 
 /**
- * get_curclk - convert ctrl2 register to clock source number
- * @ctrl2: Control2 register value.
- */
-static u32 get_curclk(u32 ctrl2)
-{
-	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-	ctrl2 >>= S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
-
-	return ctrl2;
-}
-
-static void sdhci_s3c_check_sclk(struct sdhci_host *host)
-{
-	struct sdhci_s3c *ourhost = to_s3c(host);
-	u32 tmp = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
-
-	if (get_curclk(tmp) != ourhost->cur_clk) {
-		dev_dbg(&ourhost->pdev->dev, "restored ctrl2 clock setting\n");
-
-		tmp &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-		tmp |= ourhost->cur_clk << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
-		writel(tmp, host->ioaddr + S3C_SDHCI_CONTROL2);
-	}
-}
-
-/**
  * sdhci_s3c_get_max_clk - callback to get maximum clock frequency.
  * @host: The SDHCI host instance.
  *
@@ -115,11 +89,6 @@ static unsigned int sdhci_s3c_get_max_clk(struct sdhci_host *host)
 	unsigned long rate, max = 0;
 	int src;
 
-	/* note, a reset will reset the clock source */
-
-	sdhci_s3c_check_sclk(host);
-
-
 	for (src = 0; src < MAX_BUS_CLK; src++) {
 		rate = ourhost->clk_rates[src];
 		if (rate > max)
@@ -206,20 +175,22 @@ static void sdhci_s3c_set_clock(struct sdhci_host *host, unsigned int clock)
 		struct clk *clk = ourhost->clk_bus[best_src];
 
 		clk_prepare_enable(clk);
-		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
-
-		/* turn clock off to card before changing clock source */
-		writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
+		if (ourhost->cur_clk >= 0)
+			clk_disable_unprepare(
+					ourhost->clk_bus[ourhost->cur_clk]);
 
 		ourhost->cur_clk = best_src;
 		host->max_clk = ourhost->clk_rates[best_src];
-
-		ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
-		ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
-		ctrl |= best_src << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
-		writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
 	}
 
+	/* turn clock off to card before changing clock source */
+	writew(0, host->ioaddr + SDHCI_CLOCK_CONTROL);
+
+	ctrl = readl(host->ioaddr + S3C_SDHCI_CONTROL2);
+	ctrl &= ~S3C_SDHCI_CTRL2_SELBASECLK_MASK;
+	ctrl |= best_src << S3C_SDHCI_CTRL2_SELBASECLK_SHIFT;
+	writel(ctrl, host->ioaddr + S3C_SDHCI_CONTROL2);
+
 	/* reprogram default hardware configuration */
 	writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
 		host->ioaddr + S3C64XX_SDHCI_CONTROL4);
@@ -573,6 +544,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	sc->host = host;
 	sc->pdev = pdev;
 	sc->pdata = pdata;
+	sc->cur_clk = -1;
 
 	platform_set_drvdata(pdev, host);
 
@@ -595,13 +567,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 			continue;
 
 		clks++;
-
-		/*
-		 * save current clock index to know which clock bus
-		 * is used later in overriding functions.
-		 */
-		sc->cur_clk = ptr;
-
 		sc->clk_rates[ptr] = clk_get_rate(sc->clk_bus[ptr]);
 
 		dev_info(dev, "clock source %d: %s (%ld Hz)\n",
@@ -614,10 +579,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_no_busclks;
 	}
 
-#ifndef CONFIG_PM_RUNTIME
-	clk_prepare_enable(sc->clk_bus[sc->cur_clk]);
-#endif
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->ioaddr = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(host->ioaddr)) {
@@ -730,10 +691,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	return 0;
 
  err_req_regs:
-#ifndef CONFIG_PM_RUNTIME
-	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
-#endif
-
  err_no_busclks:
 	clk_disable_unprepare(sc->clk_io);
 
@@ -764,9 +721,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-#ifndef CONFIG_PM_RUNTIME
-	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
-#endif
 	clk_disable_unprepare(sc->clk_io);
 
 	sdhci_free_host(host);
@@ -800,7 +754,8 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
-	clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
+	if (ourhost->cur_clk >= 0)
+		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
 	clk_disable_unprepare(busclk);
 	return ret;
 }
@@ -813,7 +768,8 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
 	int ret;
 
 	clk_prepare_enable(busclk);
-	clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
+	if (ourhost->cur_clk >= 0)
+		clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
 	ret = sdhci_runtime_resume_host(host);
 	return ret;
 }
-- 
1.8.5.2

