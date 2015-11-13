From: Holger Schurig <holgerschurig@gmail.com>
Subject: [PATCH 3/6] mmc: move mmc_check_result() to core.c
Date: Fri, 13 Nov 2015 15:56:09 +0100
Message-ID: <1447426572-11756-4-git-send-email-holgerschurig@gmail.com>
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

This also adds global MMC_RESULT_ variables that show if some condition
stems from the host controller or the card/chip.  This is helpful to
the source in printk.

Signed-off-by: Holger Schurig <holgerschurig@gmail.com>
---
 drivers/mmc/card/mmc_test.c | 109 +++++++++++++++-----------------------------
 drivers/mmc/core/core.c     |  28 ++++++++++++
 include/linux/mmc/core.h    |   8 ++++
 3 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index d1c2d22..1d9d997 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -24,11 +24,6 @@
 #include <linux/seq_file.h>
 #include <linux/module.h>
 
-#define RESULT_OK		0
-#define RESULT_FAIL		1
-#define RESULT_UNSUP_HOST	2
-#define RESULT_UNSUP_CARD	3
-
 #define BUFFER_ORDER		2
 #define BUFFER_SIZE		(PAGE_SIZE << BUFFER_ORDER)
 
@@ -603,34 +598,6 @@ static void mmc_test_prepare_broken_mrq(struct mmc_test_card *test,
 	}
 }
 
