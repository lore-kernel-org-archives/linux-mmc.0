From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 5/5] mmc: core: add mmc prefix for blk_fixups
Date: Tue,  7 Feb 2017 16:28:36 +0800
Message-ID: <1486456116-106053-1-git-send-email-shawn.lin@rock-chips.com>
References: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:57005 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbdBGIaq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 03:30:46 -0500
In-Reply-To: <1486456043-105954-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

That makes all the quirks table look more consistent.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/core/block.c  | 2 +-
 drivers/mmc/core/quirks.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 0c558f8..acd4b34 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2119,7 +2119,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (!(card->csd.cmdclass & CCC_BLOCK_READ))
 		return -ENODEV;
 
-	mmc_fixup_device(card, blk_fixups);
+	mmc_fixup_device(card, mmc_blk_fixups);
 
 	md = mmc_blk_alloc(card);
 	if (IS_ERR(md))
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 083dac3..ce9bb88 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -17,7 +17,7 @@
 
 #include "card.h"
 
-static const struct mmc_fixup blk_fixups[] = {
+static const struct mmc_fixup mmc_blk_fixups[] = {
 	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
 		  MMC_QUIRK_INAND_CMD38),
 	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
-- 
1.9.1


