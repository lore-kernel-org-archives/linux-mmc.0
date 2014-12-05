From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/13] mmc: core: Add support for re-tuning before each request
Date: Fri,  5 Dec 2014 19:41:03 +0200
Message-ID: <1417801271-15575-6-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60356 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaLERnT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:19 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

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

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 884f35a..263b2d6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -191,9 +191,15 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
+	int err;
+
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
+	err = mmc_retune_and_hold(host);
+	if (err)
+		return err;
+
 	if (mrq->sbc) {
 		pr_debug("<%s: starting CMD%u arg %08x flags %08x>\n",
 			 mmc_hostname(host), mrq->sbc->opcode,
@@ -428,10 +434,12 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 			context_info->is_new_req = false;
 			if (!next_req) {
 				err = MMC_BLK_NEW_REQUEST;
+				mmc_retune_hold(host);
 				break; /* return err */
 			}
 		}
 	}
+	mmc_retune_release(host);
 	return err;
 }
 
@@ -472,6 +480,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		cmd->error = 0;
 		host->ops->request(host, mrq);
 	}
+
+	mmc_retune_release(host);
 }
 
 /**
-- 
1.9.1

