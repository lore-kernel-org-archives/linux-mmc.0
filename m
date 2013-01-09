From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: Use devm_clk_get()
Date: Wed, 09 Jan 2013 11:11:43 +0900
Message-ID: <004101cdee0e$ab8dc440$02a94cc0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21607 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab3AICLq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jan 2013 21:11:46 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGC005GS6370ZA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 09 Jan 2013 11:11:44 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MGC007AV63JN440@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 09 Jan 2013 11:11:44 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>, 'Jingoo Han' <jg1.han@samsung.com>

The devm_ functions allocate memory that is released when a driver
detaches. This patch uses devm_clk_get() for these functions.
These make the code smaller and a bit simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 82a8de1..5aaef5b 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -608,7 +608,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	sc->clk_io = clk_get(dev, "hsmmc");
+	sc->clk_io = devm_clk_get(dev, "hsmmc");
 	if (IS_ERR(sc->clk_io)) {
 		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(sc->clk_io);
@@ -623,7 +623,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		char name[14];
 
 		snprintf(name, 14, "mmc_busclk.%d", ptr);
-		clk = clk_get(dev, name);
+		clk = devm_clk_get(dev, name);
 		if (IS_ERR(clk))
 			continue;
 
@@ -765,15 +765,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 #ifndef CONFIG_PM_RUNTIME
 	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
 #endif
-	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
-		if (sc->clk_bus[ptr]) {
-			clk_put(sc->clk_bus[ptr]);
-		}
-	}
 
  err_no_busclks:
 	clk_disable_unprepare(sc->clk_io);
-	clk_put(sc->clk_io);
 
  err_pdata_io_clk:
 	sdhci_free_host(host);
@@ -786,7 +780,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
 	struct s3c_sdhci_platdata *pdata = sc->pdata;
-	int ptr;
 
 	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
 		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
@@ -806,13 +799,7 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 #ifndef CONFIG_PM_RUNTIME
 	clk_disable_unprepare(sc->clk_bus[sc->cur_clk]);
 #endif
-	for (ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
-		if (sc->clk_bus[ptr]) {
-			clk_put(sc->clk_bus[ptr]);
-		}
-	}
 	clk_disable_unprepare(sc->clk_io);
-	clk_put(sc->clk_io);
 
 	sdhci_free_host(host);
 	platform_set_drvdata(pdev, NULL);
-- 
1.7.2.5


