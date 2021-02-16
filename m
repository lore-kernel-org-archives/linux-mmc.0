Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B688C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Feb 2021 22:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF1964DFF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Feb 2021 22:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhBPWwE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Feb 2021 17:52:04 -0500
Received: from smtp1.axis.com ([195.60.68.17]:30260 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhBPWwD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 Feb 2021 17:52:03 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Feb 2021 17:52:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1613515922;
  x=1645051922;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YSeteZGXhIbpjDZ1Q5CQTSher5jytRNLCotDTAMdXbE=;
  b=Fimz06RmwyG6DtXEpqAwHwXdPKA8BsyClQTfWAbcc6Bv1L/dl90rzpYV
   j2md6PGg6qeAoCqdMfOf/+VI/HxhG6vtibJNJ89zAk3SsROWACRSirAHE
   K93pDTKQ7rmn1Vip6BTE8Hxm2U+rLxF5cUJPPEB0Ee6whxo1kHlS96f9p
   m1IWBrUx8bovEiGj7dYqRvERs7lLW+zG0rJLLqk/KdPFDNNZxjWO65tMl
   ZtFYuN6iYiyujc/TPaqT8PJLbr81ks6IFW+ZfXihUxW3wSo89hVqmhFjD
   A/ZhGe5TZlYqPuKCiujPjf+U/6IiBvVS8xkd+IaaZPPpSlQTXa9SOR/ds
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: Try power cycling card if command request times out
Date:   Tue, 16 Feb 2021 23:42:52 +0100
Message-ID: <20210216224252.22187-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sometimes SD cards that has been run for a long time enters a state
where it cannot by itself be recovered, but needs a power cycle to be
operational again. Card status analysis has indicated that the card can
end up in a state where all external commands are ignored by the card
since it is halted by data timeouts.

If the card has been heavily used for a long time it can be weared out,
and should typically be replaced. But on some tests, it shows that the
card can still be functional after a power cycle, but as it requires an
operator to do it, the card can remain in a non-operational state for a
long time until the problem has been observed by the operator.

This patch adds function to power cycle the card in case it does not
respond to a command, and then resend the command if the power cycle
was successful. This procedure will be tested 1 time before giving up,
and resuming host operation as normal.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
Please note: This might not be the way we want to handle these cases,
but at least it lets us start the discussion. In which cases should the
mmc framework deal with error messages like ETIMEDOUT, and in which
cases should it be handled by userspace?
The mmc framework tries to recover a failed block request
(mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
Would it be an idea to act in a similar way when an ioctl times out?

 drivers/mmc/core/block.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 42e27a298218..d007b2af64d6 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -976,6 +976,7 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
  */
 static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 {
+	int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
 	struct mmc_queue_req *mq_rq;
 	struct mmc_card *card = mq->card;
 	struct mmc_blk_data *md = mq->blkdata;
@@ -983,7 +984,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	bool rpmb_ioctl;
 	u8 **ext_csd;
 	u32 status;
-	int ret;
+	int ret, retry = 1;
 	int i;
 
 	mq_rq = req_to_mmc_queue_req(req);
@@ -994,9 +995,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 	case MMC_DRV_OP_IOCTL_RPMB:
 		idata = mq_rq->drv_op_data;
 		for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
+cmd_do:
 			ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
-			if (ret)
+			if (ret == -ETIMEDOUT) {
+				dev_warn(mmc_dev(card->host),
+					 "error %d sending command\n", ret);
+cmd_reset:
+				mmc_blk_reset_success(md, type);
+				if (retry--) {
+					dev_warn(mmc_dev(card->host),
+						 "power cycling card\n");
+					if (mmc_blk_reset
+					    (md, card->host, type))
+						goto cmd_reset;
+					mmc_blk_reset_success(md, type);
+					goto cmd_do;
+				}
 				break;
+			}
 		}
 		/* Always switch back to main area after RPMB access */
 		if (rpmb_ioctl)
-- 
2.11.0

