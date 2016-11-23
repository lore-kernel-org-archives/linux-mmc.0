From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] mmc: dw_mmc: add missing codes for runtime resume
Date: Wed, 23 Nov 2016 18:33:52 +0900
Message-ID: <1479893632-1742-1-git-send-email-jy0922.shim@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47941 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933629AbcKWJoN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 04:44:13 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH302MWW9790WB0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2016 18:33:10 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, ulf.hansson@linaro.org, shawn.lin@rock-chips.com, jy0922.shim@samsung.com

The commit 64997de4fd17 ("mmc: dw_mmc: remove system PM callback") is
missing to call dw_mci_ctrl_reset(). This adds to call
dw_mci_ctrl_reset() and to handle error of clocks.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d426fa41bcce..25e21a20ee04 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3303,6 +3303,17 @@ int dw_mci_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
+		clk_disable_unprepare(host->ciu_clk);
+
+		if (host->cur_slot &&
+		    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
+		     !mmc_card_is_removable(host->cur_slot->mmc)))
+			clk_disable_unprepare(host->biu_clk);
+
+		return -ENODEV;
+	}
+
 	if (host->use_dma && host->dma_ops->init)
 		host->dma_ops->init(host);
 
-- 
1.9.1

