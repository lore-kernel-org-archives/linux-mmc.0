From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 6/6] mmc: sdhi: support up to 3 interrupt sources
Date: Mon,  9 May 2011 09:55:16 +0900
Message-ID: <1304902516-14150-7-git-send-email-horms@verge.net.au>
References: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50170 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558Ab1EIAzh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 20:55:37 -0400
In-Reply-To: <1304902516-14150-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Convert the SDHI code to support more than a single
interrupt source. Needed to support hardware that
uses GIC instead of INTC as interrupt controller.

Will also allow us to remove the irq forwarding
workaround from the INTC code in the future.

Based on work by Simon Horman and Magnus Damm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
[horms@verge.net.au: edited commit message and cleaned up sob lines]
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   39 ++++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 2bd235b..d264bbe 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -62,7 +62,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int irq, ret;
+	int i, irq, ret;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
@@ -116,16 +116,27 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto eprobe;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto eirq;
+	for (i = 0; i < 3; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			if (i) {
+				continue;
+			} else {
+				ret = irq;
+				goto eirq;
+			}
+		}
+		ret = request_irq(irq, tmio_mmc_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret) {
+			while (i--) {
+				irq = platform_get_irq(pdev, i);
+				if (irq >= 0)
+					free_irq(irq, host);
+			}
+			goto eirq;
+		}
 	}
-
-	ret = request_irq(irq, tmio_mmc_irq, 0, dev_name(&pdev->dev), host);
-	if (ret)
-		goto eirq;
-
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
@@ -148,8 +159,14 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	int i, irq;
+
+	for (i = 0; i < 3; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq >= 0)
+			free_irq(irq, host);
+	}
 
-	free_irq(platform_get_irq(pdev, 0), host);
 	tmio_mmc_host_remove(host);
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
-- 
1.7.4.4

