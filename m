From: "Sun, Yi Y" <yi.y.sun@intel.com>
Subject: RE: [PATCH] mmc: MMC_NUM_PHY_PARTITION is not right.
Date: Tue, 12 Aug 2014 09:29:40 +0000
Message-ID: <525EAED47491124EB5123A51BD2FC791019D95FD@SHSMSX101.ccr.corp.intel.com>
References: <1406876600-9376-1-git-send-email-yi.y.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22056 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbaHLJbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 05:31:31 -0400
In-Reply-To: <1406876600-9376-1-git-send-email-yi.y.sun@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi, Ulf,

Could you please check this fix? Thanks!

BRs,
Sun Yi

-----Original Message-----
From: Sun, Yi Y 
Sent: Friday, August 01, 2014 3:03 PM
To: linux-mmc@vger.kernel.org
Cc: Sun, Yi Y
Subject: [PATCH] mmc: MMC_NUM_PHY_PARTITION is not right.

eMMC card can support up to 7 partitions, including 2 boot,
1 RPMB and 4 GPs. But MMC_NUM_PHY_PARTITION is defined to
6 so we should fix it to 7.

Signed-off-by: yisun1 <yi.y.sun@intel.com>
---
 include/linux/mmc/card.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index d424b9d..6dadac2 100644
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

