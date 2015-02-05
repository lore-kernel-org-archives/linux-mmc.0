From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 06/12] mmc: core: Record card drive strength
Date: Thu,  5 Feb 2015 15:13:43 +0200
Message-ID: <1423142029-22521-7-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbbBENSD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:03 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

In preparation for adding drive strength support
for eMMC, add drive_strength to struct mmc_card
to record the card drive strength for UHS-I modes
and HS200 / HS400. For eMMC this will be needed
when switching between HS200 and HS400.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd.c    | 3 +++
 drivers/mmc/core/sdio.c  | 3 +++
 include/linux/mmc/card.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index e1a98b1..2fdb41b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -389,6 +389,8 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	int card_drv_type, drive_strength, drv_type;
 	int err;
 
+	card->drive_strength = 0;
+
 	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
 	drive_strength = mmc_select_drive_strength(card,
@@ -404,6 +406,7 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 				mmc_hostname(card->host));
 			return 0;
 		}
+		card->drive_strength = drive_strength;
 	}
 
 	if (drv_type)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8cc1793..fa81ba53 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -403,6 +403,8 @@ static void sdio_select_driver_type(struct mmc_card *card)
 	unsigned char card_strength;
 	int err;
 
+	card->drive_strength = 0;
+
 	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
 	drive_strength = mmc_select_drive_strength(card,
@@ -424,6 +426,7 @@ static void sdio_select_driver_type(struct mmc_card *card)
 				       card_strength, NULL);
 		if (err)
 			return;
+		card->drive_strength = drive_strength;
 	}
 
 	if (drv_type)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index a6cf4c0..ad54861 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -305,6 +305,7 @@ struct mmc_card {
 
 	unsigned int		sd_bus_speed;	/* Bus Speed Mode set for the card */
 	unsigned int		mmc_avail_type;	/* supported device type by both host and card */
+	unsigned int		drive_strength;	/* for UHS-I, HS200 or HS400 */
 
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
-- 
1.9.1

