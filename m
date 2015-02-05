From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/12] mmc: core: Factor out common code in drive strength selection
Date: Thu,  5 Feb 2015 15:13:42 +0200
Message-ID: <1423142029-22521-6-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58011 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757391AbbBENSD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:03 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

Make a new function out of common code used for drive
strength selection.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h |  2 ++
 drivers/mmc/core/sd.c   | 27 +++------------------------
 drivers/mmc/core/sdio.c | 25 +++----------------------
 4 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index dbc40c5..373a1cf 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1634,6 +1634,44 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
 	mmc_host_clk_release(host);
 }
 
+int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
+			      int card_drv_type, int *drv_type)
+{
+	struct mmc_host *host = card->host;
+	int host_drv_type = SD_DRIVER_TYPE_B;
+	int drive_strength;
+
+	*drv_type = 0;
+
+	if (!host->ops->select_drive_strength)
+		return 0;
+
+	/* Use SD definition of driver strength for hosts */
+	if (host->caps & MMC_CAP_DRIVER_TYPE_A)
+		host_drv_type |= SD_DRIVER_TYPE_A;
+
+	if (host->caps & MMC_CAP_DRIVER_TYPE_C)
+		host_drv_type |= SD_DRIVER_TYPE_C;
+
+	if (host->caps & MMC_CAP_DRIVER_TYPE_D)
+		host_drv_type |= SD_DRIVER_TYPE_D;
+
+	/*
+	 * The drive strength that the hardware can support
+	 * depends on the board design.  Pass the appropriate
+	 * information and let the hardware specific code
+	 * return what is possible given the options
+	 */
+	mmc_host_clk_hold(host);
+	drive_strength = host->ops->select_drive_strength(card, max_dtr,
+							  host_drv_type,
+							  card_drv_type,
+							  drv_type);
+	mmc_host_clk_release(host);
+
+	return drive_strength;
+}
+
 /*
  * Apply power to the MMC stack.  This is a two-stage process.
  * First, we enable power to the card without the clock running.
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index e6f2de7..1a22a82 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -50,6 +50,8 @@ int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr);
 int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
+int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
+			      int card_drv_type, int *drv_type);
 void mmc_power_up(struct mmc_host *host, u32 ocr);
 void mmc_power_off(struct mmc_host *host);
 void mmc_power_cycle(struct mmc_host *host, u32 ocr);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index dba1acf..e1a98b1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -386,35 +386,14 @@ out:
 
 static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 {
-	int host_drv_type = SD_DRIVER_TYPE_B;
 	int card_drv_type, drive_strength, drv_type;
 	int err;
 
-	if (!card->host->ops->select_drive_strength)
-		return 0;
-
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A)
-		host_drv_type |= SD_DRIVER_TYPE_A;
-
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_C)
-		host_drv_type |= SD_DRIVER_TYPE_C;
-
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_D)
-		host_drv_type |= SD_DRIVER_TYPE_D;
-
 	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
-	/*
-	 * The drive strength that the hardware can support
-	 * depends on the board design.  Pass the appropriate
-	 * information and let the hardware specific code
-	 * return what is possible given the options
-	 */
-	mmc_host_clk_hold(card->host);
-	drive_strength = card->host->ops->select_drive_strength(card,
-		card->sw_caps.uhs_max_dtr,
-		host_drv_type, card_drv_type, &drv_type);
-	mmc_host_clk_release(card->host);
+	drive_strength = mmc_select_drive_strength(card,
+						   card->sw_caps.uhs_max_dtr,
+						   card_drv_type, &drv_type);
 
 	if (drive_strength) {
 		err = mmc_sd_switch(card, 1, 2, drive_strength, status);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index de92ffe..8cc1793 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -399,34 +399,15 @@ static unsigned char host_drive_to_sdio_drive(int host_strength)
 
 static void sdio_select_driver_type(struct mmc_card *card)
 {
-	int host_drv_type = SD_DRIVER_TYPE_B;
 	int card_drv_type, drive_strength, drv_type;
 	unsigned char card_strength;
 	int err;
 
-	if (!card->host->ops->select_drive_strength)
-		return;
-
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A)
-		host_drv_type |= SD_DRIVER_TYPE_A;
-
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_C)
-		host_drv_type |= SD_DRIVER_TYPE_C;
-
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_D)
-		host_drv_type |= SD_DRIVER_TYPE_D;
-
 	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
-	/*
-	 * The drive strength that the hardware can support
-	 * depends on the board design.  Pass the appropriate
-	 * information and let the hardware specific code
-	 * return what is possible given the options
-	 */
-	drive_strength = card->host->ops->select_drive_strength(card,
-		card->sw_caps.uhs_max_dtr,
-		host_drv_type, card_drv_type, &drv_type);
+	drive_strength = mmc_select_drive_strength(card,
+						   card->sw_caps.uhs_max_dtr,
+						   card_drv_type, &drv_type);
 
 	if (drive_strength) {
 		/* if error just use default for drive strength B */
-- 
1.9.1

