From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V5 13/25] mmc: core: Do not prepare a new request twice
Date: Mon, 24 Oct 2016 11:37:28 +0300
Message-ID: <1477298260-5064-14-git-send-email-adrian.hunter@intel.com>
References: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33721 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935974AbcJXIn1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 04:43:27 -0400
In-Reply-To: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

mmc_start_req() assumes it is never called with the new request already
prepared. That is true if the queue consists of only 2 requests, but is not
true for a longer queue. e.g. mmc_start_req() has a current and previous
request but still exits to queue a new request if the queue size is
greater than 2. In that case, when mmc_start_req() is called again, the
current request will have been prepared already. Fix by flagging if the
request has been prepared.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c  | 12 +++++++++---
 include/linux/mmc/host.h |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 36b727feecac..8f1b42177777 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -660,8 +660,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	struct mmc_async_req *data = host->areq;
 
 	/* Prepare a new request */
-	if (areq)
+	if (areq && !areq->pre_req_done) {
+		areq->pre_req_done = true;
 		mmc_pre_req(host, areq->mrq, !host->areq);
+	}
 
 	if (host->areq) {
 		err = mmc_wait_for_data_req_done(host, host->areq->mrq,	areq);
@@ -697,12 +699,16 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	if (!err && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
-	if (host->areq)
+	if (host->areq) {
+		host->areq->pre_req_done = false;
 		mmc_post_req(host, host->areq->mrq, 0);
+	}
 
 	 /* Cancel a prepared request if it was not started. */
-	if ((err || start_err) && areq)
+	if ((err || start_err) && areq) {
+		areq->pre_req_done = false;
 		mmc_post_req(host, areq->mrq, -EINVAL);
+	}
 
 	if (err)
 		host->areq = NULL;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 3386e10480f7..9fb00b7c54a1 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -174,6 +174,7 @@ struct mmc_async_req {
 	 * Returns 0 if success otherwise non zero.
 	 */
 	int (*err_check) (struct mmc_card *, struct mmc_async_req *);
+	bool pre_req_done;
 };
 
 /**
-- 
1.9.1

