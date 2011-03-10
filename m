From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Wed,  9 Mar 2011 18:54:08 -0600
Message-ID: <1299718449-15172-5-git-send-email-andreiw@motorola.com>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og101.obsmtp.com ([64.18.0.141]:56208 "EHLO
	exprod5og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1CJAKp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:10:45 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A09OgD017041
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:25 -0500 (EST)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p2A08SW7016828
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:09:24 -0500 (EST)
Received: by mail-gw0-f42.google.com with SMTP id 17so348331gwb.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:10:43 -0800 (PST)
In-Reply-To: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Adjust unaligned write accesses spanning preferred align
size into two accesses - an unaligned and an aligned access.
This is meant to be used for card quirks, and is off
by default. A limiting value in transfer size
for this adjustment is available, as on some cards there is a
perf decrease for larger transfers.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 913f394..a8f18c7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -63,6 +63,8 @@ struct mmc_blk_data {
 
 	unsigned int	usage;
 	unsigned int	read_only;
+	unsigned int	write_align_size;
+	unsigned int	write_align_limit;
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -312,6 +314,43 @@ out:
 	return err ? 0 : 1;
 }
 
+/*
+ * If the request is not aligned, split it into an unaligned
+ * and an aligned portion. Here we can adjust
+ * the size of the MMC request and let the block layer request handle
+ * deal with generating another MMC request.
+ */
+
+static void mmc_adjust_write(struct mmc_card *card,
+			     struct mmc_request *mrq)
+{
+	unsigned int left_in_page;
+	unsigned int wa_size_blocks;
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+
+	if (!md->write_align_size)
+		return;
+
+	if (md->write_align_limit &&
+	    (md->write_align_limit / mrq->data->blksz)
+	    < mrq->data->blocks)
+		return;
+
+	wa_size_blocks = md->write_align_size / mrq->data->blksz;
+	left_in_page = wa_size_blocks -
+		(mrq->cmd->arg % wa_size_blocks);
+
+	/* Aligned access. */
+	if (left_in_page == wa_size_blocks)
+		return;
+
+	/* Not straddling page boundary. */
+	if (mrq->data->blocks <= left_in_page)
+		return;
+
+	mrq->data->blocks = left_in_page;
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -339,6 +378,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		brq.stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 		brq.data.blocks = blk_rq_sectors(req);
 
+		/* Check for unaligned accesses straddling pages. */
+		if (rq_data_dir(req) == WRITE)
+			mmc_adjust_write(card, &brq.mrq);
+
 		/*
 		 * The block layer doesn't support all sector count
 		 * restrictions, so we need to be prepared for too big
-- 
1.7.0.4

