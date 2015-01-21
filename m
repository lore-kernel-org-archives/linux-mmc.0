From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] mmc: block: Remove unnecessary temporary variable
Date: Wed, 21 Jan 2015 15:56:44 +0100
Message-ID: <1421852204-8930-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:49405 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbbAUO4s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Jan 2015 09:56:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Directly return the result of mmc_blk_alloc_req() instead of assigning
and returning the variable md.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/mmc/card/block.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4409d79..2c98b72 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2193,7 +2193,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 {
 	sector_t size;
-	struct mmc_blk_data *md;
 
 	if (!mmc_card_sd(card) && mmc_card_blockaddr(card)) {
 		/*
@@ -2209,9 +2208,8 @@ static struct mmc_blk_data *mmc_blk_alloc(struct mmc_card *card)
 		size = card->csd.capacity << (card->csd.read_blkbits - 9);
 	}
 
-	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
+	return mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
 					MMC_BLK_DATA_AREA_MAIN);
-	return md;
 }
 
 static int mmc_blk_alloc_part(struct mmc_card *card,
-- 
2.2.2


