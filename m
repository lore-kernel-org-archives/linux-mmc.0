From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/9] mmc: wmt-sdmmc: Fix NULL pointer dereference
Date: Wed, 15 Jan 2014 11:25:06 +0530
Message-ID: <1389765313-16744-2-git-send-email-sachin.kamat@linaro.org>
References: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:62610 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaAOF71 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:27 -0500
Received: by mail-pd0-f175.google.com with SMTP id r10so663590pdi.6
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:27 -0800 (PST)
In-Reply-To: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

'of_id' is dereferenced before NULL pointer check. Move it to
after the check.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/mmc/host/wmt-sdmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index e902ed7846b0..498d1f799085 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -757,7 +757,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 		of_match_device(wmt_mci_dt_ids, &pdev->dev);
-	const struct wmt_mci_caps *wmt_caps = of_id->data;
+	const struct wmt_mci_caps *wmt_caps;
 	int ret;
 	int regular_irq, dma_irq;
 
@@ -766,6 +766,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	wmt_caps = of_id->data;
+
 	if (!np) {
 		dev_err(&pdev->dev, "Missing SDMMC description in devicetree\n");
 		return -EFAULT;
-- 
1.7.9.5

