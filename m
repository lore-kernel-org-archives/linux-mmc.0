From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH 3/4] mmc: core: make hw_reset generic
Date: Fri, 24 Oct 2014 14:46:29 +0200
Message-ID: <1414154790-20893-4-git-send-email-johanru@axis.com>
References: <1414154790-20893-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:49513 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756460AbaJXMrL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Oct 2014 08:47:11 -0400
In-Reply-To: <1414154790-20893-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Move the (e)MMC specific hw_reset code from core.c into mmc.c and call
it from the new bus_ops member power_reset. This also lets us add code
for reseting SD cards as well.

Rename the mmc_hw_reset* functions into mmc_reset*, since what they
now actually do depends on the device type (and it may be something else
than doing a hw_reset).

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/card/block.c    |    2 +-
 drivers/mmc/card/mmc_test.c |    5 +---
 drivers/mmc/core/core.c     |   58 +++++++++---------------------------------
 drivers/mmc/core/core.h     |    4 +++
 drivers/mmc/core/mmc.c      |   40 +++++++++++++++++++++++++++++
 include/linux/mmc/core.h    |    5 +--
 6 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 452782b..8c4fa46 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1001,7 +1001,7 @@ static int mmc_blk_reset(struct mmc_blk_data *md, struct mmc_host *host,
 		return -EEXIST;
 
 	md->reset_done |= type;
-	err = mmc_hw_reset(host);
+	err = mmc_reset(host);
 	/* Ensure we switch back to the correct partition */
 	if (err != -EOPNOTSUPP) {
 		struct mmc_blk_data *main_md = mmc_get_drvdata(host->card);
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0c0fc52..599c683 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2339,7 +2339,7 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
 	struct mmc_host *host = card->host;
 	int err;
 
-	err = mmc_hw_reset_check(host);
+	err = mmc_reset_check(host);
 	if (!err)
 		return RESULT_OK;
 
@@ -2349,9 +2349,6 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
 	if (err != -EOPNOTSUPP)
 		return err;
 
-	if (!mmc_can_reset(card))
-		return RESULT_UNSUP_CARD;
-
 	return RESULT_UNSUP_HOST;
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d56e222..486cda8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2232,65 +2232,33 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 	mmc_host_clk_release(host);
 }
 
-int mmc_can_reset(struct mmc_card *card)
+/* Reset card in a bus-specific way */
+static int mmc_do_reset(struct mmc_host *host, int check)
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
-static int mmc_do_hw_reset(struct mmc_host *host, int check)
-{
-	struct mmc_card *card = host->card;
-
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
-		return -EOPNOTSUPP;
-
-	if (!card)
-		return -EINVAL;
+	int ret;
 
-	if (!mmc_can_reset(card))
+	if (!host->bus_ops || !host->bus_ops->power_reset ||
+			host->bus_ops->power_reset(host, MMC_POWER_RESET_TEST))
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
-	mmc_power_up(host, card->ocr);
+	ret = host->bus_ops->power_reset(host, check);
 
-	mmc_host_clk_release(host);
+	pr_warning("%s: tried to reset card (%d)\n", mmc_hostname(host), ret);
 
 	return host->bus_ops->power_restore(host);
 }
 
-int mmc_hw_reset(struct mmc_host *host)
+int mmc_reset(struct mmc_host *host)
 {
-	return mmc_do_hw_reset(host, 0);
+	return mmc_do_reset(host, MMC_POWER_RESET_RESET);
 }
-EXPORT_SYMBOL(mmc_hw_reset);
+EXPORT_SYMBOL(mmc_reset);
 
-int mmc_hw_reset_check(struct mmc_host *host)
+int mmc_reset_check(struct mmc_host *host)
 {
-	return mmc_do_hw_reset(host, 1);
+	return mmc_do_reset(host, MMC_POWER_RESET_CHECK);
 }
-EXPORT_SYMBOL(mmc_hw_reset_check);
+EXPORT_SYMBOL(mmc_reset_check);
 
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 443a584..6a0420b 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -25,6 +25,10 @@ struct mmc_bus_ops {
 	int (*runtime_resume)(struct mmc_host *);
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
+	int (*power_reset)(struct mmc_host *, int);
+#define MMC_POWER_RESET_RESET	0
+#define MMC_POWER_RESET_TEST	1
+#define MMC_POWER_RESET_CHECK	2
 	int (*alive)(struct mmc_host *);
 	int (*shutdown)(struct mmc_host *);
 };
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..ac5192c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1762,6 +1762,45 @@ static int mmc_runtime_resume(struct mmc_host *host)
 	return 0;
 }
 
+static int mmc_power_reset(struct mmc_host *host, int test)
+{
+	struct mmc_card *card = host->card;
+	u8 rst_n_function;
+
+	if (!card)
+		return -EINVAL;
+
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+		return -EOPNOTSUPP;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
+		return -EOPNOTSUPP;
+
+	if (test == MMC_POWER_RESET_TEST)
+		return 0;
+
+	mmc_host_clk_hold(host);
+	mmc_set_clock(host, host->f_init);
+
+	host->ops->hw_reset(host);
+
+	if (test == MMC_POWER_RESET_CHECK) {
+		u32 status;
+
+		if (!mmc_send_status(card, &status)) {
+			mmc_host_clk_release(host);
+			return -ENOSYS;
+		}
+	}
+
+	mmc_power_up(host, card->ocr);
+
+	mmc_host_clk_release(host);
+
+	return 0;
+}
+
 static int mmc_power_restore(struct mmc_host *host)
 {
 	int ret;
@@ -1781,6 +1820,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.runtime_suspend = mmc_runtime_suspend,
 	.runtime_resume = mmc_runtime_resume,
 	.power_restore = mmc_power_restore,
+	.power_reset = mmc_power_reset,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
 };
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f206e29..4f7a76e 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -180,9 +180,8 @@ extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			      bool is_rel_write);
-extern int mmc_hw_reset(struct mmc_host *host);
-extern int mmc_hw_reset_check(struct mmc_host *host);
-extern int mmc_can_reset(struct mmc_card *card);
+extern int mmc_reset(struct mmc_host *host);
+extern int mmc_reset_check(struct mmc_host *host);
 
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
 extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
-- 
1.7.2.5

