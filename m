From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/3] mmc: dw_mmc: print the message for deprecated property
Date: Thu, 06 Aug 2015 16:23:26 +0900
Message-ID: <1438845806-4486-3-git-send-email-jh80.chung@samsung.com>
References: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58510 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbbHFHXa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Aug 2015 03:23:30 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSN01KRXGJ4AEA0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Aug 2015 16:23:28 +0900 (KST)
In-reply-to: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

supports-highspeed was deprecated.
If someone use it, we need to notice information for it.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 091df65..f8ac14a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2696,8 +2696,10 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
-	if (of_find_property(np, "supports-highspeed", NULL))
+	if (of_find_property(np, "supports-highspeed", NULL)) {
+		dev_info(dev, "supports-highspeed property is deprecated.\n");
 		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
+	}
 
 	return pdata;
 }
-- 
1.9.1

