From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/6] mmc: sh-mmcif: use devm_ for ioremap
Date: Tue,  1 Apr 2014 11:25:50 +0100
Message-ID: <1396347954-13740-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:43726 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751118AbaDAK0D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Apr 2014 06:26:03 -0400
In-Reply-To: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Start tidying the probe/release code by using devm_ioremap_resource() to
map the IO registers.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index c48df98..be6be2b 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1379,22 +1379,17 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Get irq error\n");
 		return -ENXIO;
 	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "platform_get_resource error.\n");
-		return -ENXIO;
-	}
-	reg = ioremap(res->start, resource_size(res));
-	if (!reg) {
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg)) {
 		dev_err(&pdev->dev, "ioremap error.\n");
 		return -ENOMEM;
 	}
 
 	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto ealloch;
-	}
+	if (!mmc)
+		return -ENOMEM;
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
@@ -1499,8 +1494,6 @@ eclkget:
 	pm_runtime_disable(&pdev->dev);
 eofparse:
 	mmc_free_host(mmc);
-ealloch:
-	iounmap(reg);
 	return ret;
 }
 
@@ -1525,9 +1518,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	 */
 	cancel_delayed_work_sync(&host->timeout_work);
 
-	if (host->addr)
-		iounmap(host->addr);
-
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 
-- 
1.9.0

