From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 5/5] mmc: core: add mmc prefix for blk_fixups
Date: Wed,  8 Feb 2017 09:22:31 +0800
Message-ID: <1486516951-188071-1-git-send-email-shawn.lin@rock-chips.com>
References: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:54337 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753568AbdBHBYq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 20:24:46 -0500
In-Reply-To: <1486516546-187771-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

That makes all the quirks table look more consistent.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2: None

 drivers/mmc/core/block.c  | 2 +-
 drivers/mmc/core/quirks.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index c5116f4..30a8974 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2113,7 +2113,7 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (!(card->csd.cmdclass & CCC_BLOCK_READ))
 		return -ENODEV;
 
-	mmc_fixup_device(card, blk_fixups);
+	mmc_fixup_device(card, mmc_blk_fixups);
 
 	md = mmc_blk_alloc(card);
 	if (IS_ERR(md))
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 6db19ad..5406456 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -17,7 +17,7 @@
 
 #include "card.h"
 
-static const struct mmc_fixup blk_fixups[] = {
+static const struct mmc_fixup mmc_blk_fixups[] = {
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
 #define INAND_CMD38_ARG_TRIM     0x01
-- 
1.9.1


