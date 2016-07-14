From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mmc: pxamci: fix potential oops
Date: Thu, 14 Jul 2016 17:05:50 +0200
Message-ID: <1468508750-28631-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:55181 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNPGl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 11:06:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

As reported by Dan in his report in [1], there is a potential NULL
pointer derefence if these conditions are met :
 - there is no platform_data provided, ie. host->pdata = NULL

Fix this by only using the platform data ro_invert when a gpio for
read-only is provided by the platform data.

This doesn't appear yet as every pxa board provides a platform_data, and
calls pxa_set_mci_info() with a non NULL pointer.

[1] [bug report] mmc: pxamci: fix card detect with slot-gpio API.
The commit fd546ee6a7dc ("mmc: pxamci: fix card detect with slot-gpio
API") from Sep 26, 2015, leads to the following static checker warning:

	drivers/mmc/host/pxamci.c:809 pxamci_probe()
	warn: variable dereferenced before check 'host->pdata' (see line 798)

Fixes: fd546ee6a7dc ("mmc: pxamci: fix card detect with slot-gpio API")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mmc/host/pxamci.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 86fac3e86833..c763b404510f 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -789,14 +789,16 @@ static int pxamci_probe(struct platform_device *pdev)
 		gpio_direction_output(gpio_power,
 				      host->pdata->gpio_power_invert);
 	}
-	if (gpio_is_valid(gpio_ro))
+	if (gpio_is_valid(gpio_ro)) {
 		ret = mmc_gpio_request_ro(mmc, gpio_ro);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
-		goto out;
-	} else {
-		mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
-			0 : MMC_CAP2_RO_ACTIVE_HIGH;
+		if (ret) {
+			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n",
+				gpio_ro);
+			goto out;
+		} else {
+			mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
+				0 : MMC_CAP2_RO_ACTIVE_HIGH;
+		}
 	}
 
 	if (gpio_is_valid(gpio_cd))
-- 
2.1.4

