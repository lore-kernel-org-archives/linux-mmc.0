From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] mmc: core: in mmc_hw_reset(), allow power cycle.
Date: Fri,  1 Apr 2016 10:25:22 -0700
Message-ID: <1459531522-31874-1-git-send-email-gwendal@chromium.org>
References: <1459529180-32604-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34587 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbcDARZ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Apr 2016 13:25:28 -0400
Received: by mail-pf0-f173.google.com with SMTP id x3so95721709pfb.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Apr 2016 10:25:28 -0700 (PDT)
In-Reply-To: <1459529180-32604-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org

When the eMMC device does not support/allow sending RST_n signal,
do a brute force power cycle instead of returning EOPNOTSUPP.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes in v2:
- Fix indentation.
- Use card instead of host->card when available.

 drivers/mmc/core/core.c |  5 +++--
 drivers/mmc/core/mmc.c  | 18 ++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

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
index 96cc7e2..deb8c16 100644
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
 	mmc_set_clock(host, host->f_init);
-
-	host->ops->hw_reset(host);
-
+	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
+	     mmc_can_reset(card)) {
+		/* If the card accept RST_n signal, send it. */
+		host->ops->hw_reset(host);
+	} else {
+		/* Do a brute force power cycle */
+		mmc_power_cycle(host, card->ocr);
+	}
 	/* Set initial state and call mmc_set_ios */
 	mmc_set_initial_state(host);
-
 	return mmc_init_card(host, card->ocr, card);
 }
 
-- 
2.8.0.rc3.226.g39d4020

