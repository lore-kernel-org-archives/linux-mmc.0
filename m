From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V7 03/14] mmc: core: Add support for re-tuning before each request
Date: Thu,  7 May 2015 13:10:14 +0300
Message-ID: <1430993425-2777-4-git-send-email-adrian.hunter@intel.com>
References: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29829 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242AbbEGKMq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 May 2015 06:12:46 -0400
In-Reply-To: <1430993425-2777-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

At the start of each request, re-tune if needed and
then hold off re-tuning again until the request is done.

Note that though there is one function that starts
requests (mmc_start_request) there are two that wait for
the request to be done (mmc_wait_for_req_done and
mmc_wait_for_data_req_done).  Also note that
mmc_wait_for_data_req_done can return even when the
request is not done (which allows the block driver
to prepare a newly arrived request while still
waiting for the previous request).

This patch ensures re-tuning is held for the duration
of a request.  Subsequent patches will also hold
re-tuning at other times when it might cause a
conflict.

In addition, possibly a command is failing because
re-tuning is needed. Use mmc_retune_recheck() to check
re-tuning. At that point re-tuning is held, at least by
the request, so mmc_retune_recheck() flags host->retune_now
if the hold count is 1.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 007c444..ec3453f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -186,12 +186,29 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
 
 EXPORT_SYMBOL(mmc_request_done);
 
+static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
+{
+	int err;
+
+	/* Assumes host controller has been runtime resumed by mmc_claim_host */
+	err = mmc_retune(host);
+	if (err) {
+		mrq->cmd->error = err;
+		mmc_request_done(host, mrq);
+		return;
+	}
+
+	host->ops->request(host, mrq);
+}
+
 static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
 #ifdef CONFIG_MMC_DEBUG
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
+	mmc_retune_hold(host);
+
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
@@ -252,7 +269,7 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	}
 	mmc_host_clk_hold(host);
 	led_trigger_event(host->led, LED_FULL);
-	host->ops->request(host, mrq);
+	__mmc_start_request(host, mrq);
 
 	return 0;
 }
@@ -417,22 +434,22 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 							    host->areq);
 				break; /* return err */
 			} else {
+				mmc_retune_recheck(host);
 				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
 					mmc_hostname(host),
 					cmd->opcode, cmd->error);
 				cmd->retries--;
 				cmd->error = 0;
-				host->ops->request(host, mrq);
+				__mmc_start_request(host, mrq);
 				continue; /* wait for done/new event again */
 			}
 		} else if (context_info->is_new_req) {
 			context_info->is_new_req = false;
-			if (!next_req) {
-				err = MMC_BLK_NEW_REQUEST;
-				break; /* return err */
-			}
+			if (!next_req)
+				return MMC_BLK_NEW_REQUEST;
 		}
 	}
+	mmc_retune_release(host);
 	return err;
 }
 
@@ -467,12 +484,16 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		    mmc_card_removed(host->card))
 			break;
 
+		mmc_retune_recheck(host);
+
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
 		cmd->error = 0;
-		host->ops->request(host, mrq);
+		__mmc_start_request(host, mrq);
 	}
+
+	mmc_retune_release(host);
 }
 
 /**
-- 
1.9.1

