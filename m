From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 09/13] mmc: sh_mobile_sdhi: use managed resource allocations
Date: Wed,  6 Feb 2013 20:46:56 +0100
Message-ID: <1360180020-18555-10-git-send-email-g.liakhovetski@gmx.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61220 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758032Ab3BFTrP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 14:47:15 -0500
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Use managed allocations to get memory, clock and interrupts . This
significantly simplifies clean up paths.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   57 +++++++++----------------------------
 1 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 17d5778..e095d5c 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -126,7 +126,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	int irq, ret, i = 0;
 	bool multiplexed_isr = true;
 
-	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
 		dev_err(&pdev->dev, "kzalloc failed\n");
 		return -ENOMEM;
@@ -138,11 +138,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		if (p->init) {
 			ret = p->init(pdev, &sdhi_ops);
 			if (ret)
-				goto einit;
+				return ret;
 		}
 	}
 
-	priv->clk = clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		ret = PTR_ERR(priv->clk);
 		dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
@@ -197,33 +197,33 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
 	if (irq >= 0) {
 		multiplexed_isr = false;
-		ret = request_irq(irq, tmio_mmc_card_detect_irq, 0,
+		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_card_detect_irq, 0,
 				  dev_name(&pdev->dev), host);
 		if (ret)
-			goto eirq_card_detect;
+			goto eirq;
 	}
 
 	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
 	if (irq >= 0) {
 		multiplexed_isr = false;
-		ret = request_irq(irq, tmio_mmc_sdio_irq, 0,
+		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdio_irq, 0,
 				  dev_name(&pdev->dev), host);
 		if (ret)
-			goto eirq_sdio;
+			goto eirq;
 	}
 
 	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
 	if (irq >= 0) {
 		multiplexed_isr = false;
-		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
+		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_sdcard_irq, 0,
 				  dev_name(&pdev->dev), host);
 		if (ret)
-			goto eirq_sdcard;
+			goto eirq;
 	} else if (!multiplexed_isr) {
 		dev_err(&pdev->dev,
 			"Principal SD-card IRQ is missing among named interrupts\n");
 		ret = irq;
-		goto eirq_sdcard;
+		goto eirq;
 	}
 
 	if (multiplexed_isr) {
@@ -232,15 +232,15 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 			if (irq < 0)
 				break;
 			i++;
-			ret = request_irq(irq, tmio_mmc_irq, 0,
+			ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 					  dev_name(&pdev->dev), host);
 			if (ret)
-				goto eirq_multiplexed;
+				goto eirq;
 		}
 
 		/* There must be at least one IRQ source */
 		if (!i)
-			goto eirq_multiplexed;
+			goto eirq;
 	}
 
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
@@ -250,28 +250,12 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	return ret;
 
-eirq_multiplexed:
-	while (i--) {
-		irq = platform_get_irq(pdev, i);
-		free_irq(irq, host);
-	}
-eirq_sdcard:
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
-	if (irq >= 0)
-		free_irq(irq, host);
-eirq_sdio:
-	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
-	if (irq >= 0)
-		free_irq(irq, host);
-eirq_card_detect:
+eirq:
 	tmio_mmc_host_remove(host);
 eprobe:
-	clk_put(priv->clk);
 eclkget:
 	if (p && p->cleanup)
 		p->cleanup(pdev);
-einit:
-	kfree(priv);
 	return ret;
 }
 
@@ -279,26 +263,13 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-	int i = 0, irq;
 
 	tmio_mmc_host_remove(host);
 
-	while (1) {
-		irq = platform_get_irq(pdev, i++);
-		if (irq < 0)
-			break;
-		free_irq(irq, host);
-	}
-
-	clk_put(priv->clk);
-
 	if (p && p->cleanup)
 		p->cleanup(pdev);
 
-	kfree(priv);
-
 	return 0;
 }
 
-- 
1.7.2.5

