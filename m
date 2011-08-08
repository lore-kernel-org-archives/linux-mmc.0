From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH 2/2] mmc: core: mmc sanitize feature support for v4.5
Date: Mon, 08 Aug 2011 11:11:33 +0900
Message-ID: <20110808021133.GA20325@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43703 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab1HHCLk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Aug 2011 22:11:40 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LPL00K047FC2EC0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 11:11:38 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LPL00F2V7FE9T@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 08 Aug 2011 11:11:38 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: jh80.chung@samsung.com, arnd@arndb.de

From: Kyungmin Park <kyungmin.park@samsung.com>

In the v4.5, there's no secure erase & trim support.
Instead it supports the sanitize feature.

>From the Spec.:

The Sanitize operation is a feature, in addition to TRIM and Erase that is used to remove data from the device. The use of the Sanitize operation requires the device to physically remove data from the unmapped user address space. A Sanitize operation is initiated by writing a value to the extended CSD[165] SANITIZE_START. While the device is performing the sanitize operation, the busy line is asserted. The device will continue the sanitize operation, with busy asserted, until one of the following events occurs:
. Sanitize operation is complete.
. An HPI is used to abort the operation
. A power failure.
. A hardware reset.

After the sanitize operation is completed, no data should exist in the unmapped host address space. If the sanitize operation is interrupted, either by HPI, power failure or hardware reset, the state of the unmapped host address space cannot be guaranteed. The host must re-initiate the sanitize operation by writing to the SANITIZE_START[165] and allow the operation to complete to be sure that unmapped host address space is clear.
Since the region being operated on is not accessible by the host, applications requiring this feature must work with individual device manufacturers to ensure this operation is performing properly and to understand the impact on device reliability.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/card/block.c |    9 ++++++++-
 drivers/mmc/card/queue.c |    2 +-
 drivers/mmc/core/core.c  |    8 ++++++++
 include/linux/mmc/core.h |    1 +
 include/linux/mmc/mmc.h  |    2 ++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9649997..d96a9b4 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -735,11 +735,18 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 	unsigned int from, nr, arg;
 	int err = 0;
 
-	if (!mmc_can_secure_erase_trim(card)) {
+	if (!(mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))) {
 		err = -EOPNOTSUPP;
 		goto out;
 	}
 
+	/* The sanitize operation is supported at v4.5 only */
+	if (mmc_can_sanitize(card)) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_SANITIZE_START, 1, 0);
+		goto out;
+	}
+
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 45fb362..d7f2f45 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -140,7 +140,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	/* granularity must not be greater than max. discard */
 	if (card->pref_erase > max_discard)
 		q->limits.discard_granularity = 0;
-	if (mmc_can_secure_erase_trim(card))
+	if (mmc_can_secure_erase_trim(card) || mmc_can_sanitize(card))
 		queue_flag_set_unlocked(QUEUE_FLAG_SECDISCARD, q);
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c88fb57..d6232e0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1604,6 +1604,14 @@ int mmc_can_discard(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_can_discard);
 
+int mmc_can_sanitize(struct mmc_card *card)
+{
+	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_SANITIZE)
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL(mmc_can_sanitize);
+
 int mmc_can_secure_erase_trim(struct mmc_card *card)
 {
 	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 6118f10..f1e5773 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -158,6 +158,7 @@ extern int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 extern int mmc_can_erase(struct mmc_card *card);
 extern int mmc_can_trim(struct mmc_card *card);
 extern int mmc_can_discard(struct mmc_card *card);
+extern int mmc_can_sanitize(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 5a794cb..b45628b 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -272,6 +272,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
+#define EXT_CSD_SANITIZE_START		165	/* W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -327,6 +328,7 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_ER_EN	BIT(0)
 #define EXT_CSD_SEC_BD_BLK_EN	BIT(2)
 #define EXT_CSD_SEC_GB_CL_EN	BIT(4)
+#define EXT_CSD_SEC_SANITIZE	BIT(6)	/* v4.5 only */
 
 /*
  * MMC_SWITCH access modes
-- 
1.7.5.1.300.gc565c

