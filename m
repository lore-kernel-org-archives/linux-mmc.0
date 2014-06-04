From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 5/6] mmc: sh-mmcif: no need to call pm_runtime_suspend on error
Date: Wed,  4 Jun 2014 12:42:12 +0100
Message-ID: <1401882133-11050-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:45935 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752574AbaFDLme (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 07:42:34 -0400
In-Reply-To: <1401882133-11050-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ulf.hansson@linaro.org, chris@printf.net, magnus.damm@opensource.se, linus-sh@vger.kernel.org, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>

The pm_runtime call should implicitly disable the device once the
probe is over if there is no explicit reference gained. There is no
need to call pm_runtime_suspend() before the pm_runtime_disable()
call.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index cc6858d..b378aa0 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1443,7 +1443,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 					sh_mmcif_irqt, 0, name, host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (%s)\n", name);
-		goto err_irq;
+		goto err_clk;
 	}
 	if (irq[1] >= 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[1],
@@ -1451,7 +1451,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 						0, "sh_mmc:int", host);
 		if (ret) {
 			dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-			goto err_irq;
+			goto err_clk;
 		}
 	}
 
@@ -1478,8 +1478,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 emmcaddh:
 erqcd:
-err_irq:
-	pm_runtime_suspend(&pdev->dev);
 err_clk:
 	clk_disable_unprepare(host->hclk);
 err_pm:
-- 
2.0.0.rc2

