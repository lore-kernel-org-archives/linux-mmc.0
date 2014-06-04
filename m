From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/6] mmc: sh-mmcif: use devm_ for irq management
Date: Wed,  4 Jun 2014 12:42:11 +0100
Message-ID: <1401882133-11050-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45923 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752574AbaFDLmd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:42:33 -0400
In-Reply-To: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, chris@printf.net, magnus.damm@opensource.se, linus-sh@vger.kernel.org, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>

Use devm_request_threaded_irq() for the host interrupt handlers so we
do not have to worry about freeing them on exit or error. Tidies up the
exit path code for the driver.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index ae278a5..cc6858d 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1439,17 +1439,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
 	name = irq[1] < 0 ? dev_name(&pdev->dev) : "sh_mmc:error";
-	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, name, host);
+	ret = devm_request_threaded_irq(&pdev->dev, irq[0], sh_mmcif_intr,
+					sh_mmcif_irqt, 0, name, host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (%s)\n", name);
-		goto ereqirq0;
+		goto err_irq;
 	}
 	if (irq[1] >= 0) {
-		ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt,
-					   0, "sh_mmc:int", host);
+		ret = devm_request_threaded_irq(&pdev->dev, irq[1],
+						sh_mmcif_intr, sh_mmcif_irqt,
+						0, "sh_mmc:int", host);
 		if (ret) {
 			dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-			goto ereqirq1;
+			goto err_irq;
 		}
 	}
 
@@ -1476,11 +1478,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 emmcaddh:
 erqcd:
-	if (irq[1] >= 0)
-		free_irq(irq[1], host);
-ereqirq1:
-	free_irq(irq[0], host);
-ereqirq0:
+err_irq:
 	pm_runtime_suspend(&pdev->dev);
 err_clk:
 	clk_disable_unprepare(host->hclk);
@@ -1494,7 +1492,6 @@ err_host:
 static int sh_mmcif_remove(struct platform_device *pdev)
 {
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
-	int irq[2];
 
 	host->dying = true;
 	clk_prepare_enable(host->hclk);
@@ -1512,13 +1509,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	 */
 	cancel_delayed_work_sync(&host->timeout_work);
 
-	irq[0] = platform_get_irq(pdev, 0);
-	irq[1] = platform_get_irq(pdev, 1);
-
-	free_irq(irq[0], host);
-	if (irq[1] >= 0)
-		free_irq(irq[1], host);
-
 	clk_disable_unprepare(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.0.0.rc2

