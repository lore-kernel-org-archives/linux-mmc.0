From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 10/13] mmc: block: Respect hw busy detection in card_busy_detect()
Date: Wed, 29 Jan 2014 23:38:02 +0100
Message-ID: <1391035085-2747-11-git-send-email-ulf.hansson@linaro.org>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46084 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbaA2Wic (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jan 2014 17:38:32 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so1961393lbd.15
        for <linux-mmc@vger.kernel.org>; Wed, 29 Jan 2014 14:38:31 -0800 (PST)
In-Reply-To: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Currently for write request we don't trust the hw busy detection to be
fully handled by host, thus we also poll the card's status until we see
it's gets out of the busy state.

Still there are scenarios where it will a benefit to trust the hw busy
detection done by the host, since no additional polling is needed.
Let's prepare card_busy_detect() to be able to handle this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 9568999..fec5e98 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -751,7 +751,7 @@ static int get_card_status(struct mmc_card *card, u32 *status, int retries)
 }
 
 static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
-		struct request *req, int *gen_err)
+		bool hw_busy_detect, struct request *req, int *gen_err)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	int err = 0;
@@ -771,6 +771,11 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 			*gen_err = 1;
 		}
 
+		/* We may rely on the host hw to handle busy detection.*/
+		if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
+			hw_busy_detect)
+			break;
+
 		/*
 		 * Timeout if the device never becomes ready for data and never
 		 * leaves the program state.
@@ -1210,7 +1215,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
 			gen_err = 1;
 		}
 
-		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, req, &gen_err);
+		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, false, req,
+					&gen_err);
 		if (err)
 			return MMC_BLK_CMD_ERR;
 	}
-- 
1.7.9.5

