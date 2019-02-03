From: Avri Altman <avri.altman@wdc.com>
Subject: [PATCH 1/3] mmc: core: Calculate the discard arg only once
Date: Sun,  3 Feb 2019 10:50:26 +0200
Message-ID: <1549183828-17316-2-git-send-email-avri.altman@wdc.com>
References: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1549183828-17316-1-git-send-email-avri.altman@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, Avi Shchislowski <avi.shchislowski@wdc.com>, Alex Lemberg <alex.lemberg@wdc.com>, linux-kernel@vger.kernel.org, Avri Altman <avri.altman@wdc.com>
List-Id: linux-mmc@vger.kernel.org

The discard arg is a read-only ext_csd parameter -
set it once on card init.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/core/block.c | 12 +++---------
 drivers/mmc/core/mmc.c   |  8 ++++++++
 include/linux/mmc/card.h |  2 ++
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index b08fb91..3502f2c 100644
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
+					 card->discard_arg == MMC_TRIM_ARG ?
 					 INAND_CMD38_ARG_TRIM :
 					 INAND_CMD38_ARG_ERASE,
 					 0);
 		}
 		if (!err)
-			err = mmc_erase(card, from, nr, arg);
+			err = mmc_erase(card, from, nr, card->discard_arg);
 	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (err)
 		status = BLK_STS_IOERR;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index da892a5..120739c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1743,6 +1743,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
 	}
 
+	/* set discard_arg */
+	if (mmc_can_discard(card))
+		card->discard_arg = MMC_DISCARD_ARG;
+	else if (mmc_can_trim(card))
+		card->discard_arg = MMC_TRIM_ARG;
+	else
+		card->discard_arg = MMC_ERASE_ARG;
+
 	/*
 	 * Select timing interface
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index de73778..447648b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -308,6 +308,8 @@ struct mmc_card {
 	unsigned int    nr_parts;
 
 	unsigned int		bouncesz;	/* Bounce buffer size */
+
+	unsigned int		discard_arg;	/* discard args */
 };
 
 static inline bool mmc_large_sector(struct mmc_card *card)
-- 
1.9.1
