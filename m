From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/12] mmc: core: Add 'card' to drive strength selection callback
Date: Thu,  5 Feb 2015 15:13:41 +0200
Message-ID: <1423142029-22521-5-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58677 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757224AbbBENSD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:03 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>

In preparation for supporting also eMMC drive strength,
add the 'card' as a parameter so that the callback can
distinguish different types of cards if necessary.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd.c    | 2 +-
 drivers/mmc/core/sdio.c  | 2 +-
 include/linux/mmc/host.h | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index fab83e8..dba1acf 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -411,7 +411,7 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	 * return what is possible given the options
 	 */
 	mmc_host_clk_hold(card->host);
-	drive_strength = card->host->ops->select_drive_strength(
+	drive_strength = card->host->ops->select_drive_strength(card,
 		card->sw_caps.uhs_max_dtr,
 		host_drv_type, card_drv_type, &drv_type);
 	mmc_host_clk_release(card->host);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 76e4dde..de92ffe 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -424,7 +424,7 @@ static void sdio_select_driver_type(struct mmc_card *card)
 	 * information and let the hardware specific code
 	 * return what is possible given the options
 	 */
-	drive_strength = card->host->ops->select_drive_strength(
+	drive_strength = card->host->ops->select_drive_strength(card,
 		card->sw_caps.uhs_max_dtr,
 		host_drv_type, card_drv_type, &drv_type);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d984c55..967e7db 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -138,7 +138,8 @@ struct mmc_host_ops {
 
 	/* Prepare HS400 target operating frequency depending host driver */
 	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
-	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv,
+	int	(*select_drive_strength)(struct mmc_card *card,
+					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
 	void	(*hw_reset)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
-- 
1.9.1

