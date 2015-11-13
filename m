From: Holger Schurig <holgerschurig@gmail.com>
Subject: [PATCH 4/6] mmc: move mmc_simple_transfer() to core.c
Date: Fri, 13 Nov 2015 15:56:10 +0100
Message-ID: <1447426572-11756-5-git-send-email-holgerschurig@gmail.com>
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
 drivers/mmc/card/mmc_test.c | 38 ++++++--------------------------------
 drivers/mmc/core/core.c     | 27 +++++++++++++++++++++++++++
 include/linux/mmc/core.h    |  3 +++
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 1d9d997..94298fa 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -721,32 +721,6 @@ err:
 }
 
 /*
- * Tests a basic transfer with certain parameters
- */
-static int mmc_test_simple_transfer(struct mmc_test_card *test,
-	struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
-	unsigned blocks, unsigned blksz, int write)
-{
-	struct mmc_request mrq = {0};
-	struct mmc_command cmd = {0};
-	struct mmc_command stop = {0};
-	struct mmc_data data = {0};
-
-	mrq.cmd = &cmd;
-	mrq.data = &data;
-	mrq.stop = &stop;
-
-	mmc_prepare_mrq(test->card, &mrq, sg, sg_len, dev_addr,
-		blocks, blksz, write);
-
-	mmc_wait_for_req(test->card->host, &mrq);
-
-	mmc_wait_busy(test->card);
-
-	return mmc_check_result(&mrq);
-}
-
-/*
  * Tests a transfer where the card will fail completely or partly
  */
 static int mmc_test_broken_transfer(struct mmc_test_card *test,
@@ -801,7 +775,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 	if (ret)
 		return ret;
 
-	ret = mmc_test_simple_transfer(test, sg, sg_len, dev_addr,
+	ret = mmc_simple_transfer(test->card, sg, sg_len, dev_addr,
 		blocks, blksz, write);
 	if (ret)
 		return ret;
@@ -875,7 +849,7 @@ static int mmc_test_basic_write(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	return mmc_test_simple_transfer(test, &sg, 1, 0, 1, 512, 1);
+	return mmc_simple_transfer(test->card, &sg, 1, 0, 1, 512, 1);
 }
 
 static int mmc_test_basic_read(struct mmc_test_card *test)
@@ -889,7 +863,7 @@ static int mmc_test_basic_read(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	return mmc_test_simple_transfer(test, &sg, 1, 0, 1, 512, 0);
+	return mmc_simple_transfer(test->card, &sg, 1, 0, 1, 512, 0);
 }
 
 static int mmc_test_verify_write(struct mmc_test_card *test)
@@ -898,7 +872,7 @@ static int mmc_test_verify_write(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	return mmc_test_transfer(test, &sg, 1, 0, 1, 512, 1);
+	return mmc_simple_transfer(test->card, &sg, 1, 0, 1, 512, 1);
 }
 
 static int mmc_test_verify_read(struct mmc_test_card *test)
@@ -907,7 +881,7 @@ static int mmc_test_verify_read(struct mmc_test_card *test)
 
 	sg_init_one(&sg, test->buffer, 512);
 
-	return mmc_test_transfer(test, &sg, 1, 0, 1, 512, 0);
+	return mmc_simple_transfer(test->card, &sg, 1, 0, 1, 512, 0);
 }
 
 static int mmc_test_multi_write(struct mmc_test_card *test)
@@ -1268,7 +1242,7 @@ static int mmc_test_area_transfer(struct mmc_test_card *test,
 {
 	struct mmc_test_area *t = &test->area;
 
-	return mmc_test_simple_transfer(test, t->sg, t->sg_len, dev_addr,
+	return mmc_simple_transfer(test->card, t->sg, t->sg_len, dev_addr,
 					t->blocks, 512, write);
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3254bce..fbc59ad 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2922,6 +2922,33 @@ int mmc_check_result(struct mmc_request *mrq)
 }
 EXPORT_SYMBOL(mmc_check_result);
 
+/*
+ * Run a basic transfer
+ */
+int mmc_simple_transfer(struct mmc_card *card,
+	struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
+	unsigned blocks, unsigned blksz, int write)
+{
+	struct mmc_request mrq = {0};
+	struct mmc_command cmd = {0};
+	struct mmc_command stop = {0};
+	struct mmc_data data = {0};
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+
+	mmc_prepare_mrq(card, &mrq, sg, sg_len, dev_addr,
+		blocks, blksz, write);
+
+	mmc_wait_for_req(card->host, &mrq);
+
+	mmc_wait_busy(card);
+
+	return mmc_check_result(&mrq);
+}
+EXPORT_SYMBOL(mmc_simple_transfer);
+
 /**
  * mmc_init_context_info() - init synchronization context
  * @host: mmc host
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index a5ad2d8..774846f 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -208,6 +208,9 @@ extern void mmc_prepare_mrq(struct mmc_card *card,
 	unsigned dev_addr, unsigned blocks, unsigned blksz, int write);
 extern int mmc_wait_busy(struct mmc_card *card);
 extern int mmc_check_result(struct mmc_request *mrq);
+extern int mmc_simple_transfer(struct mmc_card *test,
+	struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
+	unsigned blocks, unsigned blksz, int write);
 
 /**
  *	mmc_claim_host - exclusively claim a host
-- 
2.1.4
