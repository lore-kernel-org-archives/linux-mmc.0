From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/4] mmc: sdhci: Tuning should not change max_blk_count
Date: Fri,  5 Dec 2014 19:25:28 +0200
Message-ID: <1417800331-15248-2-git-send-email-adrian.hunter@intel.com>
References: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49598 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaLER1N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 12:27:13 -0500
In-Reply-To: <1417800331-15248-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

Re-tuning requires that the maximum data length
is limited to 4MiB. The code currently changes
max_blk_count in an attempt to achieve that.
This is wrong because max_blk_count is a different
limit, but it is also un-necessary because
max_req_size is 512KiB anyway. Consequently, the
changes to max_blk_count are removed and the
comment for max_req_size adjusted accordingly.
The comment is also tweaked to show that the 512KiB
limit is a SDMA limit not an ADMA limit.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 73de62a..b3d68e0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -259,8 +259,6 @@ static void sdhci_reinit(struct sdhci_host *host)
 
 		del_timer_sync(&host->tuning_timer);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		host->mmc->max_blk_count =
-			(host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 	}
 	sdhci_enable_card_detection(host);
 }
@@ -2048,8 +2046,6 @@ out:
 		host->flags |= SDHCI_USING_RETUNING_TIMER;
 		mod_timer(&host->tuning_timer, jiffies +
 			host->tuning_count * HZ);
-		/* Tuning mode 1 limits the maximum data length to 4MB */
-		mmc->max_blk_count = (4 * 1024 * 1024) / mmc->max_blk_size;
 	} else if (host->flags & SDHCI_USING_RETUNING_TIMER) {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		/* Reload the new initial value for timer */
@@ -3263,8 +3259,9 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->max_segs = SDHCI_MAX_SEGS;
 
 	/*
-	 * Maximum number of sectors in one transfer. Limited by DMA boundary
-	 * size (512KiB).
+	 * Maximum number of sectors in one transfer. Limited by SDMA boundary
+	 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
+	 * is less anyway.
 	 */
 	mmc->max_req_size = 524288;
 
-- 
1.9.1

