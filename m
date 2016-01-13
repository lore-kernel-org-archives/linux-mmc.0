From: Carlo Caione <carlo@caione.org>
Subject: [PATCH] mmc: core: Enable tuning according to the actual timing
Date: Wed, 13 Jan 2016 09:36:55 +0100
Message-ID: <1452674215-21560-1-git-send-email-carlo@caione.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34376 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbcAMIhy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2016 03:37:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, weijuny@qti.qualcomm.com, 21cnbao@gmail.com, linux-mmc@vger.kernel.org, jh80.chung@samsung.com, baohuas@qti.qualcomm.com
Cc: Carlo Caione <carlo@endlessm.com>, stable@vger.kernel.org

From: Carlo Caione <carlo@endlessm.com>

While in sdhci_execute_tuning() the choice whether or not to enable the
tuning is done on the actual timing, in the mmc_sdio_init_uhs_card() the
check is done on the capability of the card.

This difference is causing some issues with some SDIO cards in DDR50
mode where the CDM19 is wrongly issued.

With this patch we modify the check in both
mmc_(sd|sdio)_init_uhs_card() functions to take the proper decision
only according to the actual timing specification.

Cc: stable@vger.kernel.org
Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/mmc/core/sd.c   | 8 ++++----
 drivers/mmc/core/sdio.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 141eaa9..967535d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -626,9 +626,9 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
 	 */
 	if (!mmc_host_is_spi(card->host) &&
-		(card->sd_bus_speed == UHS_SDR50_BUS_SPEED ||
-		 card->sd_bus_speed == UHS_DDR50_BUS_SPEED ||
-		 card->sd_bus_speed == UHS_SDR104_BUS_SPEED)) {
+		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
+		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
+		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
 		err = mmc_execute_tuning(card);
 
 		/*
@@ -638,7 +638,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 		 * difference between v3.00 and 3.01 spec means that CMD19
 		 * tuning is also available for DDR50 mode.
 		 */
-		if (err && card->sd_bus_speed == UHS_DDR50_BUS_SPEED) {
+		if (err && card->host->ios.timing == MMC_TIMING_UHS_DDR50) {
 			pr_warn("%s: ddr50 tuning failed\n",
 				mmc_hostname(card->host));
 			err = 0;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 16d838e..0444773 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -535,8 +535,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
 	 */
 	if (!mmc_host_is_spi(card->host) &&
-	    ((card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR50) ||
-	     (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)))
+	    ((card->host->ios.timing == MMC_TIMING_UHS_SDR50) ||
+	      (card->host->ios.timing == MMC_TIMING_UHS_SDR104)))
 		err = mmc_execute_tuning(card);
 out:
 	return err;
-- 
2.5.0

