From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 03/10] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Tue, 25 Feb 2014 15:18:21 +0530
Message-ID: <1393321708-9719-3-git-send-email-sachin.kamat@linaro.org>
References: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:61287 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaBYJyX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 04:54:23 -0500
Received: by mail-pd0-f177.google.com with SMTP id g10so1910440pdj.8
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 01:54:22 -0800 (PST)
In-Reply-To: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org

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

