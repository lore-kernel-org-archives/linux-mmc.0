From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 4/5] mmc: sdhi: Make use of per-source irq handlers
Date: Tue, 16 Aug 2011 11:08:18 +0900
Message-ID: <1313460499-3377-5-git-send-email-horms@verge.net.au>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36191 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab1HPCI3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2011 22:08:29 -0400
In-Reply-To: <1313460499-3377-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>

Make use of per-source irq handles if the
platform (data) has multiple irq sources.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   58 +++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 774f643..29dd0c8 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -96,7 +96,9 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int i, irq, ret;
+	int irq, ret;
+	irqreturn_t (*f)(int irq, void *devid);
+	bool multi_irq = false;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
@@ -153,27 +155,33 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto eprobe;
 
-	for (i = 0; i < 3; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq < 0) {
-			if (i) {
-				continue;
-			} else {
-				ret = irq;
-				goto eirq;
-			}
-		}
-		ret = request_irq(irq, tmio_mmc_irq, 0,
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq >= 0) {
+		multi_irq = true;
+		ret = request_irq(irq, tmio_mmc_sdio_irq, 0,
 				  dev_name(&pdev->dev), host);
-		if (ret) {
-			while (i--) {
-				irq = platform_get_irq(pdev, i);
-				if (irq >= 0)
-					free_irq(irq, host);
-			}
-			goto eirq;
-		}
+		if (ret)
+			goto eirq_sdio;
 	}
+
+	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0) {
+		multi_irq = true;
+		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_card_detect;
+	} else if (multi_irq)
+		goto eirq_card_detect;
+
+	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq < 0)
+		goto eirq_sdcard;
+	f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
+	ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
+	if (ret)
+		goto eirq_sdcard;
+
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
@@ -181,7 +189,15 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	return ret;
 
-eirq:
+eirq_sdcard:
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_card_detect:
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdio:
 	tmio_mmc_host_remove(host);
 eprobe:
 	clk_disable(priv->clk);
-- 
1.7.5.4

