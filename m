From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/2] mmc: core: Detect card removal on I/O error
Date: Thu, 19 Jan 2012 17:39:51 +0100
Message-ID: <1326991191-12472-3-git-send-email-ulf.hansson@stericsson.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:56722 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755317Ab2ASQkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 11:40:18 -0500
In-Reply-To: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

A card can be "slowly" removed which means that when a
card detect irq has triggered a scheduled detect work to
handle the card removal, the card will still be present
in the card slot and thus not removed by the rescan sequence.

To prevent further I/O request for these lingering "removed"
cards, use MMC_CAP2_DETECT_ON_ERR which will check if card is
still present from mmc_detect_card_removed function.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c  |    3 ++-
 include/linux/mmc/host.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 265dfd8..e5d1c3b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2084,7 +2084,8 @@ int mmc_detect_card_removed(struct mmc_host *host)
 	 * The card will be considered unchanged unless we have been asked to
 	 * detect a change or host requires polling to provide card detection.
 	 */
-	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
+	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
+	    && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
 		return mmc_card_removed(card);
 
 	ret = mmc_card_removed(card);
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

