From: Andrei Warkentin <andreiw@motorola.com>
Subject: [RFC 1/3] MMC: Adjust unaligned write accesses.
Date: Tue,  1 Mar 2011 16:09:02 -0600
Message-ID: <1299017344-25361-2-git-send-email-andreiw@motorola.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:40525 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479Ab1CAVYf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 16:24:35 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p21LOmQx021420
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:24:48 -0500 (EST)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p21LOSuV021301
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 1 Mar 2011 16:24:47 -0500 (EST)
Received: by mail-yi0-f42.google.com with SMTP id 21so3532451yic.15
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2011 13:24:32 -0800 (PST)
In-Reply-To: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>

Adjust unaligned write accesses spanning preferred align
size into two accesses - an unaligned and an aligned access.
This is meant to be used for card quirks, and is off
by default.

Change-Id: Ic4ce561a4a72a13f34d1a88ad669f98e3c7b9d90
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7054fd5..498c439 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -63,6 +63,7 @@ struct mmc_blk_data {
 
 	unsigned int	usage;
 	unsigned int	read_only;
+	unsigned int	write_align_size;
 };
 
 static DEFINE_MUTEX(open_lock);
@@ -312,6 +313,39 @@ out:
 	return err ? 0 : 1;
 }
 
+/*
+ * If the request is not aligned, split it into an unaligned
+ * and an aligned portion. Here we can adjust
+ * the size of the MMC request and let the block layer request handle
+ * deal with generating another MMC request.
+ */
+
+static bool mmc_adjust_write(struct mmc_card *card,
+			     struct mmc_request *mrq)
+{
+	unsigned int left_in_page;
+	unsigned int wa_size_blocks;
+	struct mmc_blk_data *md = mmc_get_drvdata(card);
+
+	if (!md->write_align_size)
+		return false;
+
+	wa_size_blocks = md->write_align_size / mrq->data->blksz;
+	left_in_page = wa_size_blocks -
+		(mrq->cmd->arg % wa_size_blocks);
+
+	/* Aligned access. */
+	if (left_in_page == wa_size_blocks)
+		return false;
+
+	/* Not straddling page boundary. */
+	if (mrq->data->blocks <= left_in_page)
+		return false;
+
+	mrq->data->blocks = left_in_page;
+	return true;
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -339,6 +373,10 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
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

