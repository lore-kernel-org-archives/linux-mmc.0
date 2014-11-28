From: Johan Rudholm <johan.rudholm@axis.com>
Subject: [PATCH v5 1/2] mmc: core: refactor the hw_reset routines
Date: Fri, 28 Nov 2014 16:56:53 +0100
Message-ID: <1417190214-32181-2-git-send-email-johanru@axis.com>
References: <1417190214-32181-1-git-send-email-johanru@axis.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:37908 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaK1P5S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 10:57:18 -0500
In-Reply-To: <1417190214-32181-1-git-send-email-johanru@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?q?David=20Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>, Johan Rudholm <johanru@axis.com>

Split the (e)MMC specific hw_reset code from core.c into mmc.c and
mmc_test.c. Call the code from the new bus_ops member hw_reset.

Export mmc_set_initial_state and mmc_send_status so that they may be
called from mmc_test.

Signed-off-by: Johan Rudholm <johanru@axis.com>
---
 drivers/mmc/card/mmc_test.c |   24 ++++++++++------
 drivers/mmc/core/core.c     |   66 +++++++++++++++----------------------------
 drivers/mmc/core/core.h     |    2 +-
 drivers/mmc/core/mmc.c      |   23 +++++++++++++++
 drivers/mmc/core/mmc_ops.c  |    1 +
 drivers/mmc/core/mmc_ops.h  |    1 -
 include/linux/mmc/core.h    |    5 ++-
 7 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0a7430f..ca5267e 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2342,20 +2342,26 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
 	struct mmc_host *host = card->host;
 	int err;
 
-	err = mmc_hw_reset_check(host);
-	if (!err)
-		return RESULT_OK;
+	if (!mmc_card_mmc(card))
+		return RESULT_UNSUP_CARD;
 
-	if (err == -ENOSYS)
-		return RESULT_FAIL;
+	err = mmc_hw_reset_noinit(host);
+	if (!err) {
+		u32 status;
 
-	if (err != -EOPNOTSUPP)
-		return err;
+		if (!mmc_send_status(card, &status))
+			return RESULT_FAIL;
+		mmc_set_initial_state(host);
+		mmc_power_restore_host(host);
+		return RESULT_OK;
+	}
 
-	if (!mmc_can_reset(card))
+	if (err == -ENOSYS)
+		return RESULT_UNSUP_HOST;
+	else if (err == -EOPNOTSUPP)
 		return RESULT_UNSUP_CARD;
 
-	return RESULT_UNSUP_HOST;
+	return RESULT_FAIL;
 }
 
 static const struct mmc_test_case mmc_test_cases[] = {
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 9584bff..7a17cd2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1114,6 +1114,7 @@ void mmc_set_initial_state(struct mmc_host *host)
 
 	mmc_set_ios(host);
 }
+EXPORT_SYMBOL_GPL(mmc_set_initial_state);
 
 /**
  * mmc_vdd_to_ocrbitnum - Convert a voltage to the OCR bit number
@@ -2245,66 +2246,45 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 	mmc_host_clk_release(host);
 }
 
-int mmc_can_reset(struct mmc_card *card)
+static int mmc_do_hw_reset(struct mmc_host *host, int do_init)
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
+	int ret = 0;
 
-	if (!card)
+	if (!host->card)
 		return -EINVAL;
 
-	if (!mmc_can_reset(card))
-		return -EOPNOTSUPP;
-
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
+	mmc_bus_get(host);
+	if (!host->bus_ops || host->bus_dead || !host->bus_ops->hw_reset) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	/* Set initial state and call mmc_set_ios */
-	mmc_set_initial_state(host);
+	ret = host->bus_ops->hw_reset(host);
+	if (ret)
+		goto out;
 
-	mmc_host_clk_release(host);
+	if (do_init) {
+		mmc_set_initial_state(host);
+		ret = host->bus_ops->power_restore(host);
+	}
 
-	return host->bus_ops->power_restore(host);
+	pr_warn("%s: tried to reset card\n", mmc_hostname(host));
+out:
+	mmc_bus_put(host);
+	return ret;
 }
 
 int mmc_hw_reset(struct mmc_host *host)
 {
-	return mmc_do_hw_reset(host, 0);
+	return mmc_do_hw_reset(host, 1);
 }
 EXPORT_SYMBOL(mmc_hw_reset);
 
-int mmc_hw_reset_check(struct mmc_host *host)
+int mmc_hw_reset_noinit(struct mmc_host *host)
 {
-	return mmc_do_hw_reset(host, 1);
+	return mmc_do_hw_reset(host, 0);
 }
-EXPORT_SYMBOL(mmc_hw_reset_check);
+EXPORT_SYMBOL(mmc_hw_reset_noinit);
 
 static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 {
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index d76597c..4112356 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -27,6 +27,7 @@ struct mmc_bus_ops {
 	int (*power_restore)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
 	int (*shutdown)(struct mmc_host *);
+	int (*hw_reset)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
@@ -49,7 +50,6 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_up(struct mmc_host *host, u32 ocr);
 void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
-void mmc_set_initial_state(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 02ad792..739872d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1821,6 +1821,28 @@ static int mmc_power_restore(struct mmc_host *host)
 	return ret;
 }
 
+static int mmc_mmc_hw_reset(struct mmc_host *host)
+{
+	struct mmc_card *card = host->card;
+	u8 rst_n_function;
+
+	rst_n_function = card->ext_csd.rst_n_function;
+	if ((rst_n_function & EXT_CSD_RST_N_EN_MASK) != EXT_CSD_RST_N_ENABLED)
+		return -EOPNOTSUPP;
+
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+		return -ENOSYS;
+
+	mmc_host_clk_hold(host);
+	mmc_set_clock(host, host->f_init);
+
+	host->ops->hw_reset(host);
+
+	mmc_host_clk_release(host);
+
+	return 0;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.remove = mmc_remove,
 	.detect = mmc_detect,
@@ -1831,6 +1853,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
 	.shutdown = mmc_shutdown,
+	.hw_reset = mmc_mmc_hw_reset,
 };
 
 /*
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 12b2a32..4ff9828 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -56,6 +56,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	return __mmc_send_status(card, status, false);
 }
+EXPORT_SYMBOL_GPL(mmc_send_status);
 
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 6f4b00e..c5be9ce 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,7 +20,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
-int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index c4bdaa1..2959a7c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -156,6 +156,7 @@ extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
 extern int mmc_send_tuning(struct mmc_card *card);
 extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
+extern int mmc_send_status(struct mmc_card *card, u32 *status);
 
 #define MMC_ERASE_ARG		0x00000000
 #define MMC_SECURE_ERASE_ARG	0x80000000
@@ -182,8 +183,7 @@ extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
 extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
 			      bool is_rel_write);
 extern int mmc_hw_reset(struct mmc_host *host);
-extern int mmc_hw_reset_check(struct mmc_host *host);
-extern int mmc_can_reset(struct mmc_card *card);
+extern int mmc_hw_reset_noinit(struct mmc_host *host);
 
 extern void mmc_set_data_timeout(struct mmc_data *, const struct mmc_card *);
 extern unsigned int mmc_align_data_size(struct mmc_card *, unsigned int);
@@ -198,6 +198,7 @@ extern int mmc_flush_cache(struct mmc_card *);
 
 extern int mmc_detect_card_removed(struct mmc_host *host);
 
+extern void mmc_set_initial_state(struct mmc_host *host);
 /**
  *	mmc_claim_host - exclusively claim a host
  *	@host: mmc host to claim
-- 
1.7.2.5

