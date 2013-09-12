From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 12:13:20 +0530
Message-ID: <1378968200-16577-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37714 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753393Ab3ILHB2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 03:01:28 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so10266522pdj.21
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 00:01:27 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, spear-devel@list.st.com, sachin.kamat@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

pdata could be NULL if cd_gpio = -1. Hence move the NULL check
outside the if condition.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
Only compile tested.
---
 drivers/mmc/host/sdhci-spear.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8..4f3557a 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -82,12 +82,12 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
 		cd_gpio = -1;
 
 	/* If pdata is required */
-	if (cd_gpio != -1) {
+	if (cd_gpio != -1)
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata) {
-			dev_err(&pdev->dev, "DT: kzalloc failed\n");
-			return ERR_PTR(-ENOMEM);
-		}
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "pdata is NULL\n");
+		return ERR_PTR(-ENOMEM);
 	}
 
 	pdata->card_int_gpio = cd_gpio;
-- 
1.7.9.5

