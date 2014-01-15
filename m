From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/9] mmc: davinci: Remove redundant of_match_ptr
Date: Wed, 15 Jan 2014 11:25:08 +0530
Message-ID: <1389765313-16744-4-git-send-email-sachin.kamat@linaro.org>
References: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39121 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaAOF7d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:33 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so667845pdj.12
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:33 -0800 (PST)
In-Reply-To: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

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

