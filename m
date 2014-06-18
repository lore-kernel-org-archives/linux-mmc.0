From: Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH] mmc: Do not advertise secure discard if it is blacklisted
Date: Wed, 18 Jun 2014 13:18:07 +0200
Message-ID: <1403090287-10673-1-git-send-email-lczerner@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45966 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933174AbaFRLSU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Jun 2014 07:18:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, chris@printf.net, Lukas Czerner <lczerner@redhat.com>

Currently when the device secure discard implementation is
blacklisted (MMC_QUIRK_SEC_ERASE_TRIM_BROKEN quirk is set)
instead of secure discard we're going to do normal discard,
which is wrong.

When the secure discard is known to be broken we should just
disallow it entirely and not advertise this functionality to
the user. Fix it.

Also move mmc_fixup_device() in from of mmc_blk_alloc() so we
can get quirks set before we attempt to set queue information.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 drivers/mmc/card/block.c | 6 +++---
 drivers/mmc/core/core.c  | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 452782b..ede41f0 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2028,8 +2028,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* complete ongoing async transfer before issuing discard */
 		if (card->host->areq)
 			mmc_blk_issue_rw_rq(mq, NULL);
-		if (req->cmd_flags & REQ_SECURE &&
-			!(card->quirks & MMC_QUIRK_SEC_ERASE_TRIM_BROKEN))
+		if (req->cmd_flags & REQ_SECURE)
 			ret = mmc_blk_issue_secdiscard_rq(mq, req);
 		else
 			ret = mmc_blk_issue_discard_rq(mq, req);
@@ -2432,6 +2431,8 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (!(card->csd.cmdclass & CCC_BLOCK_READ))
 		return -ENODEV;
 
+	mmc_fixup_device(card, blk_fixups);
+
 	md = mmc_blk_alloc(card);
 	if (IS_ERR(md))
 		return PTR_ERR(md);
@@ -2446,7 +2447,6 @@ static int mmc_blk_probe(struct mmc_card *card)
 		goto out;
 
 	mmc_set_drvdata(card, md);
-	mmc_fixup_device(card, blk_fixups);
 
 	if (mmc_add_disk(md))
 		goto out;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..d03a080 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2102,7 +2102,8 @@ EXPORT_SYMBOL(mmc_can_sanitize);
 
 int mmc_can_secure_erase_trim(struct mmc_card *card)
 {
-	if (card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN)
+	if ((card->ext_csd.sec_feature_support & EXT_CSD_SEC_ER_EN) &&
+	    !(card->quirks & MMC_QUIRK_SEC_ERASE_TRIM_BROKEN))
 		return 1;
 	return 0;
 }
-- 
1.8.3.1

