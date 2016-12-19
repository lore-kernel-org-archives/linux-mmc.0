From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/2] [RFC] mmc: block: Replace "goto retry" by a proper do / while loop
Date: Mon, 19 Dec 2016 15:03:45 +0100
Message-ID: <1482156225-32517-2-git-send-email-geert@linux-m68k.org>
References: <1482156225-32517-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482156225-32517-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Compile-tested only.

The extra assignment of 0 to err could be avoided:

	do {
		if (!(card->quirks & MMC_QUIRK_INAND_CMD38) ||
		    !(err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
				       INAND_CMD38_ARG_EXT_CSD,
				       arg == MMC_TRIM_ARG ?
				       INAND_CMD38_ARG_TRIM :
				       INAND_CMD38_ARG_ERASE,
				       0)))
			err = mmc_erase(card, from, nr, arg);
	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));

but that looks uglier to me, and makes the quirk handling less obvious.
---
 drivers/mmc/core/block.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8c0e0833d481cf94..4159508df9eea277 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1164,21 +1164,19 @@ static int mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
 		arg = MMC_TRIM_ARG;
 	else
 		arg = MMC_ERASE_ARG;
-retry:
-	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 INAND_CMD38_ARG_EXT_CSD,
-				 arg == MMC_TRIM_ARG ?
-				 INAND_CMD38_ARG_TRIM :
-				 INAND_CMD38_ARG_ERASE,
-				 0);
-		if (err)
-			goto out;
-	}
-	err = mmc_erase(card, from, nr, arg);
-out:
-	if (err == -EIO && !mmc_blk_reset(md, card->host, type))
-		goto retry;
+	do {
+		err = 0;
+		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					 INAND_CMD38_ARG_EXT_CSD,
+					 arg == MMC_TRIM_ARG ?
+					 INAND_CMD38_ARG_TRIM :
+					 INAND_CMD38_ARG_ERASE,
+					 0);
+		}
+		if (!err)
+			err = mmc_erase(card, from, nr, arg);
+	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
 	if (!err)
 		mmc_blk_reset_success(md, type);
 fail:
-- 
1.9.1
