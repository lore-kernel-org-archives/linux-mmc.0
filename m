From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2 4/6] mmc: sh-mmcif: use devm_ for irq management
Date: Tue,  1 Apr 2014 13:01:44 +0100
Message-ID: <1396353706-31864-5-git-send-email-ben.dooks@codethink.co.uk>
References: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

Use devm_request_threaded_irq() for the host interrupt handlers so we
do not have to worry about freeing them on exit or error. Tidies up the
exit path code for the driver.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index fbd7364..c536238 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1441,17 +1441,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
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
 
@@ -1478,11 +1480,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
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
@@ -1496,7 +1494,6 @@ err_host:
 static int sh_mmcif_remove(struct platform_device *pdev)
 {
 	struct sh_mmcif_host *host = platform_get_drvdata(pdev);
-	int irq[2];
 
 	host->dying = true;
 	clk_prepare_enable(host->hclk);
@@ -1514,13 +1511,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
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
1.9.0

