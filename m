From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 04/15] mmc: core: Check re-tuning before retrying
Date: Fri, 27 Mar 2015 22:57:32 +0200
Message-ID: <1427489863-9050-5-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24700 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbbC0U7y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 16:59:54 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Possibly a command is failing because re-tuning is needed.
Use mmc_retune_recheck() to check re-tuning. At that point
re-tuning is held, at least by the request, so
mmc_retune_recheck() flags host->retune_now if the hold
count is 1.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bb50d82..16881c8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -434,6 +434,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 							    host->areq);
 				break; /* return err */
 			} else {
+				mmc_retune_recheck(host);
 				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
 					mmc_hostname(host),
 					cmd->opcode, cmd->error);
@@ -483,6 +484,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		    mmc_card_removed(host->card))
 			break;
 
+		mmc_retune_recheck(host);
+
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
-- 
1.9.1

