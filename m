From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH v3] mmc: sdhci-s3c: Use devm_clk_get()
Date: Thu, 07 Mar 2013 13:11:29 +0900
Message-ID: <000101ce1ae9$d84cd860$88e68920$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46281 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3CGELb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Mar 2013 23:11:31 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MJ9002LLVM1OJO0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Mar 2013 13:11:30 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jingoo Han' <jg1.han@samsung.com>

Use devm_clk_get() rather than clk_get() to make cleanup paths
more simple.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Changes since v2:
- added Ulf Hansson's Reviewed-by
- added Jaehoon Chung's Acked-by

Changes since v1:
- modified the commit message

 drivers/mmc/host/sdhci-s3c.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7363efe..128b650 100644
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
 
@@ -764,15 +764,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
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
@@ -785,7 +779,6 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
 	struct s3c_sdhci_platdata *pdata = sc->pdata;
-	int ptr;
 
 	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
 		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
@@ -805,13 +798,7 @@ static int sdhci_s3c_remove(struct platform_device *pdev)
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


