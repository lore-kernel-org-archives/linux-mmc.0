From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 13/15] mmc: block: Check re-tuning in the recovery path
Date: Fri, 27 Mar 2015 22:57:41 +0200
Message-ID: <1427489863-9050-14-git-send-email-adrian.hunter@intel.com>
References: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:45500 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbbC0VAT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 27 Mar 2015 17:00:19 -0400
In-Reply-To: <1427489863-9050-1-git-send-email-adrian.hunter@intel.com>
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

