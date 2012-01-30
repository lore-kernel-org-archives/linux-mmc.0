From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH v2 03/16] mmc: fix for some -Wuninitialized warning
Date: Mon, 30 Jan 2012 23:00:07 +0100
Message-ID: <1327960820-11867-4-git-send-email-danny.kukawka@bisect.de>
References: <1327960820-11867-1-git-send-email-danny.kukawka@bisect.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1327960820-11867-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Fix for some -Wuninitialized compiler warnings, by moving the
retry block up so that from, nr and arg variables get set correctly
if the code jumps from the out-block.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/mmc/card/block.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 0cad48a..c9350ae 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -889,6 +889,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 		goto out;
 	}
 
+retry:
 	from = blk_rq_pos(req);
 	nr = blk_rq_sectors(req);
 
@@ -896,7 +897,7 @@ static int mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
 		arg = MMC_SECURE_TRIM1_ARG;
 	else
 		arg = MMC_SECURE_ERASE_ARG;
-retry:
+
 	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 INAND_CMD38_ARG_EXT_CSD,
-- 
1.7.7.3
