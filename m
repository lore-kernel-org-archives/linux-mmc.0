From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/4 v7] mmc: sdhi: Make use of per-source irq handlers
Date: Thu, 18 Aug 2011 00:02:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1108172359410.3566@axis700.grange>
References: <1313578756-10413-1-git-send-email-horms@verge.net.au>
 <1313578756-10413-4-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108171320310.18317@axis700.grange> <20110817114147.GA13086@verge.net.au>
 <20110817120748.GB13086@verge.net.au> <Pine.LNX.4.64.1108171416010.18317@axis700.grange>
 <20110817125728.GD13086@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110817125728.GD13086@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

From: Simon Horman <horms@verge.net.au>

Make use of per-source irq handles if the
platform (data) has multiple irq sources.

Also, as suggested by Guennadi Liakhovetski,
add and use defines the index or irqs in platform data.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
[g.liakhovetski@gmx.de: fixed IRQ requesting logic]
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

No, your last version was wrong too. Please, give this a go and tell me if 
it works as expected.

Thanks
Guennadi

 drivers/mmc/host/sh_mobile_sdhi.c  |   67 ++++++++++++++++++++++++------------
 include/linux/mmc/sh_mobile_sdhi.h |    7 ++++
 2 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 774f643..2e3ec8b 100644
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
@@ -153,27 +155,40 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0) {
+		multi_irq = true;
+		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_sdcard;
+	} else if (multi_irq) {
+		ret = irq;
+		goto eirq_sdcard;
+	}
+
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0) {
+		f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
+		ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_card_detect;
+	} else if (!multi_irq) {
+		ret = irq;
+		goto eirq_card_detect;
+	} else {
+		ret = 0;
+	}
+
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
@@ -181,7 +196,15 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	return ret;
 
-eirq:
+eirq_card_detect:
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdcard:
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdio:
 	tmio_mmc_host_remove(host);
 eprobe:
 	clk_disable(priv->clk);
@@ -203,7 +226,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 
 	tmio_mmc_host_remove(host);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < SH_MOBILE_SDHI_IRQ_MAX; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq >= 0)
 			free_irq(irq, host);
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index bd50b36..80d3629 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -3,6 +3,13 @@
 
 #include <linux/types.h>
 
+enum {
+	SH_MOBILE_SDHI_IRQ_CARD_DETECT = 0,
+	SH_MOBILE_SDHI_IRQ_SDCARD,
+	SH_MOBILE_SDHI_IRQ_SDIO,
+	SH_MOBILE_SDHI_IRQ_MAX
+};
+
 struct platform_device;
 struct tmio_mmc_data;
 
-- 
1.7.2.5

