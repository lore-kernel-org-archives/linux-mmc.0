From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdio: Keep card runtime resumed while adding function devices
Date: Thu, 18 May 2017 14:42:02 +0300
Message-ID: <1495107722-13444-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:27501 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932765AbdERLry (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 18 May 2017 07:47:54 -0400
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
 drivers/mmc/core/sdio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index fae732c870a9..97bedde0610c 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1110,6 +1110,8 @@ int mmc_attach_sdio(struct mmc_host *host)
 		if (err)
 			goto remove;
 
+		pm_runtime_get_noresume(&card->dev);
+
 		/*
 		 * Enable runtime PM for this card
 		 */
@@ -1129,7 +1131,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 	for (i = 0; i < funcs; i++, card->sdio_funcs++) {
 		err = sdio_init_func(host->card, i + 1);
 		if (err)
-			goto remove;
+			goto remove_get;
 
 		/*
 		 * Enable Runtime PM for this func (if supported)
@@ -1156,6 +1158,10 @@ int mmc_attach_sdio(struct mmc_host *host)
 	}
 
 	mmc_claim_host(host);
+
+	if (host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put(&card->dev);
+
 	return 0;
 
 
@@ -1163,6 +1169,9 @@ int mmc_attach_sdio(struct mmc_host *host)
 	/* Remove without lock if the device has been added. */
 	mmc_sdio_remove(host);
 	mmc_claim_host(host);
+remove_get:
+	if (host->caps & MMC_CAP_POWER_OFF_CARD)
+		pm_runtime_put(&card->dev);
 remove:
 	/* And with lock if it hasn't been added. */
 	mmc_release_host(host);
-- 
1.9.1

