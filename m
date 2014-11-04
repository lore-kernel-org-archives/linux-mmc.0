From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v2 3/4] mmc: core: turn hw_reset into a bus_ops
Date: Tue,  4 Nov 2014 16:07:05 +0100
Message-ID: <1415113626-30187-4-git-send-email-johanru@axis.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49603 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663AbaKDPH0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Nov 2014 10:07:26 -0500
In-Reply-To: <1415113626-30187-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Move the (e)MMC specific hw_reset code from core.c into mmc.c and call
it from the new bus_ops member hw_reset. This also lets us add code
for reseting SD cards as well.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/card/mmc_test.c |    3 --
 drivers/mmc/core/core.c     |   48 ++++++++----------------------------------
 drivers/mmc/core/core.h     |    4 +++
 drivers/mmc/core/mmc.c      |   37 +++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h    |    1 -
 5 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0c0fc52..2cd3385 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2349,9 +2349,6 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
 	if (err != -EOPNOTSUPP)
 		return err;
 
-	if (!mmc_can_reset(card))
-		return RESULT_UNSUP_CARD;
-
 	return RESULT_UNSUP_HOST;
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2c39d26..b35f205 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2239,64 +2239,34 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 	mmc_host_clk_release(host);
 }
 
-int mmc_can_reset(struct mmc_card *card)
-{
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
+/* Reset card in a bus-specific way */
 static int mmc_do_hw_reset(struct mmc_host *host, int check)
 {
-	struct mmc_card *card = host->card;
-
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
-		return -EOPNOTSUPP;
+	int ret;
 
-	if (!card)
+	if (!host->card)
 		return -EINVAL;
 
-	if (!mmc_can_reset(card))
+	if (!host->bus_ops || !host->bus_ops->hw_reset ||
+			host->bus_ops->hw_reset(host, MMC_HW_RESET_TEST))
 		return -EOPNOTSUPP;
 
-	mmc_host_clk_hold(host);
-	mmc_set_clock(host, host->f_init);
-
-	host->ops->hw_reset(host);
-
-	/* If the reset has happened, then a status command will fail */
-	if (check) {
-		u32 status;
-
-		if (!mmc_send_status(card, &status)) {
-			mmc_host_clk_release(host);
-			return -ENOSYS;
-		}
-	}
-
-	/* Set initial state and call mmc_set_ios */
-	mmc_set_initial_state(host);
+	ret = host->bus_ops->hw_reset(host, check);
 
-	mmc_host_clk_release(host);
+	pr_warn("%s: tried to reset card (%d)\n", mmc_hostname(host), ret);
 
 	return host->bus_ops->power_restore(host);
 }
 
 int mmc_hw_reset(struct mmc_host *host)
 {
-	return mmc_do_hw_reset(host, 0);
+	return mmc_do_hw_reset(host, MMC_HW_RESET_RESET);
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
 int mmc_hw_reset_check(struct mmc_host *host)
 {
-	return mmc_do_hw_reset(host, 1);
+	return mmc_do_hw_reset(host, MMC_HW_RESET_CHECK);
 }
 EXPORT_SYMBOL(mmc_hw_reset_check);
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index d76597c..918bbe8 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -27,6 +27,10 @@ struct mmc_bus_ops {
 	int (*power_restore)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
 	int (*shutdown)(struct mmc_host *);
+	int (*hw_reset)(struct mmc_host *, int);
+#define MMC_HW_RESET_RESET	0
+#define MMC_HW_RESET_TEST	1
+#define MMC_HW_RESET_CHECK	2
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..55e1a97 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1773,6 +1773,42 @@ static int mmc_power_restore(struct mmc_host *host)
 	return ret;
 }
 
+static int mmc_mmc_hw_reset(struct mmc_host *host, int test)
+{
+	struct mmc_card *card = host->card;
+	u8 rst_n_function;
+
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+		return -EOPNOTSUPP;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
+		return -EOPNOTSUPP;
+
+	if (test == MMC_HW_RESET_TEST)
+		return 0;
+
+	mmc_host_clk_hold(host);
+	mmc_set_clock(host, host->f_init);
+
+	host->ops->hw_reset(host);
+
+	if (test == MMC_HW_RESET_CHECK) {
+		u32 status;
+
+		if (!mmc_send_status(card, &status)) {
+			mmc_host_clk_release(host);
+			return -ENOSYS;
+		}
+	}
+
+	mmc_set_initial_state(host);
+
+	mmc_host_clk_release(host);
+
+	return 0;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
@@ -1783,6 +1819,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
+	.hw_reset = mmc_mmc_hw_reset,
 };
 
 /*
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f206e29..d7e02a7 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -182,7 +182,6 @@ extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			      bool is_rel_write);
 extern int mmc_hw_reset(struct mmc_host *host);
 extern int mmc_hw_reset_check(struct mmc_host *host);
-extern int mmc_can_reset(struct mmc_card *card);
 
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
 extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
-- 
1.7.2.5

