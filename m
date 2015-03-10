From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 03/15] mmc: core: Add support for re-tuning before each request
Date: Tue, 10 Mar 2015 14:42:58 +0200
Message-ID: <1425991390-4983-4-git-send-email-adrian.hunter@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012AbbCJMpR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:17 -0400
In-Reply-To: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
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
 drivers/mmc/core/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaca0e1..12bddc9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -192,6 +192,8 @@ static int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	unsigned int i, sz;
 	struct scatterlist *sg;
 #endif
+	mmc_retune_hold(host);
+
 	if (mmc_card_removed(host->card))
 		return -ENOMEDIUM;
 
@@ -427,12 +429,11 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
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
 
@@ -473,6 +474,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		cmd->error = 0;
 		host->ops->request(host, mrq);
 	}
+
+	mmc_retune_release(host);
 }
 
 /**
-- 
1.9.1

