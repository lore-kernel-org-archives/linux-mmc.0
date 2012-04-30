From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V2] MMC-4.5 Power OFF Notify rework
Date: Mon, 30 Apr 2012 11:44:56 +0530
Message-ID: <1335766496-15966-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:64585 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2D3GPS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Apr 2012 02:15:18 -0400
Received: by dadz8 with SMTP id z8so3654519dad.10
        for <linux-mmc@vger.kernel.org>; Sun, 29 Apr 2012 23:15:18 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, ulf.hansson@stericsson.com, saugata.das@linaro.org, girish.shivananjappa@linaro.org

This is a rework of the existing POWER OFF NOTIFY patch. The current problem
with the patch comes from the ambiguity on the usage of POWER OFF NOTIFY
together with SLEEP and misunderstanding on the usage of MMC_POWER_OFF
power_mode from mmc_set_ios in different host controller drivers.

This new patch works around this problem by adding a new host CAP,
MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND, which when set sends a
POWER OFF NOTIFY from mmc_suspend instead of SLEEP. It is expected that host
controller drivers will set this CAP, if they switch off both Vcc and Vccq
from MMC_POWER_OFF condition within mmc_set_ios. However, note that there
is no harm in sending MMC_POWER_NOTIFY even if Vccq is not switched off.

This patch also sends POWER OFF NOTIFY from power management routines (e.g.
mmc_power_save_host, mmc_pm_notify/PM_SUSPEND_PREPARE, mmc_stop_host), which
does reinitialization of the eMMC on the return path of the power management
routines (e.g. mmc_power_restore_host, mmc_pm_notify/PM_POST_RESTORE,
mmc_start_host).

This patch sets POWER_OFF_NOTIFICATION to POWER_OFF_SHORT if it is sent from
the suspend sequence. If it is sent from shutdown sequence then it is set to
POWER_OFF_LONG.

Previuos implementation of PowerOff Notify as a core function is replaced as
a device's bus operation.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c  |   95 +++++++++++++++------------------------------
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |   76 +++++++++++++++++++++++++++++++------
 include/linux/mmc/host.h |    1 +
 4 files changed, 98 insertions(+), 75 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ba821fe..7f5461e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1100,48 +1100,6 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 	mmc_host_clk_release(host);
 }
 
-static void mmc_poweroff_notify(struct mmc_host *host)
-{
-	struct mmc_card *card;
-	unsigned int timeout;
-	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
-	int err = 0;
-
-	card = host->card;
-	mmc_claim_host(host);
-
-	/*
-	 * Send power notify command only if card
-	 * is mmc and notify state is powered ON
-	 */
-	if (card && mmc_card_mmc(card) &&
-	    (card->poweroff_notify_state == MMC_POWERED_ON)) {
-
-		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
-			notify_type = EXT_CSD_POWER_OFF_SHORT;
-			timeout = card->ext_csd.generic_cmd6_time;
-			card->poweroff_notify_state = MMC_POWEROFF_SHORT;
-		} else {
-			notify_type = EXT_CSD_POWER_OFF_LONG;
-			timeout = card->ext_csd.power_off_longtime;
-			card->poweroff_notify_state = MMC_POWEROFF_LONG;
-		}
-
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_POWER_OFF_NOTIFICATION,
-				 notify_type, timeout);
-
-		if (err && err != -EBADMSG)
-			pr_err("Device failed to respond within %d poweroff "
-			       "time. Forcefully powering down the device\n",
-			       timeout);
-
-		/* Set the card state to no notification after the poweroff */
-		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
-	}
-	mmc_release_host(host);
-}
-
 /*
  * Apply power to the MMC stack.  This is a two-stage process.
  * First, we enable power to the card without the clock running.
@@ -1198,30 +1156,12 @@ static void mmc_power_up(struct mmc_host *host)
 
 void mmc_power_off(struct mmc_host *host)
 {
-	int err = 0;
 	mmc_host_clk_hold(host);
 
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
 	/*
-	 * For eMMC 4.5 device send AWAKE command before
-	 * POWER_OFF_NOTIFY command, because in sleep state
-	 * eMMC 4.5 devices respond to only RESET and AWAKE cmd
-	 */
-	if (host->card && mmc_card_is_sleep(host->card) &&
-	    host->bus_ops->resume) {
-		err = host->bus_ops->resume(host);
-
-		if (!err)
-			mmc_poweroff_notify(host);
-		else
-			pr_warning("%s: error %d during resume "
-				   "(continue with poweroff sequence)\n",
-				   mmc_hostname(host), err);
-	}
-
-	/*
 	 * Reset ocr mask to be the highest possible voltage supported for
 	 * this mmc host. This value will be used at next power up.
 	 */
@@ -2084,6 +2024,14 @@ void mmc_stop_host(struct mmc_host *host)
 
 	mmc_bus_get(host);
 	if (host->bus_ops && !host->bus_dead) {
+
+		if (host->bus_ops->poweroff_notify) {
+			int err = host->bus_ops->poweroff_notify(host);
+			if (err)
+				pr_info("%s: error [%x] in poweroff notify\n",
+					mmc_hostname(host), err);
+		}
+
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		if (host->bus_ops->remove)
 			host->bus_ops->remove(host);
@@ -2093,6 +2041,7 @@ void mmc_stop_host(struct mmc_host *host)
 		mmc_power_off(host);
 		mmc_release_host(host);
 		mmc_bus_put(host);
+
 		return;
 	}
 	mmc_bus_put(host);
