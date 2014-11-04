From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: add the message for deprecating supports-highspeed
Date: Tue, 04 Nov 2014 17:30:55 +0900
Message-ID: <1415089855-18366-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12833 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbaKDIbI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 03:31:08 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEI0027NABSPY40@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 04 Nov 2014 17:31:04 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>

Recommend to use "mmc-cap-highspeed" or "sd-cap-highspeed" instead of
"supports-highspeed".
Although "supports-highspeed" supports, devloper can use
"mmc-cap-highspeed" or "sd-cap-highspeed" through this message.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bb46b1b..7075d33 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2434,8 +2434,11 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
-	if (of_find_property(np, "supports-highspeed", NULL))
+	if (of_find_property(np, "supports-highspeed", NULL)) {
+		dev_warn(dev, "supports-highspeed is deprecated. "
+				"Use cap-mmc-highspeed or cap-sd-highspeed.\n");
 		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
+	}
 
 	return pdata;
 }
-- 
1.7.9.5

