Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com [220.197.31.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0E390C90;
	Mon, 30 Mar 2026 04:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845872; cv=none; b=cuL8K778LddixkbR5FffJUHl7JFGpXaBHiVPlL6xQmcirMlHRqOFFXLUqIxoiXrcWdf0cGKYt+txgtyevdkh5zCAn9Sov6FSr3xL6PLREFbzGfpv08FadMCPnRAg7eVuRWuDq6YK+YtvKdRRmHdDizgaVF4oQ6MGC9IIDzBcNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845872; c=relaxed/simple;
	bh=pFYeMsTf81Cl+Psok6PkYmttP6d07XXweNreOdZbpS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VXeamE+Hb/C4KGFmJQMQ9M3Ai8jEiUJd8vdiPcwlJtrMDRswCjXFuLJ/m/Uo9Nzqbp15Dwhds5abhwI8Fy5IIHmLtxmeFYchVVIH1wM1L1h8DzkPicjjqmNOJ1J8sjvIhPH4Srejb/LR6ur46JHTWWPNLYzh73rnBwdQjNECxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=dQe/l5CS; arc=none smtp.client-ip=220.197.31.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="dQe/l5CS"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38c2332df;
	Mon, 30 Mar 2026 11:28:51 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/4] mmc: block: Use MQRQ_XFER_SINGLE_BLOCK for both read and write recovery
Date: Mon, 30 Mar 2026 11:28:32 +0800
Message-Id: <1774841312-92409-5-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
References: <1774841312-92409-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d3cc9802f09cckunmd82a3513dfee94
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksZSFYdTkIfTUpKTU9LHUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dQe/l5CSKwnCIEGcAfXfWCnLENKT/QypsrG1kJTfBByUPxXhhazjIdLwTQKVzMIWa21SAZwmlkk64j4baSe//qO+U/575Dk5mQOkDUrSRepKNlI4J9K30u98cgFUFrlVXqOR+cB1uyoo/XFkVDy8iOj19aWewPTp0IFIY2gw6Vs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=sCFuKJdZv28jAe2p5V34BEQSKdzuv40qyLTQNeXzpMY=;
	h=date:mime-version:subject:message-id:from;

Currently, the code uses the MQRQ_XFER_SINGLE_BLOCK flag to handle write
failures by retrying with single-block transfers. However, read failures
bypass this mechanism and instead use a dedicated legacy path mmc_blk_read_single()
that performs sector-by-sector retries.

Extend the MQRQ_XFER_SINGLE_BLOCK logic to cover multi-block read failures
as well. By doing so, we can remove the redundant and complex mmc_blk_read_single()
function, unifying the retry logic for both read and write operations under
a single, consistent, easier-to-maintain mechanism.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 70 ++----------------------------------------------
 1 file changed, 2 insertions(+), 68 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 53c1b04..0274e8d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1544,8 +1544,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 
 	if (err) {
 		if (mqrq->retries++ < MMC_CQE_RETRIES) {
-			if (rq_data_dir(req) == WRITE)
-				mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
+			mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
 			blk_mq_requeue_request(req, true);
 		} else {
 			blk_mq_end_request(req, BLK_STS_IOERR);
@@ -1782,63 +1781,6 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 	return err;
 }
 
-#define MMC_READ_SINGLE_RETRIES	2
-
-/* Single (native) sector read during recovery */
-static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
-{
-	struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
-	struct mmc_request *mrq = &mqrq->brq.mrq;
-	struct mmc_card *card = mq->card;
-	struct mmc_host *host = card->host;
-	blk_status_t error = BLK_STS_OK;
-	size_t bytes_per_read = queue_physical_block_size(mq->queue);
-
-	do {
-		u32 status;
-		int err;
-		int retries = 0;
-
-		while (retries++ <= MMC_READ_SINGLE_RETRIES) {
-			mmc_blk_rw_rq_prep(mqrq, card, 1, mq);
-
-			mmc_wait_for_req(host, mrq);
-
-			err = mmc_send_status(card, &status);
-			if (err)
-				goto error_exit;
-
-			if (!mmc_host_is_spi(host) &&
-			    !mmc_ready_for_data(status)) {
-				err = mmc_blk_fix_state(card, req);
-				if (err)
-					goto error_exit;
-			}
-
-			if (!mrq->cmd->error)
-				break;
-		}
-
-		if (mrq->cmd->error ||
-		    mrq->data->error ||
-		    (!mmc_host_is_spi(host) &&
-		     (mrq->cmd->resp[0] & CMD_ERRORS || status & CMD_ERRORS)))
-			error = BLK_STS_IOERR;
-		else
-			error = BLK_STS_OK;
-
-	} while (blk_update_request(req, error, bytes_per_read));
-
-	return;
-
-error_exit:
-	mrq->data->bytes_xfered = 0;
-	blk_update_request(req, BLK_STS_IOERR, bytes_per_read);
-	/* Let it try the remaining request again */
-	if (mqrq->retries > MMC_MAX_RETRIES - 1)
-		mqrq->retries = MMC_MAX_RETRIES - 1;
-}
-
 static inline bool mmc_blk_oor_valid(struct mmc_blk_request *brq)
 {
 	return !!brq->mrq.sbc;
@@ -1974,13 +1916,6 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 		mqrq->retries = MMC_MAX_RETRIES - MMC_DATA_RETRIES;
 		return;
 	}
-
-	if (rq_data_dir(req) == READ && brq->data.blocks >
-			queue_physical_block_size(mq->queue) >> SECTOR_SHIFT) {
-		/* Read one (native) sector at a time */
-		mmc_blk_read_single(mq, req);
-		return;
-	}
 }
 
 static inline bool mmc_blk_rq_error(struct mmc_blk_request *brq)
@@ -2091,8 +2026,7 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
 	} else if (!blk_rq_bytes(req)) {
 		__blk_mq_end_request(req, BLK_STS_IOERR);
 	} else if (mqrq->retries++ < MMC_MAX_RETRIES) {
-		if (rq_data_dir(req) == WRITE)
-			mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
+		mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
 		blk_mq_requeue_request(req, true);
 	} else {
 		if (mmc_card_removed(mq->card))
-- 
2.7.4

