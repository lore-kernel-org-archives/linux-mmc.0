From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/12] mmc: core: Allow card drive strength to be different to host
Date: Thu,  5 Feb 2015 15:13:39 +0200
Message-ID: <1423142029-22521-3-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037AbbBENSA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:00 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

Initialization of UHS-I modes for SD and SDIO cards
employs a callback to allow the host driver to
choose a drive strength value. Currently that
assumes the card drive strength and host driver
type must be the same value. Change to let the
callback make that decision and return both the
card drive strength and host driver type.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd.c    | 33 +++++++++++++--------------------
 drivers/mmc/core/sdio.c  | 43 ++++++++++++++++++-------------------------
 include/linux/mmc/host.h |  3 ++-
 3 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ad4d43e..cbee29a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -388,18 +388,9 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 {
 	int host_drv_type = SD_DRIVER_TYPE_B;
 	int card_drv_type = SD_DRIVER_TYPE_B;
-	int drive_strength;
+	int drive_strength, drv_type;
 	int err;
 
-	/*
-	 * If the host doesn't support any of the Driver Types A,C or D,
-	 * or there is no board specific handler then default Driver
-	 * Type B is used.
-	 */
-	if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A | MMC_CAP_DRIVER_TYPE_C
-	    | MMC_CAP_DRIVER_TYPE_D)))
-		return 0;
-
 	if (!card->host->ops->select_drive_strength)
 		return 0;
 
@@ -430,20 +421,22 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	mmc_host_clk_hold(card->host);
 	drive_strength = card->host->ops->select_drive_strength(
 		card->sw_caps.uhs_max_dtr,
-		host_drv_type, card_drv_type);
+		host_drv_type, card_drv_type, &drv_type);
 	mmc_host_clk_release(card->host);
 
-	err = mmc_sd_switch(card, 1, 2, drive_strength, status);
-	if (err)
-		return err;
-
-	if ((status[15] & 0xF) != drive_strength) {
-		pr_warn("%s: Problem setting drive strength!\n",
-			mmc_hostname(card->host));
-		return 0;
+	if (drive_strength) {
+		err = mmc_sd_switch(card, 1, 2, drive_strength, status);
+		if (err)
+			return err;
+		if ((status[15] & 0xF) != drive_strength) {
+			pr_warn("%s: Problem setting drive strength!\n",
+				mmc_hostname(card->host));
+			return 0;
+		}
 	}
 
-	mmc_set_driver_type(card->host, drive_strength);
+	if (drv_type)
+		mmc_set_driver_type(card->host, drv_type);
 
 	return 0;
 }
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ce6cc47..d7309ab 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -401,21 +401,10 @@ static void sdio_select_driver_type(struct mmc_card *card)
 {
 	int host_drv_type = SD_DRIVER_TYPE_B;
 	int card_drv_type = SD_DRIVER_TYPE_B;
-	int drive_strength;
+	int drive_strength, drv_type;
 	unsigned char card_strength;
 	int err;
 
-	/*
-	 * If the host doesn't support any of the Driver Types A,C or D,
-	 * or there is no board specific handler then default Driver
-	 * Type B is used.
-	 */
-	if (!(card->host->caps &
-		(MMC_CAP_DRIVER_TYPE_A |
-		 MMC_CAP_DRIVER_TYPE_C |
-		 MMC_CAP_DRIVER_TYPE_D)))
-		return;
-
 	if (!card->host->ops->select_drive_strength)
 		return;
 
@@ -445,23 +434,27 @@ static void sdio_select_driver_type(struct mmc_card *card)
 	 */
 	drive_strength = card->host->ops->select_drive_strength(
 		card->sw_caps.uhs_max_dtr,
-		host_drv_type, card_drv_type);
+		host_drv_type, card_drv_type, &drv_type);
 
-	/* if error just use default for drive strength B */
-	err = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_DRIVE_STRENGTH, 0,
-		&card_strength);
-	if (err)
-		return;
+	if (drive_strength) {
+		/* if error just use default for drive strength B */
+		err = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_DRIVE_STRENGTH, 0,
+				       &card_strength);
+		if (err)
+			return;
 
-	card_strength &= ~(SDIO_DRIVE_DTSx_MASK<<SDIO_DRIVE_DTSx_SHIFT);
-	card_strength |= host_drive_to_sdio_drive(drive_strength);
+		card_strength &= ~(SDIO_DRIVE_DTSx_MASK<<SDIO_DRIVE_DTSx_SHIFT);
+		card_strength |= host_drive_to_sdio_drive(drive_strength);
 
-	err = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_DRIVE_STRENGTH,
-		card_strength, NULL);
+		/* if error default to drive strength B */
+		err = mmc_io_rw_direct(card, 1, 0, SDIO_CCCR_DRIVE_STRENGTH,
+				       card_strength, NULL);
+		if (err)
+			return;
+	}
 
-	/* if error default to drive strength B */
-	if (!err)
-		mmc_set_driver_type(card->host, drive_strength);
+	if (drv_type)
+		mmc_set_driver_type(card->host, drv_type);
 }
 
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index e9a7470..d984c55 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -138,7 +138,8 @@ struct mmc_host_ops {
 
 	/* Prepare HS400 target operating frequency depending host driver */
 	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
-	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
+	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv,
+					 int card_drv, int *drv_type);
 	void	(*hw_reset)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
 
-- 
1.9.1

