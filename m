From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 04/15] mmc: core: Check re-tuning before retrying
Date: Thu, 29 Jan 2015 11:00:19 +0200
Message-ID: <1422522030-17793-5-git-send-email-adrian.hunter@intel.com>
References: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47353 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198AbbA2JDH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jan 2015 04:03:07 -0500
In-Reply-To: <1422522030-17793-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Possibly a command is failing because re-tuning is needed.
Use mmc_retune_recheck() to check re-tuning. At that point
re-tuning is held, at least by the request, so
mmc_retune_recheck() does a mmc_retune_release() and
mmc_retune_hold().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6dad56d..f1d663e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -429,6 +429,11 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 							    host->areq);
 				break; /* return err */
 			} else {
+				err = mmc_retune_recheck(host);
+				if (err) {
+					mmc_host_clk_release(host);
+					break;
+				}
 				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
 					mmc_hostname(host),
 					cmd->opcode, cmd->error);
@@ -451,6 +456,7 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 				  struct mmc_request *mrq)
 {
 	struct mmc_command *cmd;
+	int err;
 
 	while (1) {
 		wait_for_completion(&mrq->completion);
@@ -478,6 +484,12 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		    mmc_card_removed(host->card))
 			break;
 
+		err = mmc_retune_recheck(host);
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

