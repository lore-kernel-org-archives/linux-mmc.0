From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 1/2] mmc: core: Simplify and fix for SD switch processing
Date: Tue, 3 Jul 2012 14:16:11 +0800
Message-ID: <1341296172-10645-2-git-send-email-aaron.lu@amd.com>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:24142 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753900Ab2GCGQp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 02:16:45 -0400
In-Reply-To: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

In mmc_read_switch, just do a one time mode 0 switch command to get the
support bits information, no need to do multiple times as the support
bits do not change with different arguments.

And no need to check current limit support bits, as these bits is
fixed according to the signal voltage. If the signal voltage is 1.8V,
the support bits would be 0xf and if the signal voltage is 3.3V, the
support bits would be 0x01. We will check host's ability to set the
current limit.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/core/sd.c | 94 ++++++++++++---------------------------------------
 1 file changed, 22 insertions(+), 72 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index b0b9e37..ae72d6e 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -290,8 +290,12 @@ static int mmc_read_switch(struct mmc_card *card)
 		return -ENOMEM;
 	}
 
-	/* Find out the supported Bus Speed Modes. */
-	err = mmc_sd_switch(card, 0, 0, 1, status);
+	/*
+	 * Find out the card's support bits with a mode 0 operation.
+	 * The argument does not matter, as the support bits do not
+	 * change with the arguments.
+	 */
+	err = mmc_sd_switch(card, 0, 0, 0, status);
 	if (err) {
 		/*
 		 * If the host or the card can't do the switch,
@@ -312,46 +316,8 @@ static int mmc_read_switch(struct mmc_card *card)
 
 	if (card->scr.sda_spec3) {
 		card->sw_caps.sd3_bus_mode = status[13];
-
-		/* Find out Driver Strengths supported by the card */
-		err = mmc_sd_switch(card, 0, 2, 1, status);
-		if (err) {
-			/*
-			 * If the host or the card can't do the switch,
-			 * fail more gracefully.
-			 */
-			if (err != -EINVAL && err != -ENOSYS && err != -EFAULT)
-				goto out;
-
-			pr_warning("%s: problem reading "
-				"Driver Strength.\n",
-				mmc_hostname(card->host));
-			err = 0;
-
-			goto out;
-		}
-
+		/* Driver Strengths supported by the card */
 		card->sw_caps.sd3_drv_type = status[9];
-
-		/* Find out Current Limits supported by the card */
-		err = mmc_sd_switch(card, 0, 3, 1, status);
-		if (err) {
-			/*
-			 * If the host or the card can't do the switch,
-			 * fail more gracefully.
-			 */
-			if (err != -EINVAL && err != -ENOSYS && err != -EFAULT)
-				goto out;
-
-			pr_warning("%s: problem reading "
-				"Current Limit.\n",
-				mmc_hostname(card->host));
-			err = 0;
-
-			goto out;
-		}
-
-		card->sw_caps.sd3_curr_limit = status[7];
 	}
 
 out:
@@ -560,41 +526,24 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 	 * Current limit switch is only defined for SDR50, SDR104, and DDR50
 	 * bus speed modes. For other bus speed modes, we do not change the
 	 * current limit.
+	 * We only check host's capability here, if we set a limit that is
+	 * higher than the card's maximum current, the card will be using its
+	 * maximum current, e.g. if the card's maximum current is 300ma, and
+	 * when we set current limit to 200ma, the card will draw 200ma, and
+	 * when we set current limit to 400/600/800ma, the card will draw its
+	 * maximum 300ma from the host.
 	 */
 	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
 	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
 	    (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
-		if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
-			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_800)
-				current_limit = SD_SET_CURRENT_LIMIT_800;
-			else if (card->sw_caps.sd3_curr_limit &
-					SD_MAX_CURRENT_600)
-				current_limit = SD_SET_CURRENT_LIMIT_600;
-			else if (card->sw_caps.sd3_curr_limit &
-					SD_MAX_CURRENT_400)
-				current_limit = SD_SET_CURRENT_LIMIT_400;
-			else if (card->sw_caps.sd3_curr_limit &
-					SD_MAX_CURRENT_200)
-				current_limit = SD_SET_CURRENT_LIMIT_200;
-		} else if (card->host->caps & MMC_CAP_MAX_CURRENT_600) {
-			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_600)
-				current_limit = SD_SET_CURRENT_LIMIT_600;
-			else if (card->sw_caps.sd3_curr_limit &
-					SD_MAX_CURRENT_400)
-				current_limit = SD_SET_CURRENT_LIMIT_400;
-			else if (card->sw_caps.sd3_curr_limit &
-					SD_MAX_CURRENT_200)
-				current_limit = SD_SET_CURRENT_LIMIT_200;
-		} else if (card->host->caps & MMC_CAP_MAX_CURRENT_400) {
-			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_400)
-				current_limit = SD_SET_CURRENT_LIMIT_400;
-			else if (card->sw_caps.sd3_curr_limit &
-					SD_MAX_CURRENT_200)
-				current_limit = SD_SET_CURRENT_LIMIT_200;
-		} else if (card->host->caps & MMC_CAP_MAX_CURRENT_200) {
-			if (card->sw_caps.sd3_curr_limit & SD_MAX_CURRENT_200)
-				current_limit = SD_SET_CURRENT_LIMIT_200;
-		}
+		if (card->host->caps & MMC_CAP_MAX_CURRENT_800)
+			current_limit = SD_SET_CURRENT_LIMIT_800;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_600)
+			current_limit = SD_SET_CURRENT_LIMIT_600;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_400)
+			current_limit = SD_SET_CURRENT_LIMIT_400;
+		else if (card->host->caps & MMC_CAP_MAX_CURRENT_200)
+			current_limit = SD_SET_CURRENT_LIMIT_200;
 	}
 
 	if (current_limit != SD_SET_CURRENT_NO_CHANGE) {
@@ -607,6 +556,7 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
 				mmc_hostname(card->host));
 
 	}
+
 	return 0;
 }
 
-- 
1.7.11.1.3.g4c8a9db


