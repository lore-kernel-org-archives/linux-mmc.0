From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 3/4] mmc: sdhi: Make use of per-source irq handlers
Date: Fri, 19 Aug 2011 10:10:20 +0900
Message-ID: <1313716221-20136-4-git-send-email-horms@verge.net.au>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313716221-20136-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Make use of per-source irq handles if the
platform (data) has multiple irq sources.

Also, as suggested by Guennadi Liakhovetski,
add and use defines the index or irqs in platform data.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

---

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
---
 drivers/mmc/host/sh_mobile_sdhi.c  |   65 +++++++++++++++++++++++------------
 include/linux/mmc/sh_mobile_sdhi.h |    7 ++++
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 774f643..2fa7bbc 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -96,7 +96,8 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int i, irq, ret;
+	int irq, ret, irq_count = 0;
+	irqreturn_t (*f)(int irq, void *devid);
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
@@ -153,27 +154,39 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
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
+	/* Allow a single IRQ resource #0 (CARD_DETECT) which will
+	 * use tmio_mmc_irq() or;
+	 * Allow 2 or 3 IRQ resources in which case SDCARD is required
+	 * and specialised ISRs are used.
+	 */
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0) {
+		irq_count++;
+		ret = request_irq(irq, tmio_mmc_sdcard_irq, 0,
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
+			goto eirq_sdcard;
 	}
+
+	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq_count && irq >= 0) {
+		irq_count++;
+		ret = request_irq(irq, tmio_mmc_sdio_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_sdio;
+	} else if (!irq_count)
+		goto eirq_sdio;
+
+	ret = irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_CARD_DETECT);
+	if (irq >= 0) {
+		f = irq_count ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
+		ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
+		if (ret)
+			goto eirq_card_detect;
+	} else if (irq_count < 2)
+		goto eirq_card_detect;
+
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
@@ -181,7 +194,15 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 
 	return ret;
 
-eirq:
+eirq_card_detect:
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDIO);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdio:
+	irq = platform_get_irq(pdev, SH_MOBILE_SDHI_IRQ_SDCARD);
+	if (irq >= 0)
+		free_irq(irq, host);
+eirq_sdcard:
 	tmio_mmc_host_remove(host);
 eprobe:
 	clk_disable(priv->clk);
@@ -203,7 +224,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 
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
1.7.5.4