-/*
- * Checks that a normal transfer didn't have any errors
- */
-static int mmc_test_check_result(struct mmc_test_card *test,
-				 struct mmc_request *mrq)
-{
-	int ret;
-
-	BUG_ON(!mrq || !mrq->cmd || !mrq->data);
-
-	ret = 0;
-
-	if (!ret && mrq->cmd->error)
-		ret = mrq->cmd->error;
-	if (!ret && mrq->data->error)
-		ret = mrq->data->error;
-	if (!ret && mrq->stop && mrq->stop->error)
-		ret = mrq->stop->error;
-	if (!ret && mrq->data->bytes_xfered !=
-		mrq->data->blocks * mrq->data->blksz)
-		ret = RESULT_FAIL;
-
-	if (ret == -EINVAL)
-		ret = RESULT_UNSUP_HOST;
-
-	return ret;
-}
-
 static int mmc_test_check_result_async(struct mmc_card *card,
 				       struct mmc_async_req *areq)
 {
@@ -639,7 +606,7 @@ static int mmc_test_check_result_async(struct mmc_card *card,
 
 	mmc_wait_busy(test_async->test->card);
 
-	return mmc_test_check_result(test_async->test, areq->mrq);
+	return mmc_check_result(areq->mrq);
 }
 
 /*
@@ -657,21 +624,21 @@ static int mmc_test_check_broken_result(struct mmc_test_card *test,
 	if (!ret && mrq->cmd->error)
 		ret = mrq->cmd->error;
 	if (!ret && mrq->data->error == 0)
-		ret = RESULT_FAIL;
+		ret = MMC_RESULT_FAIL;
 	if (!ret && mrq->data->error != -ETIMEDOUT)
 		ret = mrq->data->error;
 	if (!ret && mrq->stop && mrq->stop->error)
 		ret = mrq->stop->error;
 	if (mrq->data->blocks > 1) {
 		if (!ret && mrq->data->bytes_xfered > mrq->data->blksz)
-			ret = RESULT_FAIL;
+			ret = MMC_RESULT_FAIL;
 	} else {
 		if (!ret && mrq->data->bytes_xfered > 0)
-			ret = RESULT_FAIL;
+			ret = MMC_RESULT_FAIL;
 	}
 
 	if (ret == -EINVAL)
-		ret = RESULT_UNSUP_HOST;
+		ret = MMC_RESULT_UNSUP_HOST;
 
 	return ret;
 }
@@ -776,7 +743,7 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
 
 	mmc_wait_busy(test->card);
 
-	return mmc_test_check_result(test, &mrq);
+	return mmc_check_result(&mrq);
 }
 
 /*
@@ -865,12 +832,12 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 
 		for (i = 0;i < blocks * blksz;i++) {
 			if (test->buffer[i] != (u8)i)
-				return RESULT_FAIL;
+				return MMC_RESULT_FAIL;
 		}
 
 		for (;i < sectors * 512;i++) {
 			if (test->buffer[i] != 0xDF)
-				return RESULT_FAIL;
+				return MMC_RESULT_FAIL;
 		}
 	} else {
 		local_irq_save(flags);
@@ -878,7 +845,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 		local_irq_restore(flags);
 		for (i = 0;i < blocks * blksz;i++) {
 			if (test->scratch[i] != (u8)i)
-				return RESULT_FAIL;
+				return MMC_RESULT_FAIL;
 		}
 	}
 
@@ -949,7 +916,7 @@ static int mmc_test_multi_write(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	size = PAGE_SIZE * 2;
 	size = min(size, test->card->host->max_req_size);
@@ -957,7 +924,7 @@ static int mmc_test_multi_write(struct mmc_test_card *test)
 	size = min(size, test->card->host->max_blk_count * 512);
 
 	if (size < 1024)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	sg_init_one(&sg, test->buffer, size);
 
@@ -970,7 +937,7 @@ static int mmc_test_multi_read(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	size = PAGE_SIZE * 2;
 	size = min(size, test->card->host->max_req_size);
@@ -978,7 +945,7 @@ static int mmc_test_multi_read(struct mmc_test_card *test)
 	size = min(size, test->card->host->max_blk_count * 512);
 
 	if (size < 1024)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	sg_init_one(&sg, test->buffer, size);
 
@@ -991,7 +958,7 @@ static int mmc_test_pow2_write(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (!test->card->csd.write_partial)
-		return RESULT_UNSUP_CARD;
+		return MMC_RESULT_UNSUP_CARD;
 
 	for (i = 1; i < 512;i <<= 1) {
 		sg_init_one(&sg, test->buffer, i);
@@ -1009,7 +976,7 @@ static int mmc_test_pow2_read(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (!test->card->csd.read_partial)
-		return RESULT_UNSUP_CARD;
+		return MMC_RESULT_UNSUP_CARD;
 
 	for (i = 1; i < 512;i <<= 1) {
 		sg_init_one(&sg, test->buffer, i);
@@ -1027,7 +994,7 @@ static int mmc_test_weird_write(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (!test->card->csd.write_partial)
-		return RESULT_UNSUP_CARD;
+		return MMC_RESULT_UNSUP_CARD;
 
 	for (i = 3; i < 512;i += 7) {
 		sg_init_one(&sg, test->buffer, i);
@@ -1045,7 +1012,7 @@ static int mmc_test_weird_read(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (!test->card->csd.read_partial)
-		return RESULT_UNSUP_CARD;
+		return MMC_RESULT_UNSUP_CARD;
 
 	for (i = 3; i < 512;i += 7) {
 		sg_init_one(&sg, test->buffer, i);
@@ -1094,7 +1061,7 @@ static int mmc_test_align_multi_write(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	size = PAGE_SIZE * 2;
 	size = min(size, test->card->host->max_req_size);
@@ -1102,7 +1069,7 @@ static int mmc_test_align_multi_write(struct mmc_test_card *test)
 	size = min(size, test->card->host->max_blk_count * 512);
 
 	if (size < 1024)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
@@ -1121,7 +1088,7 @@ static int mmc_test_align_multi_read(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	size = PAGE_SIZE * 2;
 	size = min(size, test->card->host->max_req_size);
@@ -1129,7 +1096,7 @@ static int mmc_test_align_multi_read(struct mmc_test_card *test)
 	size = min(size, test->card->host->max_blk_count * 512);
 
 	if (size < 1024)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	for (i = 1; i < TEST_ALIGN_END; i++) {
 		sg_init_one(&sg, test->buffer + i, size);
@@ -1168,7 +1135,7 @@ static int mmc_test_multi_xfersize_write(struct mmc_test_card *test)
 	int ret;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	ret = mmc_test_set_blksize(test, 512);
 	if (ret)
@@ -1182,7 +1149,7 @@ static int mmc_test_multi_xfersize_read(struct mmc_test_card *test)
 	int ret;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	ret = mmc_test_set_blksize(test, 512);
 	if (ret)
@@ -1219,7 +1186,7 @@ static int mmc_test_multi_write_high(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	size = PAGE_SIZE * 2;
 	size = min(size, test->card->host->max_req_size);
@@ -1227,7 +1194,7 @@ static int mmc_test_multi_write_high(struct mmc_test_card *test)
 	size = min(size, test->card->host->max_blk_count * 512);
 
 	if (size < 1024)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, size, 0);
@@ -1241,7 +1208,7 @@ static int mmc_test_multi_read_high(struct mmc_test_card *test)
 	struct scatterlist sg;
 
 	if (test->card->host->max_blk_count == 1)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	size = PAGE_SIZE * 2;
 	size = min(size, test->card->host->max_req_size);
@@ -1249,7 +1216,7 @@ static int mmc_test_multi_read_high(struct mmc_test_card *test)
 	size = min(size, test->card->host->max_blk_count * 512);
 
 	if (size < 1024)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	sg_init_table(&sg, 1);
 	sg_set_page(&sg, test->highmem, size, 0);
@@ -1615,10 +1582,10 @@ static int mmc_test_profile_trim_perf(struct mmc_test_card *test)
 	int ret;
 
 	if (!mmc_can_trim(test->card))
-		return RESULT_UNSUP_CARD;
+		return MMC_RESULT_UNSUP_CARD;
 
 	if (!mmc_can_erase(test->card))
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	for (sz = 512; sz < t->max_sz; sz <<= 1) {
 		dev_addr = t->dev_addr + (sz >> 9);
@@ -1732,10 +1699,10 @@ static int mmc_test_profile_seq_trim_perf(struct mmc_test_card *test)
 	int ret;
 
 	if (!mmc_can_trim(test->card))
-		return RESULT_UNSUP_CARD;
+		return MMC_RESULT_UNSUP_CARD;
 
 	if (!mmc_can_erase(test->card))
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
 	for (sz = 512; sz <= t->max_sz; sz <<= 1) {
 		ret = mmc_test_area_erase(test);
@@ -2193,11 +2160,11 @@ static int mmc_test_reset(struct mmc_test_card *test)
 
 	err = mmc_hw_reset(host);
 	if (!err)
-		return RESULT_OK;
+		return MMC_RESULT_OK;
 	else if (err == -EOPNOTSUPP)
-		return RESULT_UNSUP_HOST;
+		return MMC_RESULT_UNSUP_HOST;
 
-	return RESULT_FAIL;
+	return MMC_RESULT_FAIL;
 }
 
 static const struct mmc_test_case mmc_test_cases[] = {
@@ -2584,20 +2551,20 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
 
 		ret = mmc_test_cases[i].run(test);
 		switch (ret) {
-		case RESULT_OK:
+		case MMC_RESULT_OK:
 			pr_info("%s: Result: OK\n",
 				mmc_hostname(test->card->host));
 			break;
-		case RESULT_FAIL:
+		case MMC_RESULT_FAIL:
 			pr_info("%s: Result: FAILED\n",
 				mmc_hostname(test->card->host));
 			break;
-		case RESULT_UNSUP_HOST:
+		case MMC_RESULT_UNSUP_HOST:
 			pr_info("%s: Result: UNSUPPORTED "
 				"(by host)\n",
 				mmc_hostname(test->card->host));
 			break;
-		case RESULT_UNSUP_CARD:
+		case MMC_RESULT_UNSUP_CARD:
 			pr_info("%s: Result: UNSUPPORTED "
 				"(by card)\n",
 				mmc_hostname(test->card->host));
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index df5a61c..3254bce 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2894,6 +2894,34 @@ int mmc_wait_busy(struct mmc_card *card)
 }
 EXPORT_SYMBOL(mmc_wait_busy);
 
+/*
+ * Checks that a normal transfer didn't have any errors
+ */
+int mmc_check_result(struct mmc_request *mrq)
+{
+	int ret;
+
+	BUG_ON(!mrq || !mrq->cmd || !mrq->data);
+
+	ret = 0;
+
+	if (!ret && mrq->cmd->error)
+		ret = mrq->cmd->error;
+	if (!ret && mrq->data->error)
+		ret = mrq->data->error;
+	if (!ret && mrq->stop && mrq->stop->error)
+		ret = mrq->stop->error;
+	if (!ret && mrq->data->bytes_xfered !=
+		mrq->data->blocks * mrq->data->blksz)
+		ret = MMC_RESULT_FAIL;
+
+	if (ret == -EINVAL)
+		ret = MMC_RESULT_UNSUP_HOST;
+
+	return ret;
+}
+EXPORT_SYMBOL(mmc_check_result);
+
 /**
  * mmc_init_context_info() - init synchronization context
  * @host: mmc host
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 50e37e1..a5ad2d8 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -81,6 +81,13 @@ struct mmc_command {
 	unsigned int		retries;	/* max number of retries */
 	int			error;		/* command error */
 
+/* for mmc_check_result() */
+#define MMC_RESULT_OK		0
+#define MMC_RESULT_FAIL		1
+#define MMC_RESULT_UNSUP_HOST	2
+#define MMC_RESULT_UNSUP_CARD	3
+
+
 /*
  * Standard errno values are used for errors, but some have specific
  * meaning in the MMC layer:
@@ -200,6 +207,7 @@ extern void mmc_prepare_mrq(struct mmc_card *card,
 	struct mmc_request *mrq, struct scatterlist *sg, unsigned sg_len,
 	unsigned dev_addr, unsigned blocks, unsigned blksz, int write);
 extern int mmc_wait_busy(struct mmc_card *card);
+extern int mmc_check_result(struct mmc_request *mrq);
 
 /**
  *	mmc_claim_host - exclusively claim a host
-- 
2.1.4
