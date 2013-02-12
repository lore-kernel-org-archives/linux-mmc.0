From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH v2 RESEND] mmc: sdhci-s3c: Use devm_clk_get()
Date: Tue, 12 Feb 2013 12:24:39 +0900
Message-ID: <01c101ce08d0$7d8808d0$78981a70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:22516 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab3BLDYl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Feb 2013 22:24:41 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MI300LPD84TK4B0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Feb 2013 12:24:39 +0900 (KST)
Received: from DOJG1HAN02 ([12.23.120.99])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MI300AE38530F20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Feb 2013 12:24:39 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Ben Dooks' <ben-linux@fluff.org>, 'Jingoo Han' <jg1.han@samsung.com>

Use devm_clk_get() rather than clk_get() to make cleanup paths
more simple.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v1:
- modified the commit message

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


