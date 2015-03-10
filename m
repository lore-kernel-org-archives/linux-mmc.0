From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3 13/15] mmc: block: Check re-tuning in the recovery path
Date: Tue, 10 Mar 2015 14:43:08 +0200
Message-ID: <1425991390-4983-14-git-send-email-adrian.hunter@intel.com>
References: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3552 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbbCJMpr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 08:45:47 -0400
In-Reply-To: <1425991390-4983-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

If re-tuning is needed, do it in the recovery path to
give recovery commands a better chance of success.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..293e938 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -913,6 +913,9 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
 		if (!err)
 			break;
 
+		/* Re-tune if needed */
+		mmc_retune_recheck(card->host);
+
 		prev_cmd_status_valid = false;
 		pr_err("%s: error %d sending status command, %sing\n",
 		       req->rq_disk->disk_name, err, retry ? "retry" : "abort");
-- 
1.9.1

