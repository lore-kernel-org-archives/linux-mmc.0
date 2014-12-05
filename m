From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/13] mmc: core: Check re-tuning before retrying
Date: Fri,  5 Dec 2014 19:41:04 +0200
Message-ID: <1417801271-15575-7-git-send-email-adrian.hunter@intel.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60356 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751806AbaLERnT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:43:19 -0500
In-Reply-To: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Possibly a command is failing because re-tuning is needed.
Use mmc_retune_retry() to check re-tuning. At that point
re-tuning is held, at least by the request, so
mmc_retune_retry() does a mmc_retune_release() and
mmc_retune_hold().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 263b2d6..2c10fb9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -422,6 +422,11 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 							    host->areq);
 				break; /* return err */
 			} else {
+				err = mmc_retune_retry(host);
+				if (err) {
+					mmc_host_clk_release(host);
+					break;
+				}
 				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
 					mmc_hostname(host),
 					cmd->opcode, cmd->error);
@@ -447,6 +452,7 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 				  struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
+	int err;
 
 	while (1) {
 		wait_for_completion(&mrq->completion);
@@ -474,6 +480,12 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		    mmc_card_removed(host->card))
 			break;
 
+		err = mmc_retune_retry(host);
+		if (err) {
+			mmc_host_clk_release(host);
+			break;
+		}
+
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
-- 
1.9.1

