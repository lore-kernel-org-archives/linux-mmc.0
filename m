From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/2] mmc: dw_mmc: set to MMC_CAP_ERASE by default
Date: Fri, 15 Jul 2016 10:54:50 +0900
Message-ID: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44273 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcGOBy4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 21:54:56 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OAC002JL2NG1B90@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 15 Jul 2016 10:54:52 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

This flag needs to use the trim/discard/erase commands.
dwmmc controller enables this flag by default.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9fab5ed..d16de19 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2604,6 +2604,12 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
+	/*
+	 * Support MMC_CAP_ERASE by default.
+	 * It needs to use trim/discard/erase commands.
+	 */
+	mmc->caps |= MMC_CAP_ERASE;
+
 	if (host->pdata->pm_caps)
 		mmc->pm_caps = host->pdata->pm_caps;
 
-- 
1.9.1

