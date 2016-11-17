From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 2/9] mmc: dw_mmc: fix the debug message for checking card's
 present
Date: Thu, 17 Nov 2016 16:40:34 +0900
Message-ID: <20161117074041.8641-3-jh80.chung@samsung.com>
References: <20161117074041.8641-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58231 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcKQHk5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2016 02:40:57 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OGR01SAEZZO5X60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 17 Nov 2016 16:40:42 +0900 (KST)
In-reply-to: <20161117074041.8641-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

If display the debug message, this message should be spamming.
If flags is maintained the previous value, didn't display the debug
message.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7ffd57b..6adefb8 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1537,13 +1537,10 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 			== 0 ? 1 : 0;
 
 	spin_lock_bh(&host->lock);
-	if (present) {
-		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
 		dev_dbg(&mmc->class_dev, "card is present\n");
-	} else {
-		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+	else if (!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
 		dev_dbg(&mmc->class_dev, "card is not present\n");
-	}
 	spin_unlock_bh(&host->lock);
 
 	return present;
-- 
2.10.1

