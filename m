From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: [RFC PATCH v2] mmc: sleep notification
Date: Tue, 26 May 2015 13:44:13 +0000
Message-ID: <FDD07FEB422EF948A392FDC201AEEAE64FA9EC74@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:54816
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752883AbbEZN6Z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2015 09:58:25 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alex Lemberg <Alex.Lemberg@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>

This patch is implements the new additional state of
Power_Off_Notification - SLEEP_NOTIFICATION.
Until now, the implementation of Power_Off_Notification
supported only three modes - POWERED_ON (0x01),
POWER_OFF_SHORT (0x02) and POWER_OFF_LONG (0x03).

As part of eMMC5.0 before moving to Sleep state hosts may set the
POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
After setting SLEEP_NOTIFICATION, host should wait for
the busy line to be de-asserted.
The max timeout allowed for busy line de-assertion defined
in SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216].
HPI may interrupt the SLEEP_NOTIFICATION operation.
In that case POWER_OFF_NOTIFICATION byte will restore to POWERED_ON.

Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
---------
v2:
- remove calling mmc_interrupt_hpi in case the device is doing
  sleep notification from block.c
- remove call of "mmc_card_doing_sleep_notify" from core.c
- mmc_sleep_notify changed to static function

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a802863..2bf2b2c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -59,6 +59,12 @@ static const unsigned int tacc_mant[] = {
 		__res & __mask;						\
 	})
 
+#define MMC_SLEEP_NOTIFY_MAX_TIME	0x17
+#define GET_SLEEP_NOTIFY_TIME(value) \
+	(10 * (1 << (unsigned int)(value)))
+#define GET_SLEEP_NOTIFY_TIME_MSEC(value) \
+	(DIV_ROUND_UP(GET_SLEEP_NOTIFY_TIME(value), 1000))
+
 /*
  * Given the decoded CSD structure, decode the raw CID to our CID structure.
  */
@@ -582,6 +588,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.ffu_capable =
 			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
 			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
+		card->ext_csd.sleep_notify_time =
+			ext_csd[EXT_CSD_SLEEP_NOTIFICATION_TIME];
 	}
 out:
 	return err;
@@ -1529,6 +1537,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			card->ext_csd.hpi_en = 1;
 	}
 
+	/* sleep notify enable/disable for eMMC 5.0 and above */
+	if ((card->ext_csd.rev >= 7) &&  card->ext_csd.hpi_en &&
+			(card->host->caps2 & MMC_CAP2_SLEEP_NOTIFY) &&
+			card->ext_csd.sleep_notify_time > 0 &&
+			card->ext_csd.sleep_notify_time <=
+				MMC_SLEEP_NOTIFY_MAX_TIME) {
+		card->can_sleep_notify = 1;
+	}
+
 	/*
 	 * If cache size is higher than 0, this indicates
 	 * the existence of cache and it can be turned on.
@@ -1642,6 +1659,33 @@ out_release:
 	return err;
 }
 
+/*
+ * check if device is in program state (busy)
+ */
+static bool mmc_device_prg_state(struct mmc_card *card)
+{
+	int rc;
+	u32 status;
+	bool state;
+
+	mmc_get_card(card);
+	rc = mmc_send_status(card, &status);
+	if (rc) {
+		pr_err("%s: Get card status fail. rc=%d\n",
+			mmc_hostname(card->host), rc);
+		state = false;
+		goto out;
+	}
+
+	if (R1_CURRENT_STATE(status) == R1_STATE_PRG)
+		state =  true;
+	else
+		state =  false;
+out:
+	mmc_put_card(card);
+	return state;
+}
+
 static int mmc_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
@@ -1653,20 +1697,106 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 {
 	unsigned int timeout = card->ext_csd.generic_cmd6_time;
 	int err;
+	bool use_busy_signal;
 
 	/* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
 	if (notify_type == EXT_CSD_POWER_OFF_LONG)
 		timeout = card->ext_csd.power_off_longtime;
+	else if (notify_type == EXT_CSD_SLEEP_NOTIFICATION) {
+		/* calculate the maximum timeout for the
+		 * switch command when notifying the device
+		 * that it is about to move to sleep */
+		timeout = GET_SLEEP_NOTIFY_TIME_MSEC(
+			card->ext_csd.sleep_notify_time);
+	}
 
+	/* do not wait on busy signal in case of
+	 * Sleep Notification - to let host get
+	 * another requests
+	 */
+	use_busy_signal = (notify_type == EXT_CSD_SLEEP_NOTIFICATION) ?
+			false : true;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
-			notify_type, timeout, true, false, false);
-	if (err)
+			notify_type, timeout,
+			use_busy_signal, false, false);
+	if (!err) {
+		card->ext_csd.power_off_notification = notify_type;
+	} else {
 		pr_err("%s: Power Off Notification timed out, %u\n",
-		       mmc_hostname(card->host), timeout);
+			mmc_hostname(card->host), timeout);
+	}
 
