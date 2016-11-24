From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/3] mmc: dw_mmc: check the "present" variable before checking
 flags
Date: Thu, 24 Nov 2016 20:04:40 +0900
Message-ID: <20161124110442.22058-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37963 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964907AbcKXLPA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 06:15:00 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH5034GM83XHCD0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 24 Nov 2016 20:04:45 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

Before checking flags, it has to check "present" variable.
Otherwise, flags should be cleared everytime.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d400afc..c6cc618 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1536,7 +1536,8 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 	spin_lock_bh(&host->lock);
 	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
 		dev_dbg(&mmc->class_dev, "card is present\n");
-	else if (!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
+	else if (!present &&
+			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
 		dev_dbg(&mmc->class_dev, "card is not present\n");
 	spin_unlock_bh(&host->lock);
 
-- 
2.10.1

