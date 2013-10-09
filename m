From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] mmc: wmt-sdmmc: Prevent NULL dereference for of_id->data
Date: Wed, 09 Oct 2013 09:36:07 +0800
Message-ID: <1381282567.27485.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:57321 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755356Ab3JIBgO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Oct 2013 21:36:14 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so147198pbc.4
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2013 18:36:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-mmc@vger.kernel.org

Ensure having NULL checking for of_id before dereference of_id->data.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/wmt-sdmmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 57858ef..5501c9f 100644
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
 
@@ -771,6 +771,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 		return -EFAULT;
 	}
 
+	wmt_caps = of_id->data;
 	regular_irq = irq_of_parse_and_map(np, 0);
 	dma_irq = irq_of_parse_and_map(np, 1);
 
-- 
1.8.1.2