-	/* Disable the power off notification after the switch operation. */
-	card->ext_csd.power_off_notification = EXT_CSD_NO_POWER_NOTIFICATION;
+	return err;
+}
+
+static int mmc_sleep_notify(struct mmc_card *card)
+{
+	int err = 0;
+	bool is_busy = 0;
+	unsigned long prg_wait = 0;
+
+	if (!card->can_sleep_notify || !mmc_can_poweroff_notify(card))
+		return 0;
+
+	if (!mmc_card_doing_sleep_notify(card)) {
+		mmc_get_card(card);
+		mmc_card_set_sleep_notify(card);
+		err = mmc_poweroff_notify(card,
+			EXT_CSD_SLEEP_NOTIFICATION);
+		mmc_put_card(card);
+		if (err) {
+			pr_err("%s: mmc_poweroff_notify failed with %d\n",
+			       __func__, err);
+			goto out;
+		}
+
+		prg_wait = jiffies +
+			msecs_to_jiffies(GET_SLEEP_NOTIFY_TIME_MSEC(
+			card->ext_csd.sleep_notify_time));
+		}
+
+	/*
+	 * Loop will run until:
+	 * 1. Device is no more in Busy state
+	 * 2. Sleep notification is not interrupted by HPI & IO request
+	 */
+	do {
+		/* added some delay to avoid sending card status too often */
+		msleep(20);
+		err = 0;
+		/* Stop polling in case sleep notification was HPIed already */
+		if (!mmc_card_doing_sleep_notify(card)) {
+			is_busy = mmc_device_prg_state(card);
+			if (is_busy)
+				err = -EBUSY;
+			break;
+		}
+		is_busy = mmc_device_prg_state(card);
+		if (is_busy && time_after(jiffies, prg_wait)) {
+			/*
+			 * making sure we are still in busy before
+			 * sending HPI due to timeout error
+			 */
+			is_busy = mmc_device_prg_state(card);
+			if (is_busy) {
+				if (mmc_card_doing_sleep_notify(card)) {
+					card->ext_csd.power_off_notification =
+						EXT_CSD_POWER_ON;
+					mmc_interrupt_hpi(card);
+				}
+				err = -ETIMEDOUT;
+				break;
+			}
+		}
+	} while (is_busy);
+
+out:
+	mmc_card_clr_sleep_notify(card);
+	if (err) {
+		pr_err("%s: mmc_poweroff_notify for sleep failed with %d\n",
+		       mmc_hostname(card->host), err);
+	}
 
 	return err;
 }
@@ -1745,8 +1875,16 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
-		err = mmc_poweroff_notify(host->card, notify_type);
+		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend)) {
+		if (!host->card->can_sleep_notify ||
+			!mmc_can_poweroff_notify(host->card)) {
+			err = mmc_poweroff_notify(host->card, notify_type);
+		} else {
+			err = mmc_sleep_notify(host->card);
+			if (err != -ETIMEDOUT)
+				err = mmc_sleep(host);
+		}
+	}
 	else if (mmc_can_sleep(host->card))
 		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 19f0175..ed91e6f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -62,6 +62,7 @@ struct mmc_ext_csd {
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		generic_cmd6_time;	/* Units: 10ms */
 	unsigned int            power_off_longtime;     /* Units: ms */
+	unsigned int		sleep_notify_time;	/* Units: us */
 	u8			power_off_notification;	/* state */
 	unsigned int		hs_max_dtr;
 	unsigned int		hs200_max_dtr;
@@ -262,6 +263,7 @@ struct mmc_card {
 #define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
 #define MMC_STATE_DOING_BKOPS	(1<<5)		/* card is doing BKOPS */
 #define MMC_STATE_SUSPENDED	(1<<6)		/* card is suspended */
+#define MMC_STATE_SLEEP_NOTIFY (1<<7)		/* card in sleep notify */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -309,6 +311,7 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+	u8 can_sleep_notify;	/* sleep_notify on/off */
 };
 
 /*
@@ -427,6 +430,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
 #define mmc_card_suspended(c)	((c)->state & MMC_STATE_SUSPENDED)
+#define mmc_card_doing_sleep_notify(c) ((c)->state & MMC_STATE_SLEEP_NOTIFY)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -437,6 +441,8 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
 #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
 #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
+#define mmc_card_set_sleep_notify(c)	((c)->state |= MMC_STATE_SLEEP_NOTIFY)
+#define mmc_card_clr_sleep_notify(c)	((c)->state &= ~MMC_STATE_SLEEP_NOTIFY)
 
 /*
  * Quirk add/remove for MMC products.
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f471193..111e05d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -286,6 +286,7 @@ struct mmc_host {
 				 MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_HSX00_1_2V	(MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
 #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
+#define MMC_CAP2_SLEEP_NOTIFY	(1 << 18)	/* sleep notify supported */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 124f562..bbb71ae 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -309,6 +309,7 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_52_360		202	/* RO */
 #define EXT_CSD_PWR_CL_26_360		203	/* RO */
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
+#define EXT_CSD_SLEEP_NOTIFICATION_TIME	216	/* RO */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
 #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
@@ -403,6 +404,7 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_ON		1
 #define EXT_CSD_POWER_OFF_SHORT		2
 #define EXT_CSD_POWER_OFF_LONG		3
+#define EXT_CSD_SLEEP_NOTIFICATION	4
 
 #define EXT_CSD_PWR_CL_8BIT_MASK	0xF0	/* 8 bit PWR CLS */
 #define EXT_CSD_PWR_CL_4BIT_MASK	0x0F	/* 8 bit PWR CLS */
-- 
1.7.9.5

