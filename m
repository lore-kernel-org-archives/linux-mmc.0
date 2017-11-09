From: Jungseung Lee <js07.lee@samsung.com>
Subject: [PATCH v2] mmc : implement REQ_OP_WRITE_ZEROES
Date: Thu, 09 Nov 2017 21:50:51 +0900
Message-ID: <20171109125051.12772-1-js07.lee@samsung.com>
References: <CGME20171109125101eucas1p2c824f0baade3fef0f15cea043e77caa5@eucas1p2.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39180 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbdKIMvF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Nov 2017 07:51:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, js07.lee@gmail.com, Christoph Hellwig <hch@lst.de>
Cc: Jungseung Lee <js07.lee@samsung.com>

The contents of a write block where the trim function has been applied
shall be '0' or '1' and so some of eMMC devices return zeroes on read to
the trimmed blocks.

Use the behavior to implement REQ_OP_WRITES_ZEROES. We can only know the
behavior based on individual device modles, so this patch adds a flag to
the mmc quirk list for devices works that way. It also sets the new flag
for one such known device.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/mmc/core/block.c  | 8 ++++++--
 drivers/mmc/core/queue.c  | 4 ++++
 drivers/mmc/core/quirks.h | 7 +++++++
 include/linux/mmc/card.h  | 1 +
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ea80ff4..41c4ec1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1273,9 +1273,10 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = md->queue.card;
 	unsigned int from, nr, arg;
 	int err = 0, type = MMC_BLK_DISCARD;
+	int force_trim = (req_op(req) == REQ_OP_WRITE_ZEROES);
 	blk_status_t status = BLK_STS_OK;
 
-	if (!mmc_can_erase(card)) {
+	if (!mmc_can_erase(card) || (!mmc_can_trim(card) && force_trim)) {
 		status = BLK_STS_NOTSUPP;
 		goto fail;
 	}
@@ -1283,7 +1284,9 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
-	if (mmc_can_discard(card))
+	if (force_trim)
+		arg = MMC_TRIM_ARG;
+	else if (mmc_can_discard(card))
 		arg = MMC_DISCARD_ARG;
 	else if (mmc_can_trim(card))
 		arg = MMC_TRIM_ARG;
@@ -2032,6 +2035,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 				mmc_blk_issue_rw_rq(mq, NULL);
 			mmc_blk_issue_drv_op(mq, req);
 			break;
+		case REQ_OP_WRITE_ZEROES:
 		case REQ_OP_DISCARD:
 			/*
 			 * Complete ongoing async transfer before issuing
diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 4f33d27..c18d2a1 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -144,6 +144,10 @@ static void mmc_queue_setup_discard(struct request_queue *q,
 	/* granularity must not be greater than max. discard */
 	if (card->pref_erase > max_discard)
 		q->limits.discard_granularity = 0;
+
+	if (card->quirks & MMC_QUIRK_TRIM_ZEROES)
+		blk_queue_max_write_zeroes_sectors(q, UINT_MAX);
+
 	if (mmc_can_secure_erase_trim(card))
 		queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
 }
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index fb72593..58871ac 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -90,6 +90,13 @@ static const struct mmc_fixup mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Some MMC cards deterministically returns zeroes on reads to
+	 * trimmed logical blocks.
+	 */
+	MMC_FIXUP("8GME4R", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_ZEROES),
+
 	END_FIXUP
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 279b390..d328d1f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -268,6 +268,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_TRIM_ZEROES	(1<<14)		/* Return 0's on read to trimmed logical blocks */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.10.1

