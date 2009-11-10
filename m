From: Ben Dooks <ben@simtec.co.uk>
Subject: s3cmci: convert missed s3c2410_gpio calls to gpiolib calls
Date: Tue, 10 Nov 2009 17:15:50 +0000
Message-ID: <20091110171550.185534014@fluff.org.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:46891 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757363AbZKJRPw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2009 12:15:52 -0500
Content-Disposition: inline; filename=simtec/ready/sdmmc-fix-missing-gpio-call.patch
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Simtec Linux Team <linux@simtec.co.uk>

Convert two missed s3c2410 specific gpio calls to gpiolib calls.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/mmc/host/s3cmci.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/mmc/host/s3cmci.c
===================================================================
--- a/drivers/mmc/host/s3cmci.c	2009-11-03 22:31:33.000000000 +0000
+++ b/drivers/mmc/host/s3cmci.c	2009-11-03 22:53:23.000000000 +0000
@@ -1302,10 +1302,8 @@ static int s3cmci_get_ro(struct mmc_host
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
@@ -1654,7 +1652,7 @@ static int __devinit s3cmci_probe(struct
 			goto probe_free_irq;
 		}
 
-		host->irq_cd = s3c2410_gpio_getirq(host->pdata->gpio_detect);
+		host->irq_cd = gpio_to_irq(host->pdata->gpio_detect);
 
 		if (host->irq_cd >= 0) {
 			if (request_irq(host->irq_cd, s3cmci_irq_cd,

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
