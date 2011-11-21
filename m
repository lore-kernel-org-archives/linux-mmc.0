From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend operations
Date: Mon, 21 Nov 2011 18:00:51 +0000
Message-ID: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:44258 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619Ab1KUSAx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2011 13:00:53 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>

Now that the driver is using dev_pm_ops the suspend operations in the
platform_driver structure won't get called so don't need to be there,
and certainly shouldn't be the same function as dev_pm_ops since the
signatures are different.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mmc/host/sdhci-s3c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 4cb272c..9a20d1f 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -647,8 +647,6 @@ static const struct dev_pm_ops sdhci_s3c_pmops = {
 static struct platform_driver sdhci_s3c_driver = {
 	.probe		= sdhci_s3c_probe,
 	.remove		= __devexit_p(sdhci_s3c_remove),
-	.suspend	= sdhci_s3c_suspend,
-	.resume	        = sdhci_s3c_resume,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "s3c-sdhci",
-- 
1.7.7.3

