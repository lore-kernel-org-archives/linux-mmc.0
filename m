From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/4] mmc: sdhi: support up to 3 interrupt sources
Date: Fri, 6 May 2011 13:02:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105061301030.10445@axis700.grange>
References: <Pine.LNX.4.64.1105061244120.10445@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55062 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005Ab1EFLC4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 07:02:56 -0400
In-Reply-To: <Pine.LNX.4.64.1105061244120.10445@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: cjb@laptop.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, horms@verge.net.au, linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the SDHI code to support more than a single
interrupt source. Needed to support hardware that
uses GIC instead of INTC as interrupt controller.

Will also allow us to remove the irq forwarding
workaround from the INTC code in the future.

Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
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
1.7.2.5

