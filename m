From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: renesas_sdhi: Do not use platform_get_irq() to count interrupts
Date: Tue,  1 Oct 2019 20:07:03 +0200
Message-ID: <20191001180703.910-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Stephen Boyd <swboyd@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, counting interrupts by looping until failure causes the printing
of scary messages like:

    renesas_sdhi_internal_dmac ee140000.sd: IRQ index 1 not found

Fix this by using the platform_irq_count() helper to avoid touching
non-existent interrupts.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.4-rc1.
---
 drivers/mmc/host/renesas_sdhi_core.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index d4ada5cca2d14f6a..122f429602d825bd 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -646,8 +646,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	struct tmio_mmc_dma *dma_priv;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
+	int num_irqs, irq, ret, i;
 	struct resource *res;
-	int irq, ret, i;
 	u16 ver;
 
 	of_data = of_device_get_match_data(&pdev->dev);
@@ -825,24 +825,26 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->hs400_complete = renesas_sdhi_hs400_complete;
 	}
 
-	i = 0;
-	while (1) {
+	/* There must be at least one IRQ source */
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 1) {
+		ret = num_irqs;
+		goto eirq;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
 		irq = platform_get_irq(pdev, i);
-		if (irq < 0)
-			break;
-		i++;
+		if (irq < 0) {
+			ret = irq;
+			goto eirq;
+		}
+
 		ret = devm_request_irq(&pdev->dev, irq, tmio_mmc_irq, 0,
 				       dev_name(&pdev->dev), host);
 		if (ret)
 			goto eirq;
 	}
 
-	/* There must be at least one IRQ source */
-	if (!i) {
-		ret = irq;
-		goto eirq;
-	}
-
 	dev_info(&pdev->dev, "%s base at 0x%08lx max clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
-- 
2.17.1
