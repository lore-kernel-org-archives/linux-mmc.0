From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 4/7] mmc: davinci: Remove redundant of_match_ptr
Date: Thu, 19 Dec 2013 14:13:31 +0530
Message-ID: <1387442614-4193-4-git-send-email-sachin.kamat@linaro.org>
References: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39445 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3LSIq7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 03:46:59 -0500
Received: by mail-pa0-f54.google.com with SMTP id rd3so878559pab.13
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 00:46:58 -0800 (PST)
In-Reply-To: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index d6153740b77f..5d4c5e0fba2f 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1192,7 +1192,7 @@ static struct davinci_mmc_config
 	struct device_node *np;
 	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
 	const struct of_device_id *match =
-		of_match_device(of_match_ptr(davinci_mmc_dt_ids), &pdev->dev);
+		of_match_device(davinci_mmc_dt_ids, &pdev->dev);
 	u32 data;
 
 	np = pdev->dev.of_node;
@@ -1468,7 +1468,7 @@ static struct platform_driver davinci_mmcsd_driver = {
 		.name	= "davinci_mmc",
 		.owner	= THIS_MODULE,
 		.pm	= davinci_mmcsd_pm_ops,
-		.of_match_table = of_match_ptr(davinci_mmc_dt_ids),
+		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.remove		= __exit_p(davinci_mmcsd_remove),
 	.id_table	= davinci_mmc_devtype,
-- 
1.7.9.5

