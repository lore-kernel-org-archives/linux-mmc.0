From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v4] mmc: core: in mmc_hw_reset(), allow power cycle.
Date: Thu,  7 Apr 2016 11:14:17 -0700
Message-ID: <1460052857-31738-1-git-send-email-gwendal@chromium.org>
References: <CAPDyKFq0o8ii27c8Qwh73EgANOfdEc-kXNdDDsjgVk_eU4y_TA@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34013 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449AbcDGSO3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2016 14:14:29 -0400
Received: by mail-pf0-f182.google.com with SMTP id c20so60233335pfc.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2016 11:14:29 -0700 (PDT)
In-Reply-To: <CAPDyKFq0o8ii27c8Qwh73EgANOfdEc-kXNdDDsjgVk_eU4y_TA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

When the eMMC device does not support/allow sending RST_n signal,
try to do a brute force power cycle instead of returning EOPNOTSUPP.
If power cycle is not supported by the hardware, mmc_init_card still
send a CMD0, performing a Software Reset.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v4:
- Integrate Ulf's comment: update mmc_blk_reset()

 drivers/mmc/card/block.c |  4 ++--
 drivers/mmc/core/core.c  |  5 +++--
 drivers/mmc/core/mmc.c   | 24 +++++++++++-------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a4bf0f7..44e220a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1141,7 +1141,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 	md->reset_done |= type;
 	err = mmc_hw_reset(host);
 	/* Ensure we switch back to the correct partition */
-	if (err != -EOPNOTSUPP) {
+	if (!err) {
 		struct mmc_blk_data *main_md =
 			dev_get_drvdata(&host->card->dev);
 		int part_err;
@@ -1153,7 +1153,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 			 * We have failed to get back into the correct
 			 * partition, so we need to abort the whole request.
 			 */
-			return -ENODEV;
+			err = -ENODEV;
 		}
 	}
 	return err;
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d8bbc78..d5bc2d8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2468,8 +2468,9 @@ int mmc_hw_reset(struct mmc_host *host)
 	ret = host->bus_ops->reset(host);
 	mmc_bus_put(host);
 
-	if (ret != -EOPNOTSUPP)
-		pr_warn("%s: tried to reset card\n", mmc_hostname(host));
+	if (ret)
+		pr_warn("%s: tried to reset card, got error %d\n",
+			mmc_hostname(host), ret);
 
 	return ret;
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 96cc7e2..92b7bea 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1988,19 +1988,17 @@ static int mmc_reset(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
 
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
-		return -EOPNOTSUPP;
-
-	if (!mmc_can_reset(card))
-		return -EOPNOTSUPP;
-
-	mmc_set_clock(host, host->f_init);
-
-	host->ops->hw_reset(host);
-
-	/* Set initial state and call mmc_set_ios */
-	mmc_set_initial_state(host);
-
+	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
+	     mmc_can_reset(card)) {
+		/* If the card accept RST_n signal, send it. */
+		mmc_set_clock(host, host->f_init);
+		host->ops->hw_reset(host);
+		/* Set initial state and call mmc_set_ios */
+		mmc_set_initial_state(host);
+	} else {
+		/* Do a brute force power cycle */
+		mmc_power_cycle(host, card->ocr);
+	}
 	return mmc_init_card(host, card->ocr, card);
 }
 
-- 
2.8.0.rc3.226.g39d4020

