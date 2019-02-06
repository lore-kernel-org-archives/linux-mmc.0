From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 1/3] mmc: core: Calculate the discard arg only once
Date: Wed,  6 Feb 2019 13:28:05 +0200
Message-ID: <1549452487-17193-2-git-send-email-avri.altman@wdc.com>
References: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549452487-17193-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

In MMC, the discard arg is a read-only ext_csd parameter - set it once
on card init. To be consistent, do that for SD as well even though its
discard arg is always 0x0.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/core.c  |  4 ++--
 drivers/mmc/core/mmc.c   |  8 ++++++++
 drivers/mmc/core/sd.c    |  2 ++
 include/linux/mmc/card.h |  1 +
 include/linux/mmc/sd.h   |  5 +++++
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b08fb91..131e80e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1124,7 +1124,7 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->blkdata;
 	struct mmc_card *card = md->queue.card;
-	unsigned int from, nr, arg;
+	unsigned int from, nr;
 	int err = 0, type = MMC_BLK_DISCARD;
 	blk_status_t status = BLK_STS_OK;
 
@@ -1136,24 +1136,18 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
-	if (mmc_can_discard(card))
-		arg = MMC_DISCARD_ARG;
-	else if (mmc_can_trim(card))
-		arg = MMC_TRIM_ARG;
-	else
-		arg = MMC_ERASE_ARG;
 	do {
 		err = 0;
 		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 					 INAND_CMD38_ARG_EXT_CSD,
-					 arg == MMC_TRIM_ARG ?
+					 card->erase_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
 					 0);
 		}
 		if (!err)
-			err = mmc_erase(card, from, nr, arg);
+			err = mmc_erase(card, from, nr, card->erase_arg);
 	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (err)
 		status = BLK_STS_IOERR;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5bd58b9..de0f1a1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2164,7 +2164,7 @@ static unsigned int mmc_align_erase_size(struct mmc_card *card,
  * @card: card to erase
  * @from: first sector to erase
  * @nr: number of sectors to erase
- * @arg: erase command argument (SD supports only %MMC_ERASE_ARG)
+ * @arg: erase command argument (SD supports only %SD_ERASE_ARG)
  *
  * Caller must claim host before calling this function.
  */
@@ -2181,7 +2181,7 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	if (!card->erase_size)
 		return -EOPNOTSUPP;
 
-	if (mmc_card_sd(card) && arg != MMC_ERASE_ARG)
+	if (mmc_card_sd(card) && arg != SD_ERASE_ARG)
 		return -EOPNOTSUPP;
 
 	if ((arg & MMC_SECURE_ARGS) &&
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index da892a5..09c688f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
 	}
 
+	/* set erase_arg */
+	if (mmc_can_discard(card))
+		card->erase_arg = MMC_DISCARD_ARG;
+	else if (mmc_can_trim(card))
+		card->erase_arg = MMC_TRIM_ARG;
+	else
+		card->erase_arg = MMC_ERASE_ARG;
+
 	/*
 	 * Select timing interface
 	 */
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d0d9f90..bd48b28 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -271,6 +271,8 @@ static int mmc_read_ssr(struct mmc_card *card)
 		}
 	}
 
+	card->erase_arg = SD_ERASE_ARG;
+
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index de73778..8f429b6 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -277,6 +277,7 @@ struct mmc_card {
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
  	unsigned int		pref_erase;	/* in sectors */
 	unsigned int		eg_boundary;	/* don't cross erase-group boundaries */
+	unsigned int		erase_arg;	/* erase / trim / discard */
  	u8			erased_byte;	/* value of erased bytes */
 
 	u32			raw_cid[4];	/* raw card CID */
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 1ebcf9b..1a6d10f 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -91,4 +91,9 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1
 
+/*
+ * Erase/discard
+ */
+#define SD_ERASE_ARG			0x00000000
+
 #endif /* LINUX_MMC_SD_H */
-- 
1.9.1
