From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/15] mmc: block: Use mmc_get_ext_csd() instead of mmc_send_ext_csd()
Date: Tue, 21 Oct 2014 19:19:09 +0200
Message-ID: <1413911953-19012-12-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50600 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933163AbaJURTm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:42 -0400
Received: by mail-lb0-f171.google.com with SMTP id z12so1432517lbi.30
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:38 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

By using mmc_get_ext_csd() in favor of mmc_send_ext_csd, we decrease
code duplication.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1fa4c80..1795285 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1308,19 +1308,11 @@ static int mmc_blk_packed_err_check(struct mmc_card *card,
 	}
 
 	if (status & R1_EXCEPTION_EVENT) {
-		ext_csd = kzalloc(512, GFP_KERNEL);
-		if (!ext_csd) {
-			pr_err("%s: unable to allocate buffer for ext_csd\n",
-			       req->rq_disk->disk_name);
-			return -ENOMEM;
-		}
-
-		err = mmc_send_ext_csd(card, ext_csd);
+		err = mmc_get_ext_csd(card, &ext_csd);
 		if (err) {
 			pr_err("%s: error %d sending ext_csd\n",
 			       req->rq_disk->disk_name, err);
-			check = MMC_BLK_ABORT;
-			goto free;
+			return MMC_BLK_ABORT;
 		}
 
 		if ((ext_csd[EXT_CSD_EXP_EVENTS_STATUS] &
@@ -1338,7 +1330,6 @@ static int mmc_blk_packed_err_check(struct mmc_card *card,
 			       req->rq_disk->disk_name, packed->nr_entries,
 			       packed->blocks, packed->idx_failure);
 		}
-free:
 		kfree(ext_csd);
 	}
 
-- 
1.9.1

