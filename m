From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v4 1/3]mmc: set max_discard_sectors value for mmc queue
Date: Sat, 12 Feb 2011 14:22:14 +0800
Message-ID: <20110212062214.GB25519@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

max_discard_sectors value is UINT_MAX which means kernel block layer can pass
down unlimited sectors to MMC driver to erase. But erasing so many sectors may
delay some other important I/O requests. This is not preferred.

So use 'pref_erase' to set a suitable max_discard_sectors value for mmc queue to
avoid erasing too many sectors at one time.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/card/queue.c |    3 ++-
 drivers/mmc/core/core.c  |   20 ++++++++++++++++++++
 include/linux/mmc/core.h |    1 +
 3 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 4e42d03..6c13859 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -131,7 +131,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, mq->queue);
 	if (mmc_can_erase(card)) {
 		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, mq->queue);
-		mq->queue->limits.max_discard_sectors = UINT_MAX;
+		mq->queue->limits.max_discard_sectors =
+			mmc_set_max_discard_sectors(card);
 		if (card->erased_byte == 0)
 			mq->queue->limits.discard_zeroes_data = 1;
 		if (!mmc_can_trim(card) && is_power_of_2(card->erase_size)) {
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 34a7e8c..0eb27aa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1470,6 +1470,26 @@ int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 }
 EXPORT_SYMBOL(mmc_erase_group_aligned);
 
+/*
+ * Set max_discard_sectors for mmc queue.
+ * max_discard_sectors will determine how many sectors can be erased at one
+ * time. Sometimes user may want to erase a large area of SD or MMC card, it may
+ * take long time which delay some other important I/O requests. So we would
+ * better set some values for max_discard_sectors which can forbid block layer
+ * pass too many sectors at one time.
+ *
+ * 'pref_erase' is initialized for this purpose. We can use it to set a preferred
+ * value for it.
+ */
+int mmc_set_max_discard_sectors(struct mmc_card *card)
+{
+	if (card->pref_erase)
+		return card->pref_erase;
+	else
+		return UINT_MAX;
+}
+EXPORT_SYMBOL(mmc_set_max_discard_sectors);
+
 int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd;
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 64e013f..a218d57 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -152,6 +152,7 @@ extern int mmc_can_trim(struct mmc_card *card);
 extern int mmc_can_secure_erase_trim(struct mmc_card *card);
 extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 				   unsigned int nr);
+extern int mmc_set_max_discard_sectors(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 
-- 
1.6.6.1
