From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/3] mmc: dw_mmc: fix the wrong condition checking
Date: Thu, 06 Aug 2015 16:23:24 +0900
Message-ID: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56193 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbbHFHXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Aug 2015 03:23:30 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN02Q53GJ4D300@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Aug 2015 16:23:28 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

When num-slots is lower than 1, it's right that should be returned -ENODEV.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3c0e199..de88e64 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2760,7 +2760,7 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (host->pdata->num_slots > 1) {
+	if (host->pdata->num_slots < 1) {
 		dev_err(host->dev,
 			"Platform data must supply num_slots.\n");
 		return -ENODEV;
-- 
1.9.1

