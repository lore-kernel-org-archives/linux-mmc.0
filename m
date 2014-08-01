From: yisun1 <yi.y.sun@intel.com>
Subject: [PATCH] mmc: MMC_NUM_PHY_PARTITION is not right.
Date: Fri,  1 Aug 2014 15:03:20 +0800
Message-ID: <1406876600-9376-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16681 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaHAHJb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Aug 2014 03:09:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: yi.y.sun@intel.com

eMMC card can support up to 7 partitions, including 2 boot,
1 RPMB and 4 GPs. But MMC_NUM_PHY_PARTITION is defined to
6 so we should fix it to 7.

Signed-off-by: yisun1 <yi.y.sun@intel.com>
---
 include/linux/mmc/card.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d424b9d..6dadac2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -218,7 +218,7 @@ enum mmc_blk_status {
  */
 #define MMC_NUM_BOOT_PARTITION	2
 #define MMC_NUM_GP_PARTITION	4
-#define MMC_NUM_PHY_PARTITION	6
+#define MMC_NUM_PHY_PARTITION	7
 #define MAX_MMC_PART_NAME_LEN	20
 
 /*
-- 
1.7.9.5

