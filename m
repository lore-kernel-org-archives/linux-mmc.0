From: Yi Sun <yi.y.sun@intel.com>
Subject: [PATCH v2] mmc: MMC_NUM_PHY_PARTITION is not right.
Date: Wed, 13 Aug 2014 13:34:01 +0800
Message-ID: <1407908042-12931-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35215 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbaHMFkA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Aug 2014 01:40:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: yi.y.sun@intel.com

eMMC card can support up to 7 partitions, including 2 boot,
1 RPMB and 4 GPs. But MMC_NUM_PHY_PARTITION is defined to
6 so we should fix it to 7.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
---
 include/linux/mmc/card.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d424b9d..bde5147 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -214,11 +214,12 @@ enum mmc_blk_status {
 };
 
 /* The number of MMC physical partitions.  These consist of:
- * boot partitions (2), general purpose partitions (4) in MMC v4.4.
+ * boot partitions (2), general purpose partitions (4) and
+ * RPMB partition (1) in MMC v4.4.
  */
 #define MMC_NUM_BOOT_PARTITION	2
 #define MMC_NUM_GP_PARTITION	4
-#define MMC_NUM_PHY_PARTITION	6
+#define MMC_NUM_PHY_PARTITION	7
 #define MAX_MMC_PART_NAME_LEN	20
 
 /*
-- 
1.7.9.5

