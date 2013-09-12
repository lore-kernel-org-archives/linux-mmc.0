From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: wmt-sdmmc: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 13:51:18 +0530
Message-ID: <1378974078-15416-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:63537 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab3ILIj3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 04:39:29 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so10273852pbc.29
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 01:39:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux@prisktech.co.nz, sachin.kamat@linaro.org

'of_id' is dereferenced before NULL pointer check. Move it to
after the check.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
Compile tested.
---
 drivers/mmc/host/wmt-sdmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 34231d5..3523a72 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -771,7 +771,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 		of_match_device(wmt_mci_dt_ids, &pdev->dev);
-	const struct wmt_mci_caps *wmt_caps = of_id->data;
+	const struct wmt_mci_caps *wmt_caps;
 	int ret;
 	int regular_irq, dma_irq;
 
@@ -780,6 +780,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	wmt_caps = of_id->data;
+
 	if (!np) {
 		dev_err(&pdev->dev, "Missing SDMMC description in devicetree\n");
 		return -EFAULT;
-- 
1.7.9.5

