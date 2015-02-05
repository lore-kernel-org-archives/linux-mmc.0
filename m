From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/12] mmc: core: Simplify card drive strength mask
Date: Thu,  5 Feb 2015 15:13:40 +0200
Message-ID: <1423142029-22521-4-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037AbbBENSB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:01 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

Card drive strength selection uses a callback to
which a mask of supported drive strengths is passed.
Currently, the bits are checked against the values
in the SD specifications. That is not necessary
because the callback will anyway match the mask
against a valid value. Simplify by taking the mask
as is but still ensuring that the default mandatory
value (type B) is always supported.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd.c   | 12 ++----------
 drivers/mmc/core/sdio.c | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cbee29a..fab83e8 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -387,8 +387,7 @@ out:
 static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 {
 	int host_drv_type = SD_DRIVER_TYPE_B;
-	int card_drv_type = SD_DRIVER_TYPE_B;
-	int drive_strength, drv_type;
+	int card_drv_type, drive_strength, drv_type;
 	int err;
 
 	if (!card->host->ops->select_drive_strength)
@@ -403,14 +402,7 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	if (card->host->caps & MMC_CAP_DRIVER_TYPE_D)
 		host_drv_type |= SD_DRIVER_TYPE_D;
 
-	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
-		card_drv_type |= SD_DRIVER_TYPE_A;
-
-	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
-		card_drv_type |= SD_DRIVER_TYPE_C;
-
-	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_D)
-		card_drv_type |= SD_DRIVER_TYPE_D;
+	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
 	/*
 	 * The drive strength that the hardware can support
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index d7309ab..76e4dde 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -400,8 +400,7 @@ static unsigned char host_drive_to_sdio_drive(int host_strength)
 static void sdio_select_driver_type(struct mmc_card *card)
 {
 	int host_drv_type = SD_DRIVER_TYPE_B;
-	int card_drv_type = SD_DRIVER_TYPE_B;
-	int drive_strength, drv_type;
+	int card_drv_type, drive_strength, drv_type;
 	unsigned char card_strength;
 	int err;
 
@@ -417,14 +416,7 @@ static void sdio_select_driver_type(struct mmc_card *card)
 	if (card->host->caps & MMC_CAP_DRIVER_TYPE_D)
 		host_drv_type |= SD_DRIVER_TYPE_D;
 
-	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
-		card_drv_type |= SD_DRIVER_TYPE_A;
-
-	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
-		card_drv_type |= SD_DRIVER_TYPE_C;
-
-	if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_D)
-		card_drv_type |= SD_DRIVER_TYPE_D;
+	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
 	/*
 	 * The drive strength that the hardware can support
-- 
1.9.1

