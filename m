From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 1/2] mmc: core: Prevent I/O as soon as possible at card removal
Date: Thu, 19 Jan 2012 17:39:50 +0100
Message-ID: <1326991191-12472-2-git-send-email-ulf.hansson@stericsson.com>
References: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:45834 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755323Ab2ASQkV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 11:40:21 -0500
In-Reply-To: <1326991191-12472-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Once the card has been detected to be removed by the
mmc_detect_card_removed function, schedule a new detect work
immediately and without a delay to let a rescan remove the
card device as soon a possible. This will sooner prevent
further I/O requests.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/core/core.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bec0bf2..265dfd8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2077,6 +2077,7 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 int mmc_detect_card_removed(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
+	int ret;
 
 	WARN_ON(!host->claimed);
 	/*
@@ -2086,9 +2087,20 @@ int mmc_detect_card_removed(struct mmc_host *host)
 	if (card && !host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
 		return mmc_card_removed(card);
 
-	host->detect_change = 0;
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
 
-	return _mmc_detect_card_removed(host);
+	return ret;
 }
 EXPORT_SYMBOL(mmc_detect_card_removed);
 
-- 
1.7.5.4

