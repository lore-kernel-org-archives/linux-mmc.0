From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 04/15] mmc: core: Check re-tuning before retrying
Date: Tue, 10 Mar 2015 14:42:59 +0200
Message-ID: <1425991390-4983-5-git-send-email-adrian.hunter@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbbCJMpU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:20 -0400
In-Reply-To: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

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
index 12bddc9..01b9edf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -419,6 +419,7 @@ static int mmc_wait_for_data_req_done(struct mmc_host *host,
 							    host->areq);
 				break; /* return err */
 			} else {
+				mmc_retune_recheck(host);
 				pr_info("%s: req failed (CMD%u): %d, retrying...\n",
 					mmc_hostname(host),
 					cmd->opcode, cmd->error);
@@ -468,6 +469,8 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
 		    mmc_card_removed(host->card))
 			break;
 
+		mmc_retune_recheck(host);
+
 		pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
 			 mmc_hostname(host), cmd->opcode, cmd->error);
 		cmd->retries--;
-- 
1.9.1

