From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH 1/7] mmc: core: rename "data" to saved_areq
Date: Thu, 26 Sep 2013 12:22:54 -0700
Message-ID: <1380223380-22451-2-git-send-email-grundler@chromium.org>
References: <1380223380-22451-1-git-send-email-grundler@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380223380-22451-1-git-send-email-grundler@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Replace "data" with a more descriptive name.

Using a local variable (ie a register) makes explicit what the
compiler is doing under the covers anyway: the function is
dereferencing one pointer value the whole time.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 drivers/mmc/core/core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 006ead2..e5a40ee 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -529,14 +529,14 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 {
 	int err = 0;
 	int start_err = 0;
-	struct mmc_async_req *data = host->areq;
+	struct mmc_async_req *saved_areq = host->areq;
 
 	/* Prepare a new request */
 	if (areq)
-		mmc_pre_req(host, areq->mrq, !host->areq);
+		mmc_pre_req(host, areq->mrq, !saved_areq);
 
-	if (host->areq) {
-		err = mmc_wait_for_data_req_done(host, host->areq->mrq,	areq);
+	if (saved_areq) {
+		err = mmc_wait_for_data_req_done(host, saved_areq->mrq,	areq);
 		if (err == MMC_BLK_NEW_REQUEST) {
 			if (error)
 				*error = err;
@@ -550,17 +550,17 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		 * Check BKOPS urgency for each R1 response
 		 */
 		if (host->card && mmc_card_mmc(host->card) &&
-		    ((mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1) ||
-		     (mmc_resp_type(host->areq->mrq->cmd) == MMC_RSP_R1B)) &&
-		    (host->areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT))
+		    ((mmc_resp_type(saved_areq->mrq->cmd) == MMC_RSP_R1) ||
+		     (mmc_resp_type(saved_areq->mrq->cmd) == MMC_RSP_R1B)) &&
+		    (saved_areq->mrq->cmd->resp[0] & R1_EXCEPTION_EVENT))
 			mmc_start_bkops(host->card, true);
 	}
 
 	if (!err && areq)
 		start_err = __mmc_start_data_req(host, areq->mrq);
 
-	if (host->areq)
-		mmc_post_req(host, host->areq->mrq, 0);
+	if (saved_areq)
+		mmc_post_req(host, saved_areq->mrq, 0);
 
 	 /* Cancel a prepared request if it was not started. */
 	if ((err || start_err) && areq)
@@ -573,7 +573,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 	if (error)
 		*error = err;
-	return data;
+	return saved_areq;
 }
 EXPORT_SYMBOL(mmc_start_req);
 
-- 
1.8.4
