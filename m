From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 4/4] mmc: sdhi: Make use of per-source irq handlers
Date: Mon, 15 Aug 2011 14:51:28 +0900
Message-ID: <1313387488-28175-5-git-send-email-horms@verge.net.au>
References: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Make use of per-source irq handles if the
platform (data) has multiple irq sources.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   24 ++++++++++++++++++++----
 drivers/mmc/host/tmio_mmc_pio.c   |    2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 774f643..08c1b3b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -97,6 +97,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct tmio_mmc_host *host;
 	char clk_name[8];
 	int i, irq, ret;
+	bool multi_irq = false;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv == NULL) {
@@ -153,7 +154,9 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto eprobe;
 
-	for (i = 0; i < 3; i++) {
+	for (i = 2; i >= 0; i--) {
+		irqreturn_t (*f)(int irq, void *devid);
+
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
 			if (i) {
@@ -163,10 +166,23 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 				goto eirq;
 			}
 		}
-		ret = request_irq(irq, tmio_mmc_irq, 0,
-				  dev_name(&pdev->dev), host);
+
+		switch(i) {
+		case 2:
+			multi_irq = true;
+			f = tmio_mmc_sdio_irq;
+			break;
+		case 1:
+			f = tmio_mmc_card_access_irq;
+			break;
+		case 0:
+			f = multi_irq ? tmio_mmc_card_detect_irq : tmio_mmc_irq;
+			break;
+		}
+
+		ret = request_irq(irq, f, 0, dev_name(&pdev->dev), host);
 		if (ret) {
-			while (i--) {
+			while (i++ < 3) {
 				irq = platform_get_irq(pdev, i);
 				if (irq >= 0)
 					free_irq(irq, host);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 322aa1b..7e01d37 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -613,7 +613,7 @@ irqreturn_t tmio_mmc_card_access_irq(int irq, void *devid)
 
 	pr_debug("MMC Card Access IRQ begin\n");
 	tmio_mmc_card_irq_status(host, &ireg, &irq_mask, &status);
-	__tmio_mmc_card_detect_irq(host, ireg, irq_mask, status);
+	__tmio_mmc_card_access_irq(host, ireg, irq_mask, status);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.5.4

