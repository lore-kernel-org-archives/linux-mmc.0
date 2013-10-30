From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 4/7] mmc: davinci: Remove redundant of_match_ptr
Date: Wed, 30 Oct 2013 17:13:47 +0530
Message-ID: <1383133430-22079-4-git-send-email-sachin.kamat@linaro.org>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:40950 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab3J3LpR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:45:17 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro8so1272464pbb.27
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:45:17 -0700 (PDT)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
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
index d615374..5d4c5e0 100644
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

