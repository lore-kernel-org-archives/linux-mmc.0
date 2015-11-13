From: Holger Schurig <holgerschurig@gmail.com>
Subject: [PATCH 1/6] mmc: move mmc_prepare_mrq() to core.c
Date: Fri, 13 Nov 2015 15:56:07 +0100
Message-ID: <1447426572-11756-2-git-send-email-holgerschurig@gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, avi.shchislowski@sandisk.com, alex.lemberg@sandisk.com
Cc: Holger Schurig <holgerschurig@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Currently this function is used inside the mmc test driver. But it is also
usable in the (upcoming) firmware update patch. So move this function out
of mmc_test.c into core.c.

Signed-off-by: Holger Schurig <holgerschurig@gmail.com>
---
 drivers/mmc/card/mmc_test.c | 48 ++++-----------------------------------------
 drivers/mmc/core/core.c     | 41 ++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h    |  4 ++++
 3 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 7fc9174..69b6c45 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -184,46 +184,6 @@ static int mmc_test_set_blksize(struct mmc_test_card *test, unsigned size)
 	return mmc_set_blocklen(test->card, size);
 }
 
-/*
- * Fill in the mmc_request structure given a set of transfer parameters.
- */
-static void mmc_test_prepare_mrq(struct mmc_test_card *test,
-	struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
-	unsigned dev_addr, unsigned blocks, unsigned blksz, int write)
-{
-	BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
-
-	if (blocks > 1) {
-		mrq->cmd->opcode = write ?
-			MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
-	} else {
-		mrq->cmd->opcode = write ?
-			MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
-	}
-
-	mrq->cmd->arg = dev_addr;
-	if (!mmc_card_blockaddr(test->card))
-		mrq->cmd->arg <<= 9;
-
-	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
-
-	if (blocks == 1)
-		mrq->stop = NULL;
-	else {
-		mrq->stop->opcode = MMC_STOP_TRANSMISSION;
-		mrq->stop->arg = 0;
-		mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
-	}
-
-	mrq->data->blksz = blksz;
-	mrq->data->blocks = blocks;
-	mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
-	mrq->data->sg = sg;
-	mrq->data->sg_len = sg_len;
-
-	mmc_set_data_timeout(mrq->data, test->card);
-}
-
 static int mmc_test_busy(struct mmc_command *cmd)
 {
 	return !(cmd->resp[0] & R1_READY_FOR_DATA) ||
@@ -281,7 +241,7 @@ static int mmc_test_buffer_transfer(struct mmc_test_card *test,
 
 	sg_init_one(&sg, buffer, blksz);
 
-	mmc_test_prepare_mrq(test, &mrq, &sg, 1, addr, 1, blksz, write);
+	mmc_prepare_mrq(test->card, &mrq, &sg, 1, addr, 1, blksz, write);
 
 	mmc_wait_for_req(test->card->host, &mrq);
 
@@ -805,7 +765,7 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	other_areq->err_check = mmc_test_check_result_async;
 
 	for (i = 0; i < count; i++) {
-		mmc_test_prepare_mrq(test, cur_areq->mrq, sg, sg_len, dev_addr,
+		mmc_prepare_mrq(test->card, cur_areq->mrq, sg, sg_len, dev_addr,
 				     blocks, blksz, write);
 		done_areq = mmc_start_req(test->card->host, cur_areq, &ret);
 
@@ -847,7 +807,7 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 	mrq.data = &data;
 	mrq.stop = &stop;
 
-	mmc_test_prepare_mrq(test, &mrq, sg, sg_len, dev_addr,
+	mmc_prepare_mrq(test->card, &mrq, sg, sg_len, dev_addr,
 		blocks, blksz, write);
 
 	mmc_wait_for_req(test->card->host, &mrq);
@@ -876,7 +836,7 @@ static int mmc_test_broken_transfer(struct mmc_test_card *test,
 
 	sg_init_one(&sg, test->buffer, blocks * blksz);
 
-	mmc_test_prepare_mrq(test, &mrq, &sg, 1, 0, blocks, blksz, write);
+	mmc_prepare_mrq(test->card, &mrq, &sg, 1, 0, blocks, blksz, write);
 	mmc_test_prepare_broken_mrq(test, &mrq, write);
 
 	mmc_wait_for_req(test->card->host, &mrq);
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..2b5e398 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2815,6 +2815,47 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 }
 #endif
 
+/*
+ * Fill in the mmc_request structure given a set of transfer parameters.
+ */
+void mmc_prepare_mrq(struct mmc_card *card,
+	struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
+	unsigned dev_addr, unsigned blocks, unsigned blksz, int write)
+{
+	BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
+
+	if (blocks > 1) {
+		mrq->cmd->opcode = write ?
+			MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
+	} else {
+		mrq->cmd->opcode = write ?
+			MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
+	}
+
+	mrq->cmd->arg = dev_addr;
+	if (!mmc_card_blockaddr(card))
+		mrq->cmd->arg <<= 9;
+
+	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	if (blocks == 1)
+		mrq->stop = NULL;
+	else {
+		mrq->stop->opcode = MMC_STOP_TRANSMISSION;
+		mrq->stop->arg = 0;
+		mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+	}
+
+	mrq->data->blksz = blksz;
+	mrq->data->blocks = blocks;
+	mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
+	mrq->data->sg = sg;
+	mrq->data->sg_len = sg_len;
+
+	mmc_set_data_timeout(mrq->data, card);
+}
+EXPORT_SYMBOL(mmc_prepare_mrq);
+
 /**
  * mmc_init_context_info() - init synchronization context
  * @host: mmc host
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 37967b6..f8db960 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -196,6 +196,10 @@ extern int mmc_flush_cache(struct mmc_card *);
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
 
+extern void mmc_prepare_mrq(struct mmc_card *card,
+	struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
+	unsigned dev_addr, unsigned blocks, unsigned blksz, int write);
+
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
-- 
2.1.4
