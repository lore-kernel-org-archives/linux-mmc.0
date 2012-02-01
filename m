From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2] mmc: core: Detect card removal on I/O error
Date: Wed, 1 Feb 2012 14:48:20 +0100
Message-ID: <1328104100-1880-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:60415 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753024Ab2BAOPD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 09:15:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

To prevent I/O as soon as possible at card removal, a new
detect work is re-scheduled without a delay to let a rescan
remove the card device as soon a possible.

Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
"slowly" removed cards that a scheduled detect work did not
detect as removed. To prevent further I/O requests for these
lingering removed cards, check if card has been removed and then
schedule a detect work to properly remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---

Changes in v2:
	- Updated according to review comments.
	- Merging two patches for this feature into one.

---
 drivers/mmc/core/core.c  |   19 +++++++++++++++++--
 include/linux/mmc/host.h |    1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bec0bf2..26d3a66 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2077,18 +2077,33 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 int mmc_detect_card_removed(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
+	int ret;
 
 	WARN_ON(!host->claimed);
 	/*
 	 * The card will be considered unchanged unless we have been asked to
 	 * detect a change or host requires polling to provide card detection.
 	 */
-	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
+	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
+	    && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
 		return mmc_card_removed(card);
 
 	host->detect_change = 0;
 
-	return _mmc_detect_card_removed(host);
+	ret = mmc_card_removed(card);
+	if (!ret) {
+		ret = _mmc_detect_card_removed(host);
+		if (ret) {
+			/*
+			 * Schedule a detect work as soon as possible to let a
+			 * rescan handle the card removal.
+			 */
+			cancel_delayed_work(&host->detect);
+			mmc_detect_change(host, 0);
+		}
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(mmc_detect_card_removed);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index dd13e05..368a2b9 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -257,6 +257,7 @@ struct mmc_host {
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
+#define MMC_CAP2_DETECT_ON_ERR	(1 << 7)	/* On I/O err check card removal */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
-- 
1.7.5.4

