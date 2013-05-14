From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 1/1] mmc: mxcmmc: setup mpc512x related clocks
Date: Tue, 14 May 2013 17:00:09 +0200
Message-ID: <1368543609-11372-2-git-send-email-gsi@denx.de>
References: <1368543609-11372-1-git-send-email-gsi@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39011 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917Ab3ENPBR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 11:01:17 -0400
In-Reply-To: <1368543609-11372-1-git-send-email-gsi@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>

the mxcmmc(4) driver is shared across the i.MX and MPC512x platforms,
setup the 'sdhc_clk' instead of 'ipg' and 'per' in the mpc512x case

this change re-uses the i.MX 'per' clock related variable for everything
SDHC/MMC related, and makes the 'ipg' clock related variable access
conditional -- this approach is less intrusive than adding an #ifdef and
two sets of variables everywhere

viewing the change with 'git diff -w' better reflects its nature

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/mmc/host/mxcmmc.c |   41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index d503635..b9d21cc 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1121,20 +1121,29 @@ static int mxcmci_probe(struct platform_device *pdev)
 	host->res = r;
 	host->irq = irq;
 
-	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(host->clk_ipg)) {
-		ret = PTR_ERR(host->clk_ipg);
-		goto out_iounmap;
-	}
+	if (!is_mpc512x_mmc(host)) {
+		host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+		if (IS_ERR(host->clk_ipg)) {
+			ret = PTR_ERR(host->clk_ipg);
+			goto out_iounmap;
+		}
 
-	host->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(host->clk_per)) {
-		ret = PTR_ERR(host->clk_per);
-		goto out_iounmap;
+		host->clk_per = devm_clk_get(&pdev->dev, "per");
+		if (IS_ERR(host->clk_per)) {
+			ret = PTR_ERR(host->clk_per);
+			goto out_iounmap;
+		}
+	} else {
+		host->clk_per = devm_clk_get(&pdev->dev, "sdhc_clk");
+		if (IS_ERR(host->clk_per)) {
+			ret = PTR_ERR(host->clk_per);
+			goto out_iounmap;
+		}
 	}
 
 	clk_prepare_enable(host->clk_per);
-	clk_prepare_enable(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_prepare_enable(host->clk_ipg);
 
 	mxcmci_softreset(host);
 
@@ -1204,7 +1213,8 @@ out_free_dma:
 		dma_release_channel(host->dma);
 out_clk_put:
 	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_disable_unprepare(host->clk_ipg);
 out_iounmap:
 	iounmap(host->base);
 out_free:
@@ -1236,7 +1246,8 @@ static int mxcmci_remove(struct platform_device *pdev)
 		dma_release_channel(host->dma);
 
 	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_disable_unprepare(host->clk_ipg);
 
 	release_mem_region(host->res->start, resource_size(host->res));
 
@@ -1255,7 +1266,8 @@ static int mxcmci_suspend(struct device *dev)
 	if (mmc)
 		ret = mmc_suspend_host(mmc);
 	clk_disable_unprepare(host->clk_per);
-	clk_disable_unprepare(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_disable_unprepare(host->clk_ipg);
 
 	return ret;
 }
@@ -1267,7 +1279,8 @@ static int mxcmci_resume(struct device *dev)
 	int ret = 0;
 
 	clk_prepare_enable(host->clk_per);
-	clk_prepare_enable(host->clk_ipg);
+	if (host->clk_ipg)
+		clk_prepare_enable(host->clk_ipg);
 	if (mmc)
 		ret = mmc_resume_host(mmc);
 
-- 
1.7.10.4

