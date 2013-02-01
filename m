From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: core: fixing for the wrong indent
Date: Fri, 01 Feb 2013 14:32:22 +0900
Message-ID: <510B5366.60909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24223 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab3BAFcx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Feb 2013 00:32:53 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHJ00C6U0QM9UM0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 01 Feb 2013 14:32:51 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MHJ001540QQG450@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 01 Feb 2013 14:32:51 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>

This patch is fixed the wrong indent.
(Just code cleanup)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/core.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 39f28af..bc847d5 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -515,17 +515,16 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		mmc_pre_req(host, areq->mrq, !host->areq);
 
 	if (host->areq) {
-			err = mmc_wait_for_data_req_done(host, host->areq->mrq,
-					areq);
-			if (err == MMC_BLK_NEW_REQUEST) {
-				if (error)
-					*error = err;
-				/*
-				 * The previous request was not completed,
-				 * nothing to return
-				 */
-				return NULL;
-			}
+		err = mmc_wait_for_data_req_done(host, host->areq->mrq,	areq);
+		if (err == MMC_BLK_NEW_REQUEST) {
+			if (error)
+				*error = err;
+			/*
+			 * The previous request was not completed,
+			 * nothing to return
+			 */
+			return NULL;
+		}
 		/*
 		 * Check BKOPS urgency for each R1 response
 		 */
@@ -544,7 +543,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 
 	 /* Cancel a prepared request if it was not started. */
 	if ((err || start_err) && areq)
-			mmc_post_req(host, areq->mrq, -EINVAL);
+		mmc_post_req(host, areq->mrq, -EINVAL);
 
 	if (err)
 		host->areq = NULL;
-- 
1.7.5.4
