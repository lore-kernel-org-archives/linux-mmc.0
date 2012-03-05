From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2] mmc: core: Clean up after mmc_pre_req if card was removed
Date: Mon, 5 Mar 2012 15:52:43 +0100
Message-ID: <1330959163-21796-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog103.obsmtp.com ([207.126.144.115]:38944 "EHLO
	eu1sys200aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932078Ab2CEOxE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 09:53:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Make sure mmc_start_req cancel the prepared job, if the request
was prevented to be started due to the card has been removed.

This bug was introduced in commit:
mmc: allow upper layers to know immediately if card has been removed

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Per Forlin <per.forlin@stericsson.com>
---

Changes in v2:
	- Maintain handling of host->areq (host->areq must not be NULL when
	"start_err"), to make sure the block layer is able to respond to all
	of the started requests.

---
 drivers/mmc/core/core.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index faa0af1..56b7a24 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -249,16 +249,17 @@ static void mmc_wait_done(struct mmc_request *mrq)
 	complete(&mrq->completion);
 }
 
-static void __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
+static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
 	init_completion(&mrq->completion);
 	mrq->done = mmc_wait_done;
 	if (mmc_card_removed(host->card)) {
 		mrq->cmd->error = -ENOMEDIUM;
 		complete(&mrq->completion);
-		return;
+		return -ENOMEDIUM;
 	}
 	mmc_start_request(host, mrq);
+	return 0;
 }
 
 static void mmc_wait_for_req_done(struct mmc_host *host,
@@ -342,6 +343,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 				    struct mmc_async_req *areq, int *error)
 {
 	int err = 0;
+	int start_err = 0;
 	struct mmc_async_req *data = host->areq;
 
 	/* Prepare a new request */
@@ -351,30 +353,23 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 	if (host->areq) {
 		mmc_wait_for_req_done(host, host->areq->mrq);
 		err = host->areq->err_check(host->card, host->areq);
-		if (err) {
-			/* post process the completed failed request */
-			mmc_post_req(host, host->areq->mrq, 0);
-			if (areq)
-				/*
-				 * Cancel the new prepared request, because
-				 * it can't run until the failed
-				 * request has been properly handled.
-				 */
-				mmc_post_req(host, areq->mrq, -EINVAL);
-
-			host->areq = NULL;
-			goto out;
-		}
 	}
 
-	if (areq)
-		__mmc_start_req(host, areq->mrq);
+	if (!err && areq)
+		start_err = __mmc_start_req(host, areq->mrq);
 
 	if (host->areq)
 		mmc_post_req(host, host->areq->mrq, 0);
 
-	host->areq = areq;
- out:
+	 /* Cancel a prepared request if it was not started. */
+	if ((err || start_err) && areq)
+			mmc_post_req(host, areq->mrq, -EINVAL);
+
+	if (err)
+		host->areq = NULL;
+	else
+		host->areq = areq;
+
 	if (error)
 		*error = err;
 	return data;
-- 
1.7.9

