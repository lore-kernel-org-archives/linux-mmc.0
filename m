From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V9 04/11] mmc: core: Do not prepare a new request twice
Date: Thu,  8 Dec 2016 10:44:31 +0200
Message-ID: <1481186678-6307-5-git-send-email-adrian.hunter@intel.com>
References: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:38669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbcLHIuA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 03:50:00 -0500
In-Reply-To: <1481186678-6307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

mmc_start_req() assumes it is never called with the new request already
prepared. That is true if the queue consists of only 2 requests, but is not
true for a longer queue. e.g. mmc_start_req() has a current and previous
request but still exits to queue a new request if the queue size is
greater than 2. In that case, when mmc_start_req() is called again, the
current request will have been prepared already. Fix by flagging if the
request has been prepared.

That also means ensuring that struct mmc_async_req is always initialized
to zero, which wasn't the case in mmc_test.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
---
 drivers/mmc/card/mmc_test.c |  8 ++++----
 drivers/mmc/core/core.c     | 12 +++++++++---
 include/linux/mmc/host.h    |  1 +
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index ec1d1c46eb90..6c449e9be7e6 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -830,7 +830,10 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	struct mmc_command stop2;
 	struct mmc_data data2;
 
-	struct mmc_test_async_req test_areq[2];
+	struct mmc_test_async_req test_areq[2] = {
+		{ .test = test },
+		{ .test = test },
+	};
 	struct mmc_async_req *done_areq;
 	struct mmc_async_req *cur_areq = &test_areq[0].areq;
 	struct mmc_async_req *other_areq = &test_areq[1].areq;
@@ -838,9 +841,6 @@ static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
 	int i;
 	int ret = RESULT_OK;
 
-	test_areq[0].test = test;
-	test_areq[1].test = test;
-
 	mmc_test_nonblock_reset(&mrq1, &cmd1, &stop1, &data1);
 	mmc_test_nonblock_reset(&mrq2, &cmd2, &stop2, &data2);
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 543eadd230e5..d00588a6ea5d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -656,8 +656,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	struct mmc_async_req *data = host->areq;
 
 	/* Prepare a new request */
-	if (areq)
+	if (areq && !areq->pre_req_done) {
+		areq->pre_req_done = true;
 		mmc_pre_req(host, areq->mrq);
+	}
 
 	if (host->areq) {
 		status = mmc_wait_for_data_req_done(host, host->areq->mrq, areq);
@@ -693,12 +695,16 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	if (status == MMC_BLK_SUCCESS && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
-	if (host->areq)
+	if (host->areq) {
+		host->areq->pre_req_done = false;
 		mmc_post_req(host, host->areq->mrq, 0);
+	}
 
 	 /* Cancel a prepared request if it was not started. */
-	if ((status != MMC_BLK_SUCCESS || start_err) && areq)
+	if ((status != MMC_BLK_SUCCESS || start_err) && areq) {
+		areq->pre_req_done = false;
 		mmc_post_req(host, areq->mrq, -EINVAL);
+	}
 
 	if (status != MMC_BLK_SUCCESS)
 		host->areq = NULL;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8bc884121465..69f796d21c76 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -173,6 +173,7 @@ struct mmc_async_req {
 	 * Returns 0 if success otherwise non zero.
 	 */
 	enum mmc_blk_status (*err_check)(struct mmc_card *, struct mmc_async_req *);
+	bool pre_req_done;
 };
 
 /**
-- 
1.9.1

