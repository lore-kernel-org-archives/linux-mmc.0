From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V6 13/15] mmc: block: Check re-tuning in the recovery path
Date: Mon, 20 Apr 2015 15:09:54 +0300
Message-ID: <1429531796-21987-14-git-send-email-adrian.hunter@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27511 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754989AbbDTMM4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Apr 2015 08:12:56 -0400
In-Reply-To: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

If re-tuning is needed, do it in the recovery path to
give recovery commands a better chance of success.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/card/block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 2c25271..325ae1e 100644
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

