From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 3/3] MMC: add checking of r/w command response
Date: Mon, 20 Jun 2011 20:10:49 +0100
Message-ID: <E1QYjs1-000806-20@rmk-PC.arm.linux.org.uk>
References: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59166 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab1FTTK5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 15:10:57 -0400
In-Reply-To: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.orglinux-mmc@vger.kernel.orglinux-arm-kernel@lists.infradead.org

Check the status bits in the r/w command response for any errors.
If error bits are set, then we won't have seen any data transferred,
so its pointless doing any further checking.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/card/block.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index aa074c8..e5d1c8a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -812,6 +812,14 @@ static inline void mmc_apply_rel_rw(struct mmc_blk_request *brq,
 	}
 }
 
+#define CMD_ERRORS							\
+	(R1_OUT_OF_RANGE |	/* Command argument out of range */	\
+	 R1_ADDRESS_ERROR |	/* Misaligned address */		\
+	 R1_BLOCK_LEN_ERROR |	/* Transferred block length incorrect */\
+	 R1_WP_VIOLATION |	/* Tried to write to protected block */	\
+	 R1_CC_ERROR |		/* Card controller error */		\
+	 R1_ERROR)		/* General/unknown error */
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 {
 	struct mmc_blk_data *md = mq->data;
@@ -967,6 +975,22 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 			}
 		}
 
+		/*
+		 * Check for errors relating to the execution of the
+		 * initial command - such as address errors.  No data
+		 * has been transferred.
+		 */
+		if (brq.cmd.resp[0] & CMD_ERRORS) {
+			pr_err("%s: r/w command failed, status = %#x\n",
+				req->rq_disk->disk_name, brq.cmd.resp[0]);
+			goto cmd_abort;
+		}
+
+		/*
+		 * Everything else is either success, or a data error of some
+		 * kind.  If it was a write, we may have transitioned to
+		 * program mode, which we have to wait for it to complete.
+		 */
 		if (!mmc_host_is_spi(card->host) && rq_data_dir(req) != READ) {
 			u32 status;
 			do {
@@ -986,7 +1010,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *req)
 		}
 
 		if (brq.data.error) {
-			pr_err("%s: error %d transferring data, sector %u nr %u, cmd response %#x card status %#x\n",
+			pr_err("%s: error %d transferring data, sector %u, nr %u, cmd response %#x, card status %#x\n",
 				req->rq_disk->disk_name, brq.data.error,
 				(unsigned)blk_rq_pos(req),
 				(unsigned)blk_rq_sectors(req),
-- 
1.7.4.4

