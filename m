From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH 2/7] mmc: core: rename local var err to saved_err
Date: Thu, 26 Sep 2013 12:22:55 -0700
Message-ID: <1380223380-22451-3-git-send-email-grundler@chromium.org>
References: <1380223380-22451-1-git-send-email-grundler@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380223380-22451-1-git-send-email-grundler@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Just making it more obvious 'err' refers to the status of the in flight
request (aka saved_areq) and not the new async request we might start.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/mmc/core/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e5a40ee..675139e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -527,7 +527,7 @@ static void mmc_post_req(struct mmc_host *host, struct mmc_request *mrq,
 struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 				    struct mmc_async_req *areq, int *error)
 {
-	int err = 0;
+	int saved_err = 0;
 	int start_err = 0;
 	struct mmc_async_req *saved_areq = host->areq;
 
@@ -536,10 +536,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		mmc_pre_req(host, areq->mrq, !saved_areq);
 
 	if (saved_areq) {
-		err = mmc_wait_for_data_req_done(host, saved_areq->mrq,	areq);
-		if (err == MMC_BLK_NEW_REQUEST) {
+		saved_err = mmc_wait_for_data_req_done(host, saved_areq->mrq,	areq);
+		if (saved_err == MMC_BLK_NEW_REQUEST) {
 			if (error)
-				*error = err;
+				*error = saved_err;
 			/*
 			 * The previous request was not completed,
 			 * nothing to return
@@ -556,23 +556,23 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 			mmc_start_bkops(host->card, true);
 	}
 
-	if (!err && areq)
+	if (!saved_err && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
 	if (saved_areq)
 		mmc_post_req(host, saved_areq->mrq, 0);
 
 	 /* Cancel a prepared request if it was not started. */
-	if ((err || start_err) && areq)
+	if ((saved_err || start_err) && areq)
 		mmc_post_req(host, areq->mrq, -EINVAL);
 
-	if (err)
+	if (saved_err)
 		host->areq = NULL;
 	else
 		host->areq = areq;
 
 	if (error)
-		*error = err;
+		*error = saved_err;
 	return saved_areq;
 }
 EXPORT_SYMBOL(mmc_start_req);
-- 
1.8.4
