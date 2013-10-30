From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 3/7] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Wed, 30 Oct 2013 17:13:46 +0530
Message-ID: <1383133430-22079-3-git-send-email-sachin.kamat@linaro.org>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38542 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab3J3LpP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:45:15 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so819311pad.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:45:15 -0700 (PDT)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
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
index 9b6459d..af3fe87 100644
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

