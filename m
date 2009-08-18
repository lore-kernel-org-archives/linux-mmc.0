From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 3/9] s3cmci: Change GPIO to gpiolib from S3C24XX specific calls
Date: Tue, 18 Aug 2009 12:56:07 +0100
Message-ID: <20090818115659.026966661@fluff.org>
References: <20090818115604.056816271@fluff.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:55693 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758723AbZHRL5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 07:57:00 -0400
Content-Disposition: inline; filename=s3cmci-gpiolib-conversion.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Move to using gpiolib to access the card detect and write protect GPIO
lines instead of using the platform speicifc s3c2410_gpio calls.

Also ensure that the card lines are claimed the same way to avoid overlap
with any other drivers.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 drivers/mmc/host/s3cmci.c |   75 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 63 insertions(+), 12 deletions(-)

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-08-04 11:54:17.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-08-04 12:23:56.000000000 +0100
@@ -1047,7 +1047,7 @@ static int s3cmci_card_present(struct mm
 	if (pdata->gpio_detect == 0)
 		return -ENOSYS;
 
-	ret = s3c2410_gpio_getpin(pdata->gpio_detect) ? 0 : 1;
+	ret = gpio_get_value(pdata->gpio_detect) ? 0 : 1;
 	return ret ^ pdata->detect_invert;
 }
 
@@ -1119,8 +1119,7 @@ static void s3cmci_set_ios(struct mmc_ho
 
 	case MMC_POWER_OFF:
 	default:
-		s3c2410_gpio_setpin(S3C2410_GPE5, 0);
-		s3c2410_gpio_cfgpin(S3C2410_GPE5, S3C2410_GPIO_OUTPUT);
+		gpio_direction_output(S3C2410_GPE5, 0);
 
 		if (host->is2440)
 			mci_con |= S3C2440_SDICON_SDRESET;
@@ -1244,12 +1243,14 @@ static inline void s3cmci_cpufreq_deregi
 }
 #endif
 
+
 static int __devinit s3cmci_probe(struct platform_device *pdev)
 {
 	struct s3cmci_host *host;
 	struct mmc_host	*mmc;
 	int ret;
 	int is2440;
+	int i;
 
 	is2440 = platform_get_device_id(pdev)->driver_data;
 
@@ -1259,6 +1260,18 @@ static int __devinit s3cmci_probe(struct
 		goto probe_out;
 	}
 
+	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++) {
+		ret = gpio_request(i, dev_name(&pdev->dev));
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get gpio %d\n", i);
+
+			for (i--; i >= S3C2410_GPE(5); i--)
+				gpio_free(i);
+
+			goto probe_free_host;
+		}
+	}
+
 	host = mmc_priv(mmc);
 	host->mmc 	= mmc;
 	host->pdev	= pdev;
@@ -1295,7 +1308,7 @@ static int __devinit s3cmci_probe(struct
 			"failed to get io memory region resouce.\n");
 
 		ret = -ENOENT;
-		goto probe_free_host;
+		goto probe_free_gpio;
 	}
 
 	host->mem = request_mem_region(host->mem->start,
@@ -1304,7 +1317,7 @@ static int __devinit s3cmci_probe(struct
 	if (!host->mem) {
 		dev_err(&pdev->dev, "failed to request io memory region.\n");
 		ret = -ENOENT;
-		goto probe_free_host;
+		goto probe_free_gpio;
 	}
 
 	host->base = ioremap(host->mem->start, resource_size(host->mem));
@@ -1333,6 +1346,14 @@ static int __devinit s3cmci_probe(struct
 
 	disable_irq(host->irq);
 
+	if (host->pdata->gpio_detect) {
+		ret = gpio_request(host->pdata->gpio_detect, "s3cmci detect");
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get detect gpio\n");
+			goto probe_free_irq;
+		}
+	}
+
 	host->irq_cd = s3c2410_gpio_getirq(host->pdata->gpio_detect);
 
 	if (host->irq_cd >= 0) {
@@ -1341,22 +1362,27 @@ static int __devinit s3cmci_probe(struct
 				DRIVER_NAME, host)) {
 			dev_err(&pdev->dev, "can't get card detect irq.\n");
 			ret = -ENOENT;
-			goto probe_free_irq;
+			goto probe_free_gpio_cd;
 		}
 	} else {
 		dev_warn(&pdev->dev, "host detect has no irq available\n");
-		s3c2410_gpio_cfgpin(host->pdata->gpio_detect,
-				    S3C2410_GPIO_INPUT);
+		gpio_direction_input(host->pdata->gpio_detect);
 	}
 
-	if (host->pdata->gpio_wprotect)
-		s3c2410_gpio_cfgpin(host->pdata->gpio_wprotect,
-				    S3C2410_GPIO_INPUT);
+	if (host->pdata->gpio_wprotect) {
+		ret = gpio_request(host->pdata->gpio_wprotect, "s3cmci wp");
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get writeprotect\n");
+			goto probe_free_irq_cd;
+		}
+
+		gpio_direction_input(host->pdata->gpio_wprotect);
+	}
 
 	if (s3c2410_dma_request(S3CMCI_DMA, &s3cmci_dma_client, NULL) < 0) {
 		dev_err(&pdev->dev, "unable to get DMA channel.\n");
 		ret = -EBUSY;
-		goto probe_free_irq_cd;
+		goto probe_free_gpio_wp;
 	}
 
 	host->clk = clk_get(&pdev->dev, "sdi");
@@ -1423,6 +1449,14 @@ static int __devinit s3cmci_probe(struct
  clk_free:
 	clk_put(host->clk);
 
+ probe_free_gpio_wp:
+	if (host->pdata->gpio_wprotect)
+		gpio_free(host->pdata->gpio_wprotect);
+
+ probe_free_gpio_cd:
+	if (host->pdata->gpio_detect)
+		gpio_free(host->pdata->gpio_detect);
+
  probe_free_irq_cd:
 	if (host->irq_cd >= 0)
 		free_irq(host->irq_cd, host);
@@ -1436,8 +1470,13 @@ static int __devinit s3cmci_probe(struct
  probe_free_mem_region:
 	release_mem_region(host->mem->start, resource_size(host->mem));
 
+ probe_free_gpio:
+	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
+		gpio_free(i);
+
  probe_free_host:
 	mmc_free_host(mmc);
+
  probe_out:
 	return ret;
 }
@@ -1459,6 +1498,8 @@ static int __devexit s3cmci_remove(struc
 {
 	struct mmc_host		*mmc  = platform_get_drvdata(pdev);
 	struct s3cmci_host	*host = mmc_priv(mmc);
+	struct s3c24xx_mci_pdata *pd = host->pdata;
+	int i;
 
 	s3cmci_shutdown(pdev);
 
@@ -1469,6 +1510,16 @@ static int __devexit s3cmci_remove(struc
 
 	free_irq(host->irq, host);
 
+	if (pd->gpio_wprotect)
+		gpio_free(pd->gpio_wprotect);
+
+	if (pd->gpio_detect)
+		gpio_free(pd->gpio_detect);
+
+	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)
+		gpio_free(i);
+
+
 	iounmap(host->base);
 	release_mem_region(host->mem->start, resource_size(host->mem));
 

-- 
