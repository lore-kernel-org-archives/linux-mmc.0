From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] mmc: pxamci: fix again read-only gpio detection polarity
Date: Fri, 29 Jan 2016 00:21:26 +0100
Message-ID: <1454023286-25832-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:32748 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcA1XVd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 18:21:33 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, stable@vger.kernel.org

The commit fixing the conversion of pxamci to slot-gpio API fixed the
inverted the logic of the read-only gpio. Unfortunately, the commit was
tested on a non-inverted gpio, and not on the inverted one. And the fix
did work partially, by luck.

This is the remaining missing part of the fix, trivial but still necessary.

Fixes: Fixes: 26d49fe71953 ("mmc: pxamci: fix read-only gpio detection polarity")
Reported-by: Andrea Adami <andrea.adami@gmail.com>
Tested-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index ce08896b9d69..28a057fae0a1 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -804,7 +804,7 @@ static int pxamci_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
 		goto out;
 	} else {
-		mmc->caps |= host->pdata->gpio_card_ro_invert ?
+		mmc->caps2 |= host->pdata->gpio_card_ro_invert ?
 			0 : MMC_CAP2_RO_ACTIVE_HIGH;
 	}
 
-- 
2.1.4

