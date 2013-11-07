From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [RFC PATCH] mmc: core: add the sleep notification feature for eMMC5.0
Date: Thu, 07 Nov 2013 22:53:39 +0900
Message-ID: <527B9B63.6040206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41386 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab3KGNxf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Nov 2013 08:53:35 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVW00FY3BX7SIW0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Nov 2013 22:53:34 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>

Sleep notification is supported since eMMC5.0.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/mmc.c   |   30 +++++++++++++++++++++++++++---
 include/linux/mmc/card.h |    2 ++
 include/linux/mmc/mmc.h  |    2 ++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f631f5a..8c3cce0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -534,7 +534,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	else
 		card->erased_byte = 0x0;
 
-	/* eMMC v4.5 or later */
+	/* eMMC v4.5 */
 	if (card->ext_csd.rev >= 6) {
 		card->ext_csd.feature_support |= MMC_DISCARD_FEATURE;
 
@@ -571,6 +571,16 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		card->ext_csd.data_sector_size = 512;
 	}
 
+	/* eMMC v5.0 or later */
+	if (card->ext_csd.rev >= 7) {
+		card->ext_csd.raw_sleep_noti_time =
+			 ext_csd[EXT_CSD_SLEEP_NOTIFICATION_TIME];
+		if (card->ext_csd.raw_sleep_noti_time > 0 &&
+				card->ext_csd.raw_sleep_noti_time <= 0x17)
+			card->ext_csd.sleep_notification_time =
+				(2 << card->ext_csd.raw_sleep_noti_time)
+				/ USEC_PER_MSEC;
+	}
 out:
 	return err;
 }
@@ -1390,6 +1400,11 @@ static int mmc_sleep(struct mmc_host *host)
 	return err;
 }
 
+static int mmc_can_sleep_notify(const struct mmc_card *card)
+{
+	return card && mmc_card_mmc(card) && card->ext_csd.raw_sleep_noti_time;
+}
+
 static int mmc_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
@@ -1405,6 +1420,8 @@ static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
 	/* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
 	if (notify_type == EXT_CSD_POWER_OFF_LONG)
 		timeout = card->ext_csd.power_off_longtime;
+	else if (notify_type == EXT_CSD_SLEEP_NOTIFICATION)
+		timeout = card->ext_csd.sleep_notification_time;
 
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_POWER_OFF_NOTIFICATION,
@@ -1495,9 +1512,16 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	if (mmc_can_poweroff_notify(host->card) &&
 		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	else if (mmc_can_sleep(host->card)) {
+		if (mmc_can_poweroff_notify(host->card) &&
+			mmc_can_sleep_notify(host->card) && is_suspend) {
+			err = mmc_poweroff_notify(host->card,
+					EXT_CSD_SLEEP_NOTIFICATION);
+			if (err)
+				goto out;
+		}
 		err = mmc_sleep(host);
-	else if (!mmc_host_is_spi(host))
+	} else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
 	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 176fdf8..ca568a7 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -62,6 +62,7 @@ struct mmc_ext_csd {
 	unsigned int		generic_cmd6_time;	/* Units: 10ms */
 	unsigned int            power_off_longtime;     /* Units: ms */
 	u8			power_off_notification;	/* state */
+	unsigned int		sleep_notification_time;/* Units: 10us */
 	unsigned int		hs_max_dtr;
 #define MMC_HIGH_26_MAX_DTR	26000000
 #define MMC_HIGH_52_MAX_DTR	52000000
@@ -98,6 +99,7 @@ struct mmc_ext_csd {
 	u8			raw_pwr_cl_26_195;	/* 201 */
 	u8			raw_pwr_cl_52_360;	/* 202 */
 	u8			raw_pwr_cl_26_360;	/* 203 */
+	u8			raw_sleep_noti_time;	/* 216 */
 	u8			raw_s_a_timeout;	/* 217 */
 	u8			raw_hc_erase_gap_size;	/* 221 */
 	u8			raw_erase_timeout_mult;	/* 223 */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 50bcde3..229ba16 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -307,6 +307,7 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_52_360		202	/* RO */
 #define EXT_CSD_PWR_CL_26_360		203	/* RO */
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
+#define EXT_CSD_SLEEP_NOTIFICATION_TIME 216	/* Ro */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
 #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
@@ -385,6 +386,7 @@ struct _mmc_csd {
 #define EXT_CSD_POWER_ON		1
 #define EXT_CSD_POWER_OFF_SHORT		2
 #define EXT_CSD_POWER_OFF_LONG		3
+#define EXT_CSD_SLEEP_NOTIFICATION	4
 
 #define EXT_CSD_PWR_CL_8BIT_MASK	0xF0	/* 8 bit PWR CLS */
 #define EXT_CSD_PWR_CL_4BIT_MASK	0x0F	/* 8 bit PWR CLS */
-- 
1.7.9.5
