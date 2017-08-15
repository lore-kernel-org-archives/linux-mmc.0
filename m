From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] mmc: test: reduce stack usage in mmc_test_nonblock_transfer
Date: Tue, 15 Aug 2017 17:11:58 +0200
Message-ID: <20170815151242.2637861-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Byungchul Park <byungchul.park@lge.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The new lockdep annotations for completions cause a warning in the
mmc test module, in a function that now has four 150 byte structures
on the stack:

drivers/mmc/core/mmc_test.c: In function 'mmc_test_nonblock_transfer.constprop':
drivers/mmc/core/mmc_test.c:892:1: error: the frame size of 1360 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

The mmc_test_ongoing_transfer function evidently had a similar problem,
and worked around it by using dynamic allocation.

This generalizes the approach used by mmc_test_ongoing_transfer() and
applies it to mmc_test_nonblock_transfer() as well.

Fixes: cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The patch causing this is currently part of linux-next, scheduled for
4.14, so it would be good to have this in the same release.

Since the change is not entirely trivial, please test this before applying.
---
 drivers/mmc/core/mmc_test.c | 97 +++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 7a304a6e5bf1..478869805b96 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -800,38 +800,44 @@ static int mmc_test_check_broken_result(struct mmc_test_card *test,
 	return ret;
 }
 
+struct mmc_test_req {
+	struct mmc_request mrq;
+	struct mmc_command sbc;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_command status;
+	struct mmc_data data;
+};
+
 /*
  * Tests nonblock transfer with certain parameters
  */
-static void mmc_test_nonblock_reset(struct mmc_request *mrq,
-				    struct mmc_command *cmd,
-				    struct mmc_command *stop,
-				    struct mmc_data *data)
+static void mmc_test_req_reset(struct mmc_test_req *rq)
+{
+	memset(rq, 0, sizeof(struct mmc_test_req));
+
+	rq->mrq.cmd = &rq->cmd;
+	rq->mrq.data = &rq->data;
+	rq->mrq.stop = &rq->stop;
+}
+
+static struct mmc_test_req *mmc_test_req_alloc(void)
 {
-	memset(mrq, 0, sizeof(struct mmc_request));
-	memset(cmd, 0, sizeof(struct mmc_command));
-	memset(data, 0, sizeof(struct mmc_data));
-	memset(stop, 0, sizeof(struct mmc_command));
+	struct mmc_test_req *rq = kmalloc(sizeof(*rq), GFP_KERNEL);
 
-	mrq->cmd = cmd;
-	mrq->data = data;
-	mrq->stop = stop;
+	if (rq)
+		mmc_test_req_reset(rq);
+
+	return rq;
 }
+
+
 static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 				      struct scatterlist *sg, unsigned sg_len,
 				      unsigned dev_addr, unsigned blocks,
 				      unsigned blksz, int write, int count)
 {
-	struct mmc_request mrq1;
-	struct mmc_command cmd1;
-	struct mmc_command stop1;
-	struct mmc_data data1;
-
-	struct mmc_request mrq2;
-	struct mmc_command cmd2;
-	struct mmc_command stop2;
-	struct mmc_data data2;
-
+	struct mmc_test_req *rq1, *rq2;
 	struct mmc_test_async_req test_areq[2];
 	struct mmc_async_req *done_areq;
 	struct mmc_async_req *cur_areq = &test_areq[0].areq;
@@ -843,12 +849,16 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	test_areq[0].test = test;
 	test_areq[1].test = test;
 
-	mmc_test_nonblock_reset(&mrq1, &cmd1, &stop1, &data1);
-	mmc_test_nonblock_reset(&mrq2, &cmd2, &stop2, &data2);
+	rq1 = mmc_test_req_alloc();
+	rq2 = mmc_test_req_alloc();
+	if (!rq1 || !rq2) {
+		ret = RESULT_FAIL;
+		goto err;
+	}
 
-	cur_areq->mrq = &mrq1;
+	cur_areq->mrq = &rq1->mrq;
 	cur_areq->err_check = mmc_test_check_result_async;
-	other_areq->mrq = &mrq2;
+	other_areq->mrq = &rq2->mrq;
 	other_areq->err_check = mmc_test_check_result_async;
 
 	for (i = 0; i < count; i++) {
@@ -861,14 +871,10 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 			goto err;
 		}
 
-		if (done_areq) {
-			if (done_areq->mrq == &mrq2)
-				mmc_test_nonblock_reset(&mrq2, &cmd2,
-							&stop2, &data2);
-			else
-				mmc_test_nonblock_reset(&mrq1, &cmd1,
-							&stop1, &data1);
-		}
+		if (done_areq)
+			mmc_test_req_reset(container_of(done_areq->mrq,
+						struct mmc_test_req, mrq));
+
 		swap(cur_areq, other_areq);
 		dev_addr += blocks;
 	}
@@ -877,8 +883,9 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	if (status != MMC_BLK_SUCCESS)
 		ret = RESULT_FAIL;
 
-	return ret;
 err:
+	kfree(rq1);
+	kfree(rq2);
 	return ret;
 }
 
@@ -2329,28 +2336,6 @@ static int mmc_test_reset(struct mmc_test_card *test)
 	return RESULT_FAIL;
 }
 
-struct mmc_test_req {
-	struct mmc_request mrq;
-	struct mmc_command sbc;
-	struct mmc_command cmd;
-	struct mmc_command stop;
-	struct mmc_command status;
-	struct mmc_data data;
-};
-
-static struct mmc_test_req *mmc_test_req_alloc(void)
-{
-	struct mmc_test_req *rq = kzalloc(sizeof(*rq), GFP_KERNEL);
-
-	if (rq) {
-		rq->mrq.cmd = &rq->cmd;
-		rq->mrq.data = &rq->data;
-		rq->mrq.stop = &rq->stop;
-	}
-
-	return rq;
-}
-
 static int mmc_test_send_status(struct mmc_test_card *test,
 				struct mmc_command *cmd)
 {
-- 
2.9.0
