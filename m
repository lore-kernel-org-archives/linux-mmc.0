From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH] mmc: core: make hw_reset power cycle SD-cards
Date: Tue,  9 Sep 2014 16:21:48 +0200
Message-ID: <1410272508-4885-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:41540 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaIIO3U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Sep 2014 10:29:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Johan Rudholm <johanru@axis.com>

SD-cards cannot be reset, but they can be power cycled. Power cycling
a buggy SD-card sometimes helps it get back on track.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/core.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d03a080..9171aa9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2250,19 +2250,25 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 {
 	struct mmc_card *card = host->card;
 
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
-		return -EOPNOTSUPP;
-
 	if (!card)
 		return -EINVAL;
 
-	if (!mmc_can_reset(card))
+	if (!mmc_card_sd(card) && !((host->caps & MMC_CAP_HW_RESET) &&
+							host->ops->hw_reset))
+		return -EOPNOTSUPP;
+
+	if (!mmc_card_sd(card) && !mmc_can_reset(card))
 		return -EOPNOTSUPP;
 
 	mmc_host_clk_hold(host);
 	mmc_set_clock(host, host->f_init);
 
-	host->ops->hw_reset(host);
+	if (mmc_card_sd(card))
+		mmc_power_cycle(host, card->ocr);
+	else
+		host->ops->hw_reset(host);
+
+	pr_warning("%s: reset device\n", mmc_hostname(host));
 
 	/* If the reset has happened, then a status command will fail */
 	if (check) {
-- 
1.7.2.5

