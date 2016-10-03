From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] mmc: core, annotate cmd_hdr as __le32
Date: Mon,  3 Oct 2016 10:58:28 +0200
Message-ID: <20161003085828.15913-1-jslaby@suse.cz>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60141 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbcJCI6b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Oct 2016 04:58:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, linux-mmc@vger.kernel.org

Commit f68381a70b (mmc: block: fix packed command header endianness)
correctly fixed endianness handling of packed_cmd_hdr in
mmc_blk_packed_hdr_wrq_prep.

But now, sparse complains about incorrect types:
drivers/mmc/card/block.c:1613:27: sparse: incorrect type in assignment (different base types)
drivers/mmc/card/block.c:1613:27:    expected unsigned int [unsigned] [usertype] <noident>
drivers/mmc/card/block.c:1613:27:    got restricted __le32 [usertype] <noident>
...

So annotate cmd_hdr properly using __le32 to make everyone happy.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/card/block.c | 2 +-
 drivers/mmc/card/queue.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c3335112e68c..9b71414526e7 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1786,7 +1786,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_packed *packed = mqrq->packed;
 	bool do_rel_wr, do_data_tag;
-	u32 *packed_cmd_hdr;
+	__le32 *packed_cmd_hdr;
 	u8 hdr_blocks;
 	u8 i = 1;
 
diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
index 3c15a75bae86..342f1e3f301e 100644
--- a/drivers/mmc/card/queue.h
+++ b/drivers/mmc/card/queue.h
@@ -31,7 +31,7 @@ enum mmc_packed_type {
 
 struct mmc_packed {
 	struct list_head	list;
-	u32			cmd_hdr[1024];
+	__le32			cmd_hdr[1024];
 	unsigned int		blocks;
 	u8			nr_entries;
 	u8			retries;
-- 
2.10.0

