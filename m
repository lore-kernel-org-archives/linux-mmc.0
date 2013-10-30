From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 2/7] mmc: wmt-sdmmc: Fix NULL pointer dereference
Date: Wed, 30 Oct 2013 17:13:45 +0530
Message-ID: <1383133430-22079-2-git-send-email-sachin.kamat@linaro.org>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:54748 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab3J3LpN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:45:13 -0400
Received: by mail-pb0-f51.google.com with SMTP id wz7so1254943pbc.38
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:45:12 -0700 (PDT)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org

'of_id' is dereferenced before NULL pointer check. Move it to
after the check.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/mmc/host/wmt-sdmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index e902ed7..498d1f7 100644
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

