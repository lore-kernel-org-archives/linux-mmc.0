From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: dw_mmc: enable card read threshold when mode is HS400
Date: Thu, 05 Mar 2015 19:45:21 +0900
Message-ID: <1425552321-24787-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:21732 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbCEKp0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 05:45:26 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NKQ00M55J7OV860@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 05 Mar 2015 19:45:24 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, alim.akhtar@samsung.com, dianders@chromium.org, Jaehoon Chung <jh80.chung@samsung.com>

Enable card-read-threshold, when eMMC mode is HS400.
Refer to f1d2736c8156 (mmc: dw_mmc: control card read threshold)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b46b825..d0b123e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -764,6 +764,7 @@ static void dw_mci_ctrl_rd_thld(struct dw_mci *host, struct mmc_data *data)
 		return;
 
 	if (host->timing != MMC_TIMING_MMC_HS200 &&
+	    host->timing != MMC_TIMING_MMC_HS400 &&
 	    host->timing != MMC_TIMING_UHS_SDR104)
 		goto disable;
 
-- 
1.7.9.5

