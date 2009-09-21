From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 11/11] s3cmci: Add better support for no card detect or write protect available.
Date: Mon, 21 Sep 2009 14:36:06 +0100
Message-ID: <20090921133724.928955831@smtp.local.simtec.co.uk>
References: <20090921133555.015075699@smtp.local.simtec.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hull.simtec.co.uk ([78.105.113.97]:39671 "EHLO
	preston.local.simtec.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755864AbZIUOVx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2009 10:21:53 -0400
Content-Disposition: inline; filename=simtec/ready/s3cmci-add-nogpio.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org
Cc: ben-linux@fluff.org

Add better support for omitting either the card detect or the write protect
GPIOs if the board does not support it. Add the fields no_wprotect and
no_detect to the platform data which when set indicate the absence of the
respective GPIOs.

Note, this also fixes a minor bug where it tries to free IRQ0 if there is
no detect gpio available.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

---
 arch/arm/plat-s3c24xx/include/plat/mci.h |    2 +
 drivers/mmc/host/s3cmci.c                |   44 ++++++++++++++++---------------
 2 files changed, 26 insertions(+), 20 deletions(-)

Index: b/arch/arm/plat-s3c24xx/include/plat/mci.h
===================================================================
--- a/arch/arm/plat-s3c24xx/include/plat/mci.h	2009-09-16 16:03:32.000000000 +0100
+++ b/arch/arm/plat-s3c24xx/include/plat/mci.h	2009-09-16 16:04:15.000000000 +0100
@@ -2,6 +2,8 @@
 #define _ARCH_MCI_H
 
 struct s3c24xx_mci_pdata {
+	unsigned int	no_wprotect : 1;
+	unsigned int	no_detect : 1;
 	unsigned int	wprotect_invert : 1;
 	unsigned int	detect_invert : 1;   /* set => detect active high. */
 	unsigned int	use_dma : 1;
Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-09-16 16:03:32.000000000 +0100
+++ b/drivers/mmc/host/s3cmci.c	2009-09-16 16:10:15.000000000 +0100
@@ -1299,7 +1299,7 @@ static int s3cmci_get_ro(struct mmc_host
 	struct s3c24xx_mci_pdata *pdata = host->pdata;
 	int ret;
 
-	if (pdata->gpio_wprotect == 0)
+	if (pdata->no_wprotect)
 		return 0;
 
 	ret = s3c2410_gpio_getpin(pdata->gpio_wprotect);
@@ -1647,30 +1647,34 @@ static int __devinit s3cmci_probe(struct
 	disable_irq(host->irq);
 	host->irq_state = false;
 
-	if (host->pdata->gpio_detect) {
+	if (!host->pdata->no_detect) {
 		ret = gpio_request(host->pdata->gpio_detect, "s3cmci detect");
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get detect gpio\n");
 			goto probe_free_irq;
 		}
-	}
 
-	host->irq_cd = s3c2410_gpio_getirq(host->pdata->gpio_detect);
+		host->irq_cd = s3c2410_gpio_getirq(host->pdata->gpio_detect);
 
-	if (host->irq_cd >= 0) {
-		if (request_irq(host->irq_cd, s3cmci_irq_cd,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				DRIVER_NAME, host)) {
-			dev_err(&pdev->dev, "can't get card detect irq.\n");
-			ret = -ENOENT;
-			goto probe_free_gpio_cd;
+		if (host->irq_cd >= 0) {
+			if (request_irq(host->irq_cd, s3cmci_irq_cd,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING,
+					DRIVER_NAME, host)) {
+				dev_err(&pdev->dev,
+					"can't get card detect irq.\n");
+				ret = -ENOENT;
+				goto probe_free_gpio_cd;
+			}
+		} else {
+			dev_warn(&pdev->dev,
+				 "host detect has no irq available\n");
+			gpio_direction_input(host->pdata->gpio_detect);
 		}
-	} else {
-		dev_warn(&pdev->dev, "host detect has no irq available\n");
-		gpio_direction_input(host->pdata->gpio_detect);
-	}
+	} else
+		host->irq_cd = -1;
 
-	if (host->pdata->gpio_wprotect) {
+	if (!host->pdata->no_wprotect) {
 		ret = gpio_request(host->pdata->gpio_wprotect, "s3cmci wp");
 		if (ret) {
 			dev_err(&pdev->dev, "failed to get writeprotect\n");
@@ -1774,11 +1778,11 @@ static int __devinit s3cmci_probe(struct
 		s3c2410_dma_free(host->dma, &s3cmci_dma_client);
 
  probe_free_gpio_wp:
-	if (host->pdata->gpio_wprotect)
+	if (!host->pdata->no_wprotect)
 		gpio_free(host->pdata->gpio_wprotect);
 
  probe_free_gpio_cd:
-	if (host->pdata->gpio_detect)
+	if (!host->pdata->no_detect)
 		gpio_free(host->pdata->gpio_detect);
 
  probe_free_irq_cd:
@@ -1837,10 +1841,10 @@ static int __devexit s3cmci_remove(struc
 
 	free_irq(host->irq, host);
 
-	if (pd->gpio_wprotect)
+	if (!pd->no_wprotect)
 		gpio_free(pd->gpio_wprotect);
 
-	if (pd->gpio_detect)
+	if (!pd->no_detect)
 		gpio_free(pd->gpio_detect);
 
 	for (i = S3C2410_GPE(5); i <= S3C2410_GPE(10); i++)

--
