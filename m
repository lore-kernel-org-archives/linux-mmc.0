From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/2] mmc: sdio: Keep card runtime resumed while adding function devices
Date: Fri,  9 Jun 2017 15:27:18 +0300
Message-ID: <1497011238-9573-3-git-send-email-adrian.hunter@intel.com>
References: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18608 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbdFIMdU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Jun 2017 08:33:20 -0400
In-Reply-To: <1497011238-9573-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Drivers core will runtime suspend a device with no driver. That means the
SDIO card will be runtime suspended as soon as it is added. It is then
runtime resumed to add each function. That is entirely pointless, so add
pm runtime get/put to keep the SDIO card runtime resumed until the function
devices have been added.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sdio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f077fc8219d0..cc43687ca241 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1104,6 +1104,12 @@ int mmc_attach_sdio(struct mmc_host *host)
 	 */
 	if (host->caps & MMC_CAP_POWER_OFF_CARD) {
 		/*
+		 * Do not allow runtime suspend until after SDIO function
+		 * devices are added.
+		 */
+		pm_runtime_get_noresume(&card->dev);
+
+		/*
 		 * Let runtime PM core know our card is active
 		 */
 		err = pm_runtime_set_active(&card->dev);
@@ -1155,6 +1161,9 @@ int mmc_attach_sdio(struct mmc_host *host)
 			goto remove_added;
 	}
 
+	if (host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put(&card->dev);
+
 	mmc_claim_host(host);
 	return 0;
 
@@ -1164,7 +1173,9 @@ int mmc_attach_sdio(struct mmc_host *host)
 remove_added:
 	/*
 	 * The devices are being deleted so it is not necessary to disable
-	 * runtime PM.
+	 * runtime PM. Similarly we also don't pm_runtime_put() the SDIO card
+	 * because it needs to be active to remove any function devices that
+	 * were probed, and after that it gets deleted.
 	 */
 	mmc_sdio_remove(host);
 	mmc_claim_host(host);
-- 
1.9.1

