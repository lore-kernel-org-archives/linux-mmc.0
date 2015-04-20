From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V6 08/15] mmc: mmc: Hold re-tuning if the card is put to sleep
Date: Mon, 20 Apr 2015 15:09:49 +0300
Message-ID: <1429531796-21987-9-git-send-email-adrian.hunter@intel.com>
References: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27511 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882AbbDTMMv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Apr 2015 08:12:51 -0400
In-Reply-To: <1429531796-21987-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Currently "mmc sleep" is used before power off and
is not paired with waking up. Nevertheless hold
re-tuning.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f36c76f..daf9954 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/mmc.h>
 
 #include "core.h"
+#include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -1504,6 +1505,7 @@ static int mmc_can_sleep(struct mmc_card *card)
 	return (card && card->ext_csd.rev >= 3);
 }
 
+/* If necessary, callers must hold re-tuning */
 static int mmc_sleep(struct mmc_host *host)
 {
 	struct mmc_command cmd = {0};
@@ -1631,6 +1633,7 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 	int err = 0;
 	unsigned int notify_type = is_suspend ? EXT_CSD_POWER_OFF_SHORT :
 					EXT_CSD_POWER_OFF_LONG;
+	bool retune_release = false;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
@@ -1651,17 +1654,22 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		goto out;
 
 	if (mmc_can_poweroff_notify(host->card) &&
-		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
+		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend)) {
 		err = mmc_poweroff_notify(host->card, notify_type);
-	else if (mmc_can_sleep(host->card))
+	} else if (mmc_can_sleep(host->card)) {
+		mmc_retune_hold(host);
 		err = mmc_sleep(host);
-	else if (!mmc_host_is_spi(host))
+	} else if (!mmc_host_is_spi(host)) {
 		err = mmc_deselect_cards(host);
+	}
 
 	if (!err) {
 		mmc_power_off(host);
 		mmc_card_set_suspended(host->card);
 	}
+
+	if (retune_release)
+		mmc_retune_release(host);
 out:
 	mmc_release_host(host);
 	return err;
-- 
1.9.1

