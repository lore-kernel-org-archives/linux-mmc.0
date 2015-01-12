From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v7 2/3] mmc: core: refactor the hw_reset routines
Date: Mon, 12 Jan 2015 15:38:05 +0100
Message-ID: <1421073486-10903-3-git-send-email-johanru@axis.com>
References: <1421073486-10903-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:59394 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbbALOiT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Jan 2015 09:38:19 -0500
In-Reply-To: <1421073486-10903-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Move the (e)MMC specific hw_reset code from core.c into mmc.c. Call the
code from the new bus_ops member "reset". This also allows for adding
a SD card specific reset procedure.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/core/core.c |   45 ++++++++++-----------------------------------
 drivers/mmc/core/core.h |    1 +
 drivers/mmc/core/mmc.c  |   41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9959997e..2cdb06e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2273,50 +2273,25 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 	mmc_host_clk_release(host);
 }
 
-int mmc_can_reset(struct mmc_card *card)
+int mmc_hw_reset(struct mmc_host *host)
 {
-	u8 rst_n_function;
-
-	if (!mmc_card_mmc(card))
-		return 0;
-	rst_n_function = card->ext_csd.rst_n_function;
-	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
-		return 0;
-	return 1;
-}
-EXPORT_SYMBOL(mmc_can_reset);
-
-static int mmc_hw_reset(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-	u32 status;
-
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
-		return -EOPNOTSUPP;
+	int ret;
 
-	if (!card)
+	if (!host->card)
 		return -EINVAL;
 
-	if (!mmc_can_reset(card))
+	mmc_bus_get(host);
+	if (!host->bus_ops || host->bus_dead || !host->bus_ops->reset) {
+		mmc_bus_put(host);
 		return -EOPNOTSUPP;
-
-	mmc_host_clk_hold(host);
-	mmc_set_clock(host, host->f_init);
-
-	host->ops->hw_reset(host);
-
-	/* If the reset has happened, then a status command will fail */
-	if (!mmc_send_status(card, &status)) {
-		mmc_host_clk_release(host);
-		return -ENOSYS;
 	}
 
-	/* Set initial state and call mmc_set_ios */
-	mmc_set_initial_state(host);
+	ret = host->bus_ops->reset(host);
+	mmc_bus_put(host);
 
-	mmc_host_clk_release(host);
+	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
 
-	return host->bus_ops->power_restore(host);
+	return ret;
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index b528c0e..a0bccbc 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -27,6 +27,7 @@ struct mmc_bus_ops {
 	int (*power_restore)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
 	int (*shutdown)(struct mmc_host *);
+	int (*reset)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0b8ec87..d5d576a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1795,6 +1795,46 @@ static int mmc_power_restore(struct mmc_host *host)
 	return ret;
 }
 
+int mmc_can_reset(struct mmc_card *card)
+{
+	u8 rst_n_function;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
+		return 0;
+	return 1;
+}
+EXPORT_SYMBOL(mmc_can_reset);
+
+static int mmc_reset(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	u32 status;
+
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+		return -EOPNOTSUPP;
+
+	if (!mmc_can_reset(card))
+		return -EOPNOTSUPP;
+
+	mmc_host_clk_hold(host);
+	mmc_set_clock(host, host->f_init);
+
+	host->ops->hw_reset(host);
+
+	/* If the reset has happened, then a status command will fail */
+	if (!mmc_send_status(card, &status)) {
+		mmc_host_clk_release(host);
+		return -ENOSYS;
+	}
+
+	/* Set initial state and call mmc_set_ios */
+	mmc_set_initial_state(host);
+	mmc_host_clk_release(host);
+
+	return mmc_power_restore(host);
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
@@ -1805,6 +1845,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
+	.reset = mmc_reset,
 };
 
 /*
-- 
1.7.2.5

