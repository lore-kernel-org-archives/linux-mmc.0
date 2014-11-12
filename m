From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2] mmc: dw_mmc: add the message for deprecating
 supports-highspeed
Date: Wed, 12 Nov 2014 14:49:42 +0900
Message-ID: <1415771382-30831-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31333 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbaKLFtq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Nov 2014 00:49:46 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NEW00DP7W6VPH30@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 12 Nov 2014 14:49:43 +0900 (KST)
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
Changelog V2:
	- Fixed Checkpatch warning

 drivers/mmc/host/dw_mmc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bb46b1b..d75dc26 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2434,8 +2434,11 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 			return ERR_PTR(ret);
 	}
 
-	if (of_find_property(np, "supports-highspeed", NULL))
+	if (of_find_property(np, "supports-highspeed", NULL)) {
+		dev_warn(dev, "supports-highspeed is deprecated. " \
+				"Use cap-mmc-highspeed or cap-sd-highspeed.\n");
 		pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
+	}
 
 	return pdata;
 }
-- 
1.7.9.5

