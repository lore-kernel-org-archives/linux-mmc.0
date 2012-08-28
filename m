From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 5/5] mmc: dw-mmc: fix the present flags for card detect
Date: Tue, 28 Aug 2012 16:55:45 +0900
Message-ID: <503C7981.5050209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32195 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab2H1Hzt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 03:55:49 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9G000OYGNEIH00@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 16:55:48 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9G00G96GOZHPB0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 16:55:47 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

dw_mci_get_cd() is registered to call-back function.
If call host->ops->get_cd(), host didn't set any card present flag.
Then host didn't know whether card is present or not.
This patch fixed them.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Singed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3642455..8a87d38 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -909,10 +909,13 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 		present = (mci_readl(slot->host, CDETECT) & (1 << slot->id))
 			== 0 ? 1 : 0;
 
-	if (present)
+	if (present) {
+		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is present\n");
-	else
+	} else {
+		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 		dev_dbg(&mmc->class_dev, "card is not present\n");
+	}
 
 	return present;
 }
-- 
1.7.4.1
