From: Saugata Das <saugata.das@stericsson.com>
Subject: [RFC] MMC-4.5 Power OFF Notify rework
Date: Fri, 30 Mar 2012 14:44:17 +0530
Message-ID: <1333098857-30305-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:46547 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759436Ab2C3JOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Mar 2012 05:14:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, saugata.das@linaro.org, girish.shivananjappa@linaro.org

From: Saugata Das <saugata.das@linaro.org>

This is a rework of the existing POWER OFF NOTIFY patch. The problem with
the existing patch comes from the ambiguity on the usage of POWER OFF NOTIFY
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

Signed-off-by: Saugata Das <saugata.das@linaro.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/core.c  |   36 ++++++++++++++----------------------
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |   18 +++++++++++-------
 include/linux/mmc/host.h |    1 +
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 14f262e..dc85ee1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1096,12 +1096,12 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 	mmc_host_clk_release(host);
 }
 
-static void mmc_poweroff_notify(struct mmc_host *host)
+int mmc_poweroff_notify(struct mmc_host *host)
 {
 	struct mmc_card *card;
 	unsigned int timeout;
 	unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
-	int err = 0;
+	int err = -EINVAL;
 
 	card = host->card;
 	mmc_claim_host(host);
@@ -1136,6 +1136,7 @@ static void mmc_poweroff_notify(struct mmc_host *host)
 		card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
 	}
 	mmc_release_host(host);
+	return err;
 }
 
 /*
@@ -1194,30 +1195,12 @@ static void mmc_power_up(struct mmc_host *host)
 
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
@@ -2076,6 +2059,7 @@ void mmc_stop_host(struct mmc_host *host)
 	host->pm_flags = 0;
 
 	mmc_bus_get(host);
+	mmc_poweroff_notify(host);
 	if (host->bus_ops && !host->bus_dead) {
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		if (host->bus_ops->remove)
@@ -2112,7 +2096,8 @@ int mmc_power_save_host(struct mmc_host *host)
 
 	if (host->bus_ops->power_save)
 		ret = host->bus_ops->power_save(host);
-
+	host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+	mmc_poweroff_notify(host);
 	mmc_bus_put(host);
 
 	mmc_power_off(host);
@@ -2135,7 +2120,7 @@ int mmc_power_restore_host(struct mmc_host *host)
 		mmc_bus_put(host);
 		return -EINVAL;
 	}
-
+	host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
 	mmc_power_up(host);
 	ret = host->bus_ops->power_restore(host);
 
@@ -2157,6 +2142,9 @@ int mmc_card_awake(struct mmc_host *host)
 	if (host->bus_ops && !host->bus_dead && host->bus_ops->awake)
 		err = host->bus_ops->awake(host);
 
+	if (!err)
+		mmc_card_clr_sleep(host->card);
+
 	mmc_bus_put(host);
 
 	return err;
@@ -2175,6 +2163,9 @@ int mmc_card_sleep(struct mmc_host *host)
 	if (host->bus_ops && !host->bus_dead && host->bus_ops->sleep)
 		err = host->bus_ops->sleep(host);
 
+	if (!err)
+		mmc_card_set_sleep(host->card);
+
 	mmc_bus_put(host);
 
 	return err;
@@ -2393,6 +2384,7 @@ int mmc_pm_notify(struct notifier_block *notify_block,
 			host->bus_ops->remove(host);
 
 		mmc_claim_host(host);
+		mmc_poweroff_notify(host);
 		mmc_detach_bus(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 3bdafbc..0bdc0fd 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -45,6 +45,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage,
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
+int mmc_poweroff_notify(struct mmc_host *host);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 02914d6..3e67480 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1338,11 +1338,15 @@ static int mmc_suspend(struct mmc_host *host)
 	BUG_ON(!host->card);
 
 	mmc_claim_host(host);
-	if (mmc_card_can_sleep(host)) {
-		err = mmc_card_sleep(host);
+	if (host->caps2 & MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND) {
+		err = mmc_poweroff_notify(host);
 		if (!err)
-			mmc_card_set_sleep(host->card);
-	} else if (!mmc_host_is_spi(host))
+			return err;
+	}
+
+	if (mmc_card_can_sleep(host))
+		err = mmc_card_sleep(host);
+	else if (!mmc_host_is_spi(host))
 		mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 	mmc_release_host(host);
@@ -1364,11 +1368,11 @@ static int mmc_resume(struct mmc_host *host)
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 33a4d08..0e843c7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -237,6 +237,7 @@ struct mmc_host {
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
 #define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
+#define MMC_CAP2_POWER_OFF_VCCQ_DURING_SUSPEND	(1 << 10)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.4.3

