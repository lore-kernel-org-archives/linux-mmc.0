From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: mmc_test: Fix "Commands during non-blocking write" tests
Date: Fri,  4 Nov 2016 13:41:05 +0200
Message-ID: <1478259665-13406-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:22448 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754514AbcKDLqJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Nov 2016 07:46:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

mmc_test_check_result_async() requires that struct mmc_async_req is
contained within struct mmc_test_async_req. Fix the "Commands during
non-blocking write" tests so that is the case.

Fixes: 4bbb9aac9a9a ("mmc: mmc_test: Add tests for sending commands during transfer")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/mmc_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5a8dc5a76e0d..3678220964fe 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2347,7 +2347,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 	struct mmc_test_req *rq = mmc_test_req_alloc();
 	struct mmc_host *host = test->card->host;
 	struct mmc_test_area *t = &test->area;
-	struct mmc_async_req areq;
+	struct mmc_test_async_req test_areq = { .test = test };
 	struct mmc_request *mrq;
 	unsigned long timeout;
 	bool expired = false;
@@ -2363,8 +2363,8 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 		mrq->sbc = &rq->sbc;
 	mrq->cap_cmd_during_tfr = true;
 
-	areq.mrq = mrq;
-	areq.err_check = mmc_test_check_result_async;
+	test_areq.areq.mrq = mrq;
+	test_areq.areq.err_check = mmc_test_check_result_async;
 
 	mmc_test_prepare_mrq(test, mrq, t->sg, t->sg_len, dev_addr, t->blocks,
 			     512, write);
@@ -2378,7 +2378,7 @@ static int mmc_test_ongoing_transfer(struct mmc_test_card *test,
 
 	/* Start ongoing data request */
 	if (use_areq) {
-		mmc_start_req(host, &areq, &ret);
+		mmc_start_req(host, &test_areq.areq, &ret);
 		if (ret)
 			goto out_free;
 	} else {
-- 
1.9.1

