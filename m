From: akpm@linux-foundation.org
Subject: [patch 176/196] s3cmci: convert missed s3c2410_gpio calls to gpiolib calls
Date: Mon, 14 Dec 2009 18:01:27 -0800
Message-ID: <200912150201.nBF21RCR022728@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52852 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756885AbZLOCBt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:01:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ben@simtec.co.uk, linux-mmc@vger.kernel.org, linux@simtec.co.uk

From: Ben Dooks <ben@simtec.co.uk>

Convert two missed s3c2410 specific gpio calls to gpiolib calls.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/s3cmci.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff -puN drivers/mmc/host/s3cmci.c~s3cmci-convert-missed-s3c2410_gpio-calls-to-gpiolib-calls drivers/mmc/host/s3cmci.c
--- a/drivers/mmc/host/s3cmci.c~s3cmci-convert-missed-s3c2410_gpio-calls-to-gpiolib-calls
+++ a/drivers/mmc/host/s3cmci.c
@@ -1303,10 +1303,8 @@ static int s3cmci_get_ro(struct mmc_host
 	if (pdata->no_wprotect)
 		return 0;
 
-	ret = s3c2410_gpio_getpin(pdata->gpio_wprotect);
-
-	if (pdata->wprotect_invert)
-		ret = !ret;
+	ret = gpio_get_value(pdata->gpio_wprotect) ? 1 : 0;
+	ret ^= pdata->wprotect_invert;
 
 	return ret;
 }
@@ -1655,7 +1653,7 @@ static int __devinit s3cmci_probe(struct
 			goto probe_free_irq;
 		}
 
-		host->irq_cd = s3c2410_gpio_getirq(host->pdata->gpio_detect);
+		host->irq_cd = gpio_to_irq(host->pdata->gpio_detect);
 
 		if (host->irq_cd >= 0) {
 			if (request_irq(host->irq_cd, s3cmci_irq_cd,
_
