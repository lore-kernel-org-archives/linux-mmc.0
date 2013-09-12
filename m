From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 14:34:03 +0530
Message-ID: <1378976643-26717-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60088 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab3ILJWK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 05:22:10 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so10308982pbc.11
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 02:22:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, spear-devel@list.st.com, sachin.kamat@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

pdata could be NULL if cd_gpio = -1. Dereference pdata only
if it is not NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
Compile tested.
Changes since v1:
* Moved the pdata assignment inside if condition.
---
 drivers/mmc/host/sdhci-spear.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8..76ddd89 100644
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

