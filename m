From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/6] mmc: core: Rename __mmc_set_signal_voltage() to mmc_set_signal_voltage()
Date: Wed, 25 Jan 2017 16:12:20 +0100
Message-ID: <1485357143-23280-4-git-send-email-ulf.hansson@linaro.org>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35072 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdAYPMi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 10:12:38 -0500
Received: by mail-lf0-f49.google.com with SMTP id n124so130206696lfd.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 07:12:38 -0800 (PST)
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

Earlier the mmc_set_signal_voltage() existed, but since it has been renamed
to mmc_set_uhs_voltage(), we can now use that name instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 10 +++++-----
 drivers/mmc/core/core.h |  2 +-
 drivers/mmc/core/mmc.c  | 16 ++++++++--------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 82c1a02..1d44aa2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1631,7 +1631,7 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	return ocr;
 }
 
-int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 {
 	int err = 0;
 	int old_signal_voltage = host->ios.signal_voltage;
@@ -1691,7 +1691,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 	host->ios.clock = 0;
 	mmc_set_ios(host);
 
-	if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180)) {
+	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180)) {
 		/*
 		 * Voltages may not have been switched, but we've already
 		 * sent CMD11, so a power cycle is required anyway
@@ -1800,11 +1800,11 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	mmc_set_initial_state(host);
 
 	/* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
-	if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
+	if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
 		dev_dbg(mmc_dev(host), "Initial signal voltage of 3.3v\n");
-	else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0)
+	else if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0)
 		dev_dbg(mmc_dev(host), "Initial signal voltage of 1.8v\n");
-	else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) == 0)
+	else if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) == 0)
 		dev_dbg(mmc_dev(host), "Initial signal voltage of 1.2v\n");
 
 	/*
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index aee23f5..55f543f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -49,7 +49,7 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr);
-int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b91abe0..5844f29 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1122,14 +1122,14 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	 */
 	err = -EINVAL;
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
 	if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V))
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* make sure vccq is 3.3v after switching disaster */
 	if (err)
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
 
 	return err;
 }
@@ -1296,10 +1296,10 @@ static int mmc_select_hs400es(struct mmc_card *card)
 	}
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_2V)
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
 	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400_1_8V)
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* If fails try again during next card power cycle */
 	if (err)
@@ -1405,10 +1405,10 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	old_signal_voltage = host->ios.signal_voltage;
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
 	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
-		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 
 	/* If fails try again during next card power cycle */
 	if (err)
@@ -1450,7 +1450,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 err:
 	if (err) {
 		/* fall back to the old signal voltage, if fails report error */
-		if (__mmc_set_signal_voltage(host, old_signal_voltage))
+		if (mmc_set_signal_voltage(host, old_signal_voltage))
 			err = -EIO;
 
 		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
-- 
1.9.1

