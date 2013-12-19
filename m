From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 3/7] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 19 Dec 2013 14:13:30 +0530
Message-ID: <1387442614-4193-3-git-send-email-sachin.kamat@linaro.org>
References: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:50373 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3LSIq4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 03:46:56 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so857673pbc.40
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 00:46:56 -0800 (PST)
In-Reply-To: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org

pdata could be NULL if cd_gpio = -1. Dereference pdata only
if it is not NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mmc/host/sdhci-spear.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8d1760..76ddd89a688e 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -84,14 +84,12 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
 	/* If pdata is required */
 	if (cd_gpio != -1) {
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
+		if (!pdata)
 			dev_err(&pdev->dev, "DT: kzalloc failed\n");
-			return ERR_PTR(-ENOMEM);
-		}
+		else
+			pdata->card_int_gpio = cd_gpio;
 	}
 
-	pdata->card_int_gpio = cd_gpio;
-
 	return pdata;
 }
 #else
-- 
1.7.9.5

