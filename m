From: Andrei Warkentin <andreiw@motorola.com>
Subject: [[RFC] 4/5] MMC: Block quirks request adjust support.
Date: Fri,  4 Mar 2011 21:21:13 -0600
Message-ID: <1299295274-32130-5-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-1-git-send-email-andreiw@motorola.com>
 <1299295274-32130-2-git-send-email-andreiw@motorola.com>
 <1299295274-32130-3-git-send-email-andreiw@motorola.com>
 <1299295274-32130-4-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:60142 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1CEChQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2011 21:37:16 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p252ZxLM010492
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:35:59 -0500 (EST)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p252Yo73010291
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 4 Mar 2011 21:35:59 -0500 (EST)
Received: by mail-yi0-f42.google.com with SMTP id 21so1628160yic.15
        for <linux-mmc@vger.kernel.org>; Fri, 04 Mar 2011 18:37:15 -0800 (PST)
In-Reply-To: <1299295274-32130-4-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Lets a card specific quirk affect how MMC requests are made.
Necessary for Toshiba block-splitting part reliability workaround.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/blk.h          |    9 ++++++---
 drivers/mmc/card/block-quirks.c |    5 ++---
 drivers/mmc/card/block.c        |   12 ++++++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/card/blk.h b/drivers/mmc/card/blk.h
index 3e7b8e6..3e72b67 100644
--- a/drivers/mmc/card/blk.h
+++ b/drivers/mmc/card/blk.h
@@ -18,7 +18,7 @@ struct mmc_blk_data;
 		     card->cid.year,  \
 		     card->cid.month)
 
-#define MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, _rev_start, _rev_end, _probe) \
+#define MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, _rev_start, _rev_end, _probe, _adjust) \
 	{							\
 		.name = (_name),				\
 		.manfid = (_manfid),				\
@@ -26,10 +26,11 @@ struct mmc_blk_data;
 		.rev_start = (_rev_start),			\
 		.rev_end = (_rev_end),				\
 		.probe = (_probe),				\
+		.adjust = (_adjust),				\
 	}
 
-#define MMC_BLK_QUIRK(_name, _manfid, _oemid, _probe) \
-	MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, 0, -1ull, _probe)
+#define MMC_BLK_QUIRK(_name, _manfid, _oemid, _probe, _adjust)	\
+	MMC_BLK_QUIRK_VERSION(_name, _manfid, _oemid, 0, -1ull, _probe, _adjust)
 
 extern struct mmc_blk_quirk *mmc_blk_quirk_find(struct mmc_card *card);
 #else
@@ -51,6 +52,7 @@ struct mmc_blk_quirk {
 	unsigned int manfid;
 	unsigned short oemid;
 	int (*probe)(struct mmc_blk_data *, struct mmc_card *);
+	void (*adjust)(struct mmc_queue *, struct request *, struct mmc_request *);
 };
 
 /*
@@ -65,6 +67,7 @@ struct mmc_blk_data {
 	unsigned int	read_only;
 	unsigned int	write_align_size;
 	unsigned int	write_align_limit;
+	struct mmc_blk_quirk *quirk;
 };
 
 #endif
diff --git a/drivers/mmc/card/block-quirks.c b/drivers/mmc/card/block-quirks.c
index c142ffb..4afa872 100644
--- a/drivers/mmc/card/block-quirks.c
+++ b/drivers/mmc/card/block-quirks.c
@@ -31,7 +31,6 @@ static int toshiba_32nm_probe(struct mmc_blk_data *md, struct mmc_card *card)
 }
 #endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
 
-
 /*
    Caveat: Because this list is just looked up with a linear
    search, take care that either overlapping revision ranges
@@ -40,8 +39,8 @@ static int toshiba_32nm_probe(struct mmc_blk_data *md, struct mmc_card *card)
 */
 struct mmc_blk_quirk mmc_blk_quirks[] = {
 #ifdef CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM
-        MMC_BLK_QUIRK("MMC16G", 0x11, 0x0, toshiba_32nm_probe),
-        MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100, toshiba_32nm_probe),
+        MMC_BLK_QUIRK("MMC16G", 0x11, 0x0, toshiba_32nm_probe, NULL),
+        MMC_BLK_QUIRK("MMC32G", 0x11, 0x0100, toshiba_32nm_probe, NULL),
 #endif /* CONFIG_MMC_BLOCK_QUIRK_TOSHIBA_32NM */
 };
 
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 8640902..52e66d6 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -413,6 +413,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		brq.data.sg = mq->sg;
 		brq.data.sg_len = mmc_queue_map_sg(mq);
 
+#ifdef CONFIG_MMC_BLOCK_QUIRKS
+	if (md->quirk && md->quirk->adjust)
+		md->quirk->adjust(mq, req, &brq.mrq);
+#endif /* CONFIG_MMC_BLOCK_QUIRKS */
+
 		/*
 		 * Adjust the sg list so it is the same size as the
 		 * request.
@@ -719,7 +724,6 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md;
-	struct mmc_blk_quirk *quirk;
 	int err;
 
 	char cap_str[10];
@@ -738,9 +742,9 @@ static int mmc_blk_probe(struct mmc_card *card)
 	if (err)
 		goto out;
 
-	quirk = mmc_blk_quirk_find(card);
-	if (quirk && quirk->probe)
-		err = quirk->probe(md, card);
+	md->quirk = mmc_blk_quirk_find(card);
+	if (md->quirk && md->quirk->probe)
+		err = md->quirk->probe(md, card);
 	if (err)
 		goto out;
 
-- 
1.7.0.4

