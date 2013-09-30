From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] mmc: davinci: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 10:29:31 +0530
Message-ID: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37500 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab3I3E7p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Sep 2013 00:59:45 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so5361100pad.0
        for <linux-mmc@vger.kernel.org>; Sun, 29 Sep 2013 21:59:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index e9fa87d..39b311e 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1193,7 +1193,7 @@ static struct davinci_mmc_config
 	struct device_node *np;
 	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
 	const struct of_device_id *match =
-		of_match_device(of_match_ptr(davinci_mmc_dt_ids), &pdev->dev);
+		of_match_device(davinci_mmc_dt_ids, &pdev->dev);
 	u32 data;
 
 	np = pdev->dev.of_node;
@@ -1484,7 +1484,7 @@ static struct platform_driver davinci_mmcsd_driver = {
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