@@ -2119,6 +2068,13 @@ int mmc_power_save_host(struct mmc_host *host)
 
 	if (host->bus_ops->power_save)
 		ret = host->bus_ops->power_save(host);
+	host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+	if (host->bus_ops->poweroff_notify) {
+		int err = host->bus_ops->poweroff_notify(host);
+		if (err)
+			pr_info("%s: error [%x] in poweroff notify\n",
+				mmc_hostname(host), err);
+	}
 
 	mmc_bus_put(host);
 
@@ -2142,7 +2098,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 		mmc_bus_put(host);
 		return -EINVAL;
 	}
-
+	host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
 	mmc_power_up(host);
 	ret = host->bus_ops->power_restore(host);
 
@@ -2161,8 +2117,11 @@ int mmc_card_awake(struct mmc_host *host)
 
 	mmc_bus_get(host);
 
-	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
+	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake) {
 		err = host->bus_ops->awake(host);
+		if (!err)
+			mmc_card_clr_sleep(host->card);
+	}
 
 	mmc_bus_put(host);
 
@@ -2179,8 +2138,11 @@ int mmc_card_sleep(struct mmc_host *host)
 
 	mmc_bus_get(host);
 
-	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
+	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep) {
 		err = host->bus_ops->sleep(host);
+		if (!err)
+			mmc_card_set_sleep(host->card);
+	}
 
 	mmc_bus_put(host);
 
@@ -2379,6 +2341,12 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 
 		if (!host->bus_ops || host->bus_ops->suspend)
 			break;
+		if (host->bus_ops->poweroff_notify) {
+			int err = host->bus_ops->poweroff_notify(host);
+			if (err)
+				pr_info("%s: error [%x] in poweroff notify\n",
+					mmc_hostname(host), err);
+		}
 
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		if (host->bus_ops->remove)
@@ -2388,6 +2356,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 		mmc_detach_bus(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
+
 		host->pm_flags = 0;
 		break;
 
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..351cbbe 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -25,6 +25,7 @@ struct mmc_bus_ops {
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
+	int (*poweroff_notify)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 54df5ad..11ab536 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1282,6 +1282,50 @@ err:
 	return err;
 }
 
+static int mmc_poweroff_notify(struct mmc_host *host)
+{
+	struct mmc_card *card;
+	unsigned int timeout;
+	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
+	int err = -EOPNOTSUPP;
+
+	card = host->card;
+	mmc_claim_host(host);
+
+	/*
+	 * Send power notify command only if card
+	 * is mmc and notify state is powered ON
+	 */
+	if (card && mmc_card_mmc(card) &&
+	    (card->poweroff_notify_state == MMC_POWERED_ON)) {
+
+		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
+			notify_type = EXT_CSD_POWER_OFF_SHORT;
+			timeout = card->ext_csd.generic_cmd6_time;
+			card->poweroff_notify_state = MMC_POWEROFF_SHORT;
+		} else {
+			notify_type = EXT_CSD_POWER_OFF_LONG;
+			timeout = card->ext_csd.power_off_longtime;
+			card->poweroff_notify_state = MMC_POWEROFF_LONG;
+		}
+
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_POWER_OFF_NOTIFICATION,
+				 notify_type, timeout);
+
+		if (err && err != -EBADMSG)
+			pr_err("%s: Device failed to respond within %d "
+			       "poweroff time. Forcefully powering down "
+			       "the device\n", mmc_hostname(host), timeout);
+
+		/* Set the card state to no notification after the poweroff */
+		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
+	}
+	mmc_release_host(host);
+
+	return err;
+}
+
 /*
  * Host is being removed. Free up the current card.
  */
@@ -1341,15 +1385,21 @@ static int mmc_suspend(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_claim_host(host);
-	if (mmc_card_can_sleep(host)) {
-		err = mmc_card_sleep(host);
-		if (!err)
-			mmc_card_set_sleep(host->card);
-	} else if (!mmc_host_is_spi(host))
-		mmc_deselect_cards(host);
-	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
-	mmc_release_host(host);
+	if ((host->card) && mmc_card_mmc(host->card) &&
+		(host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND)) {
+		err = mmc_poweroff_notify(host);
+	} else {
+		mmc_claim_host(host);
+		if (mmc_card_can_sleep(host))
+			err = mmc_card_sleep(host);
+		else if (!mmc_host_is_spi(host))
+			mmc_deselect_cards(host);
+		mmc_release_host(host);
+	}
+
+	if (!err)
+		host->card->state &=
+			~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 
 	return err;
 }
@@ -1368,11 +1418,11 @@ static int mmc_resume(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	if (mmc_card_is_sleep(host->card)) {
+	if (mmc_card_is_sleep(host->card))
 		err = mmc_card_awake(host);
-		mmc_card_clr_sleep(host->card);
-	} else
+	else
 		err = mmc_init_card(host, host->ocr, host->card);
+
 	mmc_release_host(host);
 
 	return err;
@@ -1430,6 +1480,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
+	.poweroff_notify = mmc_poweroff_notify,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -1441,6 +1492,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
+	.poweroff_notify = mmc_poweroff_notify,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0707d22..986e22b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -238,6 +238,7 @@ struct mmc_host {
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
+#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND	(1 << 10)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.4.1

