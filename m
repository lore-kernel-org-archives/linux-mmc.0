From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: core: Restructure and simplify code for mmc sleep|awake
Date: Fri, 19 Apr 2013 15:12:11 +0200
Message-ID: <1366377131-2984-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:47446 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030298Ab3DSNMw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Apr 2013 09:12:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The mmc_card_sleep|awake APIs are not being used since the support is
already properly encapsulated within the suspend sequence. Sleep|awake
command is also specific for eMMC.

We remove the sleep|awake bus_ops, the mmc_card_sleep|awake APIs and
move the code into the mmc specific core instead. This also includes
the mmc ops function, mmc_sleepawake. All releated functions have then
become static and we have got far less code to maintain.

Additionally this patch also simplifies the code from mmc_sleepawake,
since it is only used to put the card to sleep and not awake.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    |   46 --------------------------
 drivers/mmc/core/core.h    |    2 --
 drivers/mmc/core/mmc.c     |   77 +++++++++++++++++++++++---------------------
 drivers/mmc/core/mmc_ops.c |   34 -------------------
 drivers/mmc/core/mmc_ops.h |    1 -
 include/linux/mmc/host.h   |    4 ---
 6 files changed, 41 insertions(+), 123 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad7decc..4192c8c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2507,52 +2507,6 @@ int mmc_power_restore_host(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_power_restore_host);
 
-int mmc_card_awake(struct mmc_host *host)
-{
-	int err = -ENOSYS;
-
-	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
-		return 0;
-
-	mmc_bus_get(host);
-
-	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
-		err = host->bus_ops->awake(host);
-
-	mmc_bus_put(host);
-
-	return err;
-}
-EXPORT_SYMBOL(mmc_card_awake);
-
-int mmc_card_sleep(struct mmc_host *host)
-{
-	int err = -ENOSYS;
-
-	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
-		return 0;
-
-	mmc_bus_get(host);
-
-	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
-		err = host->bus_ops->sleep(host);
-
-	mmc_bus_put(host);
-
-	return err;
-}
-EXPORT_SYMBOL(mmc_card_sleep);
-
-int mmc_card_can_sleep(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-
-	if (card && mmc_card_mmc(card) && card->ext_csd.rev >= 3)
-		return 1;
-	return 0;
-}
-EXPORT_SYMBOL(mmc_card_can_sleep);
-
 /*
  * Flush the cache to the non-volatile storage.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index b9f18a2..68892e1 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -16,8 +16,6 @@
 #define MMC_CMD_RETRIES        3
 
 struct mmc_bus_ops {
-	int (*awake)(struct mmc_host *);
-	int (*sleep)(struct mmc_host *);
 	void (*remove)(struct mmc_host *);
 	void (*detect)(struct mmc_host *);
 	int (*suspend)(struct mmc_host *);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d584f7c..2934e5c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1321,6 +1321,45 @@ err:
 	return err;
 }
 
+static int mmc_can_sleep(struct mmc_card *card)
+{
+	return (card && card->ext_csd.rev >= 3);
+}
+
+static int mmc_sleep(struct mmc_host *host)
+{
+	struct mmc_command cmd = {0};
+	struct mmc_card *card = host->card;
+	int err;
+
+	if (host->caps2 & MMC_CAP2_NO_SLEEP_CMD)
+		return 0;
+
+	err = mmc_deselect_cards(host);
+	if (err)
+		return err;
+
+	cmd.opcode = MMC_SLEEP_AWAKE;
+	cmd.arg = card->rca << 16;
+	cmd.arg |= 1 << 15;
+
+	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err)
+		return err;
+
+	/*
+	 * If the host does not wait while the card signals busy, then we will
+	 * will have to wait the sleep/awake timeout.  Note, we cannot use the
+	 * SEND_STATUS command to poll the status because that command (and most
+	 * others) is invalid while the card sleeps.
+	 */
+	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
+		mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
+
+	return err;
+}
+
 static int mmc_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
@@ -1417,8 +1456,8 @@ static int mmc_suspend(struct mmc_host *host)
 
 	if (mmc_can_poweroff_notify(host->card))
 		err = mmc_poweroff_notify(host->card, EXT_CSD_POWER_OFF_SHORT);
-	else if (mmc_card_can_sleep(host))
-		err = mmc_card_sleep(host);
+	else if (mmc_can_sleep(host->card))
+		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
@@ -1460,39 +1499,7 @@ static int mmc_power_restore(struct mmc_host *host)
 	return ret;
 }
 
-static int mmc_sleep(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-	int err = -ENOSYS;
-
-	if (card && card->ext_csd.rev >= 3) {
-		err = mmc_card_sleepawake(host, 1);
-		if (err < 0)
-			pr_debug("%s: Error %d while putting card into sleep",
-				 mmc_hostname(host), err);
-	}
-
-	return err;
-}
-
-static int mmc_awake(struct mmc_host *host)
-{
-	struct mmc_card *card = host->card;
-	int err = -ENOSYS;
-
-	if (card && card->ext_csd.rev >= 3) {
-		err = mmc_card_sleepawake(host, 0);
-		if (err < 0)
-			pr_debug("%s: Error %d while awaking sleeping card",
-				 mmc_hostname(host), err);
-	}
-
-	return err;
-}
-
 static const struct mmc_bus_ops mmc_ops = {
-	.awake = mmc_awake,
-	.sleep = mmc_sleep,
 	.remove = mmc_remove,
 	.detect = mmc_detect,
 	.suspend = NULL,
@@ -1502,8 +1509,6 @@ static const struct mmc_bus_ops mmc_ops = {
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
-	.awake = mmc_awake,
-	.sleep = mmc_sleep,
 	.remove = mmc_remove,
 	.detect = mmc_detect,
 	.suspend = mmc_suspend,
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 49f04bc..9ea21f2 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -59,40 +59,6 @@ int mmc_deselect_cards(struct mmc_host *host)
 	return _mmc_select_card(host, NULL);
 }
 
-int mmc_card_sleepawake(struct mmc_host *host, int sleep)
-{
-	struct mmc_command cmd = {0};
-	struct mmc_card *card = host->card;
-	int err;
-
-	if (sleep)
-		mmc_deselect_cards(host);
-
-	cmd.opcode = MMC_SLEEP_AWAKE;
-	cmd.arg = card->rca << 16;
-	if (sleep)
-		cmd.arg |= 1 << 15;
-
-	cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
-	err = mmc_wait_for_cmd(host, &cmd, 0);
-	if (err)
-		return err;
-
-	/*
-	 * If the host does not wait while the card signals busy, then we will
-	 * will have to wait the sleep/awake timeout.  Note, we cannot use the
-	 * SEND_STATUS command to poll the status because that command (and most
-	 * others) is invalid while the card sleeps.
-	 */
-	if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
-		mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
-
-	if (!sleep)
-		err = mmc_select_card(card);
-
-	return err;
-}
-
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 3dd8941..80ae9f4 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -24,7 +24,6 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
-int mmc_card_sleepawake(struct mmc_host *host, int sleep);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 17d7148..4868470 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -426,10 +426,6 @@ static inline int mmc_regulator_get_supply(struct mmc_host *mmc)
 }
 #endif
 
-int mmc_card_awake(struct mmc_host *host);
-int mmc_card_sleep(struct mmc_host *host);
-int mmc_card_can_sleep(struct mmc_host *host);
-
 int mmc_pm_notify(struct notifier_block *notify_block, unsigned long, void *);
 
 /* Module parameter */
-- 
1.7.10

