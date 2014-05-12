From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/5] mmc: dw_mmc: fix the wrong condition checking
Date: Mon, 12 May 2014 20:14:12 +0900
Message-ID: <1399893256-7071-2-git-send-email-jh80.chung@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:25855 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaELLO1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 07:14:27 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5G00B3VKK1U9E0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 May 2014 20:14:25 +0900 (KST)
In-reply-to: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org, dinguyen@altera.com, Jaehoon Chung <jh80.chung@samsung.com>

num-slot cab be greater than 1.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d409912..7d4d9ea 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2312,7 +2312,7 @@ int dw_mci_probe(struct dw_mci *host)
 		}
 	}
 
-	if (host->pdata->num_slots > 1) {
+	if (host->pdata->num_slots < 1) {
 		dev_err(host->dev,
 			"Platform data must supply num_slots.\n");
 		return -ENODEV;
-- 
1.7.9.5

