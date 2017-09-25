From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V1 2/2] mmc: sd: Fix signal voltage when there is no power cycle
Date: Mon, 25 Sep 2017 11:29:04 +0300
Message-ID: <1506328144-13666-3-git-send-email-adrian.hunter@intel.com>
References: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:29782 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932364AbdIYIfv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Sep 2017 04:35:51 -0400
In-Reply-To: <1506328144-13666-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Zhoujie Wu <zjwu@marvell.com>

Some boards have SD card connectors where the power rail cannot be switched
off by the driver. However there are various circumstances when a card
might be re-initialized, such as after system resume, warm re-boot, or
error handling. However, a UHS card will continue to use 1.8V signaling
unless it is power cycled.

If the card has not been power cycled, it may still be using 1.8V
signaling. According to the SD spec., the Bus Speed Mode (function group 1)
bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
they can be used to determine if the card has already switched to 1.8V
signaling. Detect that situation and try to initialize a UHS-I (1.8V)
transfer mode.

Tested with the following cards:
  Transcend 4GB High Speed
  Kingston 64GB SDR104
  Lexar by Micron HIGH-PERFORMANCE 300x 16GB DDR50
  SanDisk Ultra 8GB DDR50
  Transcend Ultimate 600x 16GB SDR104
  Transcend Premium 300x 64GB SDR104
  Lexar by Micron Professional 1000x 32GB UHS-II SDR104
  SanDisk Extreme Pro 16GB SDR104

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Zhoujie Wu <zjwu@marvell.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/sd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 2036b2b4835c..45bf78f32716 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -908,6 +908,18 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
 	return max_dtr;
 }
 
+static bool mmc_sd_card_using_v18(struct mmc_card *card)
+{
+	/*
+	 * According to the SD spec., the Bus Speed Mode (function group 1) bits
+	 * 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
+	 * they can be used to determine if the card has already switched to
+	 * 1.8V signaling.
+	 */
+	return card->sw_caps.sd3_bus_mode &
+	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
+}
+
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -921,9 +933,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr = 0;
+	bool v18_fixup_failed = false;
 
 	WARN_ON(!host->claimed);
-
+retry:
 	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
 	if (err)
 		return err;
@@ -989,6 +1002,36 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto free_card;
 
+	/*
+	 * If the card has not been power cycled, it may still be using 1.8V
+	 * signaling. Detect that situation and try to initialize a UHS-I (1.8V)
+	 * transfer mode.
+	 */
+	if (!v18_fixup_failed && !mmc_host_is_spi(host) && mmc_host_uhs(host) &&
+	    mmc_sd_card_using_v18(card) &&
+	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
+		/*
+		 * Re-read switch information in case it has changed since
+		 * oldcard was initialized.
+		 */
+		if (oldcard) {
+			err = mmc_read_switch(card);
+			if (err)
+				goto free_card;
+		}
+		if (mmc_sd_card_using_v18(card)) {
+			if (mmc_host_set_uhs_voltage(host) ||
+			    mmc_sd_init_uhs_card(card)) {
+				v18_fixup_failed = true;
+				mmc_power_cycle(host, ocr);
+				if (!oldcard)
+					mmc_remove_card(card);
+				goto retry;
+			}
+			goto done;
+		}
+	}
+
 	/* Initialization sequence for UHS-I cards */
 	if (rocr & SD_ROCR_S18A) {
 		err = mmc_sd_init_uhs_card(card);
@@ -1021,7 +1064,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 		}
 	}
-
+done:
 	host->card = card;
 	return 0;
 
-- 
1.9.1

