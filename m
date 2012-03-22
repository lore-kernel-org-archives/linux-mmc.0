From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: block: Remove use of mmc_blk_set_blksize
Date: Thu, 22 Mar 2012 11:47:26 +0100
Message-ID: <1332413246-27953-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:39515 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751309Ab2CVKs4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Mar 2012 06:48:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

According to the specifications for SD and (e)MMC default
blocksize (named BLOCKLEN in Spec.) must always be 512
bytes. Since we hardcoded to always use 512 bytes, we do
not explicitly have to set it. Future improvements should
potentially make it possible to use a greater blocksize
than 512 bytes, but until then let's skip this.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/card/block.c |   27 +--------------------------
 1 files changed, 1 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a7c75d8..ce171c6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1624,24 +1624,6 @@ static int mmc_blk_alloc_parts(struct mmc_card *card, struct mmc_blk_data *md)
 	return ret;
 }
 
-static int
-mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
-{
-	int err;
-
-	mmc_claim_host(card->host);
-	err = mmc_set_blocklen(card, 512);
-	mmc_release_host(card->host);
-
-	if (err) {
-		pr_err("%s: unable to set block size to 512: %d\n",
-			md->disk->disk_name, err);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void mmc_blk_remove_req(struct mmc_blk_data *md)
 {
 	struct mmc_card *card;
@@ -1769,7 +1751,6 @@ static const struct mmc_fixup blk_fixups[] =
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
-	int err;
 	char cap_str[10];
 
 	/*
@@ -1782,10 +1763,6 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (IS_ERR(md))
 		return PTR_ERR(md);
 
-	err = mmc_blk_set_blksize(md, card);
-	if (err)
-		goto out;
-
 	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
 	pr_info("%s: %s %s %s %s\n",
@@ -1810,7 +1787,7 @@ static int mmc_blk_probe(struct mmc_card *card)
  out:
 	mmc_blk_remove_parts(card, md);
 	mmc_blk_remove_req(md);
-	return err;
+	return 0;
 }
 
 static void mmc_blk_remove(struct mmc_card *card)
@@ -1846,8 +1823,6 @@ static int mmc_blk_resume(struct mmc_card *card)
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
 
 	if (md) {
-		mmc_blk_set_blksize(md, card);
-
 		/*
 		 * Resume involves the card going into idle state,
 		 * so current partition is always the main one.
-- 
1.7.9

