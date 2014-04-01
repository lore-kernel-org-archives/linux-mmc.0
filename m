From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 5/6] mmc: sh-mmcif: no need to call pm_runtime_suspend on error
Date: Tue,  1 Apr 2014 11:25:53 +0100
Message-ID: <1396347954-13740-6-git-send-email-ben.dooks@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:43756 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751264AbaDAK0F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 06:26:05 -0400
In-Reply-To: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

The pm_runtime call should implicitly disable the device once the
probe is over if there is no explicit reference gained. There is no
need to call pm_runtime_suspend() before the pm_runtime_disable()
call.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 485db7b..c951760 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1447,7 +1447,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 					sh_mmcif_irqt, 0, name, host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (%s)\n", name);
-		goto err_irq;
+		goto err_clk;
 	}
 	if (irq[1] >= 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[1],
@@ -1455,7 +1455,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 						0, "sh_mmc:int", host);
 		if (ret) {
 			dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-			goto err_irq;
+			goto err_clk;
 		}
 	}
 
@@ -1482,8 +1482,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 emmcaddh:
 erqcd:
-err_irq:
-	pm_runtime_suspend(&pdev->dev);
 err_clk:
 	clk_disable_unprepare(host->hclk);
 err_pm:
-- 
1.9.0

