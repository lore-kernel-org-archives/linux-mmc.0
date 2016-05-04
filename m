From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] mmc: dw_mmc: retry to switch voltage when failed
Date: Wed, 04 May 2016 16:14:33 +0900
Message-ID: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:39225 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087AbcEDHOi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 03:14:38 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6N00DVV5GC9N20@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 04 May 2016 16:14:36 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

If vqmmc is used and failed to switch voltage, then retry to switch
voltage. MMC core is providing the retrying scheame.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9dd1bd3..28602cc 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1416,7 +1416,7 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 			dev_dbg(&mmc->class_dev,
 					 "Regulator set error %d - %s V\n",
 					 ret, uhs & v18 ? "1.8" : "3.3");
-			return ret;
+			return -EAGAIN;
 		}
 	}
 	mci_writel(host, UHS_REG, uhs);
-- 
1.9.1

