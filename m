From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/6] mmc: core: Clarify usage of mmc_set_signal_voltage()
Date: Wed, 25 Jan 2017 16:12:19 +0100
Message-ID: <1485357143-23280-3-git-send-email-ulf.hansson@linaro.org>
References: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36532 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdAYPMe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2017 10:12:34 -0500
Received: by mail-lf0-f51.google.com with SMTP id z134so130469801lff.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Jan 2017 07:12:33 -0800 (PST)
In-Reply-To: <1485357143-23280-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <festevam@gmail.com>, Jan Glauber <jan.glauber@caviumnetworks.com>

The mmc_set_signal_voltage() function is used for SD/SDIO when switching to
1.8V for UHS mode. To clarify this let's do the following changes.

- We are always providing MMC_SIGNAL_VOLTAGE_180 as the signal_voltage
  parameter to the function. Then, let's just remove the parameter as it
  serves no purpose.
- Rename the function to mmc_set_uhs_voltage().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 4 ++--
 drivers/mmc/core/core.h | 2 +-
 drivers/mmc/core/sd.c   | 3 +--
 drivers/mmc/core/sdio.c | 3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bb819d4..82c1a02 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1647,7 +1647,7 @@ int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
 
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
+int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
 {
 	struct mmc_command cmd = {};
 	int err = 0;
@@ -1691,7 +1691,7 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
 	host->ios.clock = 0;
 	mmc_set_ios(host);
 
-	if (__mmc_set_signal_voltage(host, signal_voltage)) {
+	if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180)) {
 		/*
 		 * Voltages may not have been switched, but we've already
 		 * sent CMD11, so a power cycle is required anyway
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 8a95c825..aee23f5 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -48,7 +48,7 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr);
+int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr);
 int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 8b4f139..89531b4 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -788,8 +788,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	 */
 	if (!mmc_host_is_spi(host) && rocr &&
 	   ((*rocr & 0x41000000) == 0x41000000)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
-					pocr);
+		err = mmc_set_uhs_voltage(host, pocr);
 		if (err == -EAGAIN) {
 			retries--;
 			goto try_again;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 261c886..a64a870 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -642,8 +642,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * to make sure which speed mode should work.
 	 */
 	if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
-		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
-					ocr_card);
+		err = mmc_set_uhs_voltage(host, ocr_card);
 		if (err == -EAGAIN) {
 			mmc_sdio_resend_if_cond(host, card);
 			retries--;
-- 
1.9.1

