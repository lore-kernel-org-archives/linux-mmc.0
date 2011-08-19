From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/4] mmc: sdhi: Allow name IRQs to use specific handlers
Date: Fri, 19 Aug 2011 16:57:21 +0900
Message-ID: <1313740642-18307-4-git-send-email-horms@verge.net.au>
References: <1313740642-18307-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313740642-18307-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Allow named IRQs to use corresponding specific  handlers.
Allow one or more such IRQ source;
Or allow one or more multiplexed (un-named) IRQ source.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

v7
* As discussed with Magnus Damm
  - The logic implemented to handle specific IRQ sources assumes
    that platform_get_irq() takes into account the index of resource
    entries. However, it does not.

    Instead implement a scheme of named IRQs for specific IRQ sources.
    And assume that un-named IRQs are (legacy) multiplexed IRQs.

    As part of this change alter the logic for allowed IRQ sources as
    follows:
        Allow one or more specific (named) IRRs or;
        One or more multiplexed (un-named) ISRs.

v6
* As discussed with Guennadi Liakhovetski:
  - The SDCARD/SDIO change in v5 was not implemented as described.
    And the logic wasn't fully described in any case. This
    version (hope to!) implement the following logic:
    1) 1 IRQ: only resource #0 (CARD_DETECT, use tmio_mmc_irq())
    2) 2 or 3 IRQs: compulsory SDCARD and any further IRQs: use respective
       specialised ISRs.

v5
* As suggested by Guennadi Liakhovetski:
  - Allow only SH_MOBILE_SDHI_IRQ_SDCARD and
    SH_MOBILE_SDHI_IRQ_SDIO to be specified in platform data

v4
* As suggested by Guennadi Liakhovetski:
  - Correct inverted values of SH_MOBILE_SDHI_IRQ_SDCARD and
    SH_MOBILE_SDHI_IRQ_CARD_DETECT

v3
* Update for changes to "mmc: tmio: Provide separate interrupt handlers"
* As suggested by Guennadi Liakhovetski:
  - Merge in patch "mmc: sdhi: Add defines for platform irq indexes"
  - Use an enum instead of defines for irq indexes

v2
* Update for changes to "mmc: tmio: Provide separate interrupt handlers"
* Make use of defines provided by
  "mmc: sdhi: Add defines for platform irq indexes"
* As suggested by Guennadi Liakhovetski:
  - Don't use a loop to initialise irq handlers, the unrolled version
    is easier on the eyes (and exactly the same number of lines of code!)

wip: driver
---
 drivers/mmc/host/sh_mobile_sdhi.c  |   92 ++++++++++++++++++++++++++----------
 include/linux/mmc/sh_mobile_sdhi.h |    4 ++
 2 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 774f643..c3e9ec7 100644
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
@@ -153,27 +154,54 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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
+	/* Allow one or more specific (named) IRRs or;
+	 * One or more multiplexed (un-named) ISRs.
+	 */
+
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0) {
+		multiplexed_isr = false;
+		ret = request_irq(irq, tmio_mmc_card_detect_irq, 0,
 				  dev_name(&pdev->dev), host);
-		if (ret) {
-			while (i--) {
-				irq = platform_get_irq(pdev, i);
-				if (irq >= 0)
-					free_irq(irq, host);
-			}
-			goto eirq;
+		if (ret)
+			goto eirq_card_detect;
+	}
+
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0) {
+		multiplexed_isr = false;
+		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_sdcard;
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
+	if (multiplexed_isr) {
+		while (1) {
+			irq = platform_get_irq(pdev, i);
+			if (irq < 0)
+				break;
+			i++;
+			ret = request_irq(irq, tmio_mmc_irq, 0,
+				          dev_name(&pdev->dev), host);
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
@@ -181,7 +209,20 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	return ret;
 
-eirq:
+eirq_multiplexed:
+	while (i--) {
+		irq = platform_get_irq(pdev, i);
+		free_irq(irq, host);
+	}
+eirq_sdio:
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdcard:
+	irq = platform_get_irq_byname(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_card_detect:
 	tmio_mmc_host_remove(host);
 eprobe:
 	clk_disable(priv->clk);
@@ -197,16 +238,17 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
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
+	while (0) {
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
-- 
1.7.5.4

