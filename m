From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/4 v9] mmc: sdhi: Allow named IRQs to use specific handlers
Date: Fri, 26 Aug 2011 10:42:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108261022320.25272@axis700.grange>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
 <1314235648-8959-4-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1314235648-8959-4-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Simon Horman <horms@verge.net.au>

Allow named IRQs to use corresponding specific handlers. If named IRQs are 
used, at least an "sdcard" IRQ has to be specified by the platform. If 
names are not used, an arbitrary number of IRQs can be provided by the 
platform, in which case the generic ISR will be used for each of them.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
[g.liakhovetski@gmx.de: style and typo corrections, platform data check]
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Simon, this is what I propose to commit. I fixed a typo, wrong multi-line 
comment style and indentation spaces in your patch. Besides, I added a 
check to require the SDCARD IRQ if named IRQs are used. It is a common 
practice to verify platform data availability and at least some basic 
correctness and completeness. This check is trivial and adds extra 
robustness to the driver. Please, have a look, whether you agree with my 
version.

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 774f643..d9013ad 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -96,7 +96,8 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int i, irq, ret;
+	int irq, ret, i = 0;
+	bool multiplexed_isr = true;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
@@ -153,27 +154,60 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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
+	/*
+	 * Allow one or more specific (named) ISRs or
+	 * one or more multiplexed (un-named) ISRs.
+	 */
+
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0) {
+		multiplexed_isr = false;
+		ret = request_irq(irq, tmio_mmc_card_detect_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_card_detect;
+	}
+
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq >= 0) {
+		multiplexed_isr = false;
+		ret = request_irq(irq, tmio_mmc_sdio_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_sdio;
+	}
+
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0) {
+		multiplexed_isr = false;
+		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
 				  dev_name(&pdev->dev), host);
-		if (ret) {
-			while (i--) {
-				irq = platform_get_irq(pdev, i);
-				if (irq >= 0)
-					free_irq(irq, host);
-			}
-			goto eirq;
+		if (ret)
+			goto eirq_sdcard;
+	} else if (!multiplexed_isr) {
+		dev_err(&pdev->dev,
+			"Principal SD-card IRQ is missing among named interrupts\n");
+		ret = irq;
+		goto eirq_sdcard;
+	}
+
+	if (multiplexed_isr) {
+		while (1) {
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0)
+				break;
+			i++;
+			ret = request_irq(irq, tmio_mmc_irq, 0,
+					  dev_name(&pdev->dev), host);
+			if (ret)
+				goto eirq_multiplexed;
 		}
+
+		/* There must be at least one IRQ source */
+		if (!i)
+			goto eirq_multiplexed;
 	}
+
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
@@ -181,7 +215,20 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	return ret;
 
-eirq:
+eirq_multiplexed:
+	while (i--) {
+		irq = platform_get_irq(pdev, i);
+		free_irq(irq, host);
+	}
+eirq_sdcard:
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdio:
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_card_detect:
 	tmio_mmc_host_remove(host);
 eprobe:
 	clk_disable(priv->clk);
@@ -197,16 +244,17 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
-	int i, irq;
+	int i = 0, irq;
 
 	p->pdata = NULL;
 
 	tmio_mmc_host_remove(host);
 
-	for (i = 0; i < 3; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq >= 0)
-			free_irq(irq, host);
+	while (1) {
+		irq = platform_get_irq(pdev, i++);
+		if (irq < 0)
+			break;
+		free_irq(irq, host);
 	}
 
 	clk_disable(priv->clk);
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index bd50b36..71b8054 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -6,6 +6,10 @@
 struct platform_device;
 struct tmio_mmc_data;
 
+#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	"card_detect"
+#define SH_MOBILE_SDHI_IRQ_SDCARD	"sdcard"
+#define SH_MOBILE_SDHI_IRQ_SDIO		"sdio"
+
 struct sh_mobile_sdhi_info {
 	int dma_slave_tx;
 	int dma_slave_rx;
