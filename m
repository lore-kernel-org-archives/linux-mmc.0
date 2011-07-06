From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH V2] mmc: sd.c Set Non Default Drive Strength via platform
Date: Wed, 6 Jul 2011 08:51:32 -0700
Message-ID: <614DD9DA-4F3C-4650-8412-6CC900537836@marvell.com>
References: <2728818A-C26F-4BF7-8115-A3A37810AE34@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42194 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753245Ab1GFPvg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jul 2011 11:51:36 -0400
In-Reply-To: <2728818A-C26F-4BF7-8115-A3A37810AE34@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arindam Nath <arindam.nath@amd.com>


V2
--
Include host.h change for callback to select_drive_strength

V1
--
Non default Drive Strength cannot be set automatically.
It is a function of the board design and only if there
is a specific platform handler can it be set.  The platform
handler needs to take into account the board design.  Pass
to the platform code the necessary information.

For example:  The card and host controller may indicate
they support HIGH and LOW drive strength.  There is no way
to know what should be chosen without specific board knowledge.
Setting HIGH may lead to reflections and setting LOW may not
be sufficient.
There is no mechanism (like ethernet duplex or speed pulses)
to determine what should be done automatically.

If no platform handler is defined -- use the default value.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/sd.c    |   68 ++++++++++++++++++++++++++-------------------
 include/linux/mmc/host.h |    1 +
 2 files changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index ff27741..633975f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -409,52 +409,62 @@ out:
 
 static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 {
-	int host_drv_type = 0, card_drv_type = 0;
+	int host_drv_type = SD_DRIVER_TYPE_B;
+	int card_drv_type = SD_DRIVER_TYPE_B;
+	int drive_strength;
 	int err;
 
 	/*
 	 * If the host doesn't support any of the Driver Types A,C or D,
-	 * default Driver Type B is used.
+	 * or there is no board specific handler then default Driver
+	 * Type B is used.
 	 */
 	if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A | MMC_CAP_DRIVER_TYPE_C
 	    | MMC_CAP_DRIVER_TYPE_D)))
 		return 0;
 
-	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
-		host_drv_type = MMC_SET_DRIVER_TYPE_A;
-		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
-			card_drv_type = MMC_SET_DRIVER_TYPE_A;
-		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_B)
-			card_drv_type = MMC_SET_DRIVER_TYPE_B;
-		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
-			card_drv_type = MMC_SET_DRIVER_TYPE_C;
-	} else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
-		host_drv_type = MMC_SET_DRIVER_TYPE_C;
-		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
-			card_drv_type = MMC_SET_DRIVER_TYPE_C;
-	} else if (!(card->host->caps & MMC_CAP_DRIVER_TYPE_D)) {
-		/*
-		 * If we are here, that means only the default driver type
-		 * B is supported by the host.
-		 */
-		host_drv_type = MMC_SET_DRIVER_TYPE_B;
-		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_B)
-			card_drv_type = MMC_SET_DRIVER_TYPE_B;
-		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
-			card_drv_type = MMC_SET_DRIVER_TYPE_C;
-	}
+	if (!card->host->ops->select_drive_strength)
+		return 0;
+
+	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A)
+		host_drv_type |= SD_DRIVER_TYPE_A;
+
+	if (card->host->caps & MMC_CAP_DRIVER_TYPE_C)
+		host_drv_type |= SD_DRIVER_TYPE_C;
+
+	if (card->host->caps & MMC_CAP_DRIVER_TYPE_D)
+		host_drv_type |= SD_DRIVER_TYPE_D;
+
+	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
+		card_drv_type |= SD_DRIVER_TYPE_A;
+
+	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
+		card_drv_type |= SD_DRIVER_TYPE_C;
+
+	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_D)
+		card_drv_type |= SD_DRIVER_TYPE_D;
+
+	/*
+	 * The drive strength that the hardware can support
+	 * depends on the board design.  Pass the appropriate
+	 * information and let the hardware specific code
+	 * return what is possible given the options
+	 */
+	drive_strength = card->host->ops->select_drive_strength(
+		card->sw_caps.uhs_max_dtr,
+		host_drv_type, card_drv_type);
 
-	err = mmc_sd_switch(card, 1, 2, card_drv_type, status);
+	err = mmc_sd_switch(card, 1, 2, drive_strength, status);
 	if (err)
 		return err;
 
-	if ((status[15] & 0xF) != card_drv_type) {
-		printk(KERN_WARNING "%s: Problem setting driver strength!\n",
+	if ((status[15] & 0xF) != drive_strength) {
+		printk(KERN_WARNING "%s: Problem setting drive strength!\n",
 			mmc_hostname(card->host));
 		return 0;
 	}
 
-	mmc_set_driver_type(card->host, host_drv_type);
+	mmc_set_driver_type(card->host, drive_strength);
 
 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ac3fbac..4913f6c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -139,6 +139,7 @@ struct mmc_host_ops {
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 	int	(*execute_tuning)(struct mmc_host *host);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
+	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
 };
 
 struct mmc_card;
-- 
1.7.0.4


