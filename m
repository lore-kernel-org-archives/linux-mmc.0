From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 03/14] mmc: sh_mmcif: add support for bundled MMCIF IRQs
Date: Wed, 12 Dec 2012 15:38:07 +0100
Message-ID: <1355323098-18061-4-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59264 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab2LLOia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 09:38:30 -0500
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>

On newer SoCs like R-Mobile U2, MMCIF interrupts are bundled.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 8a188fe..d80c294 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1307,10 +1307,11 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	struct sh_mmcif_plat_data *pd = pdev->dev.platform_data;
 	struct resource *res;
 	void __iomem *reg;
+	const char *name;
 
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
-	if (irq[0] < 0 || irq[1] < 0) {
+	if (irq[0] < 0) {
 		dev_err(&pdev->dev, "Get irq error\n");
 		return -ENXIO;
 	}
@@ -1375,15 +1376,19 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	sh_mmcif_sync_reset(host);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
-	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:error", host);
+	name = irq[1] < 0 ? dev_name(&pdev->dev) : "sh_mmc:error";
+	ret = request_threaded_irq(irq[0], sh_mmcif_intr, sh_mmcif_irqt, 0, name, host);
 	if (ret) {
-		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
+		dev_err(&pdev->dev, "request_irq error (%s)\n", name);
 		goto ereqirq0;
 	}
-	ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:int", host);
-	if (ret) {
-		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-		goto ereqirq1;
+	if (irq[1] >= 0) {
+		ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt,
+					   0, "sh_mmc:int", host);
+		if (ret) {
+			dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
+			goto ereqirq1;
+		}
 	}
 
 	if (pd && pd->use_cd_gpio) {
@@ -1408,7 +1413,8 @@ emmcaddh:
 	if (pd && pd->use_cd_gpio)
 		mmc_gpio_free_cd(mmc);
 erqcd:
-	free_irq(irq[1], host);
+	if (irq[1] >= 0)
+		free_irq(irq[1], host);
 ereqirq1:
 	free_irq(irq[0], host);
 ereqirq0:
@@ -1457,7 +1463,8 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	irq[1] = platform_get_irq(pdev, 1);
 
 	free_irq(irq[0], host);
-	free_irq(irq[1], host);
+	if (irq[1] >= 0)
+		free_irq(irq[1], host);
 
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.2.5

