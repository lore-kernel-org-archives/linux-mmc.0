From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: core: Decrease the card detect frequency in polling mode
Date: Fri, 22 Mar 2013 10:30:19 +0100
Message-ID: <1363944619-19829-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:39336 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932102Ab3CVJah (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Mar 2013 05:30:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Previously the MMC_CAP2_DETECT_ON_ERR was invented for detecting
slow card removal. In was never a realy good solution and a proper
fix shall use gpio debouncing instead. We remove this cap in this
patch.

Although when running in polling card detect mode, the code can be
re-used to detect card removals. Thus we are able to decrease the
frequency of issued detect works from the mmc_rescan function.

When no card is inserted the polling timeout is 1 HZ. When card is
inserted and detected the polling timeout is increased to 30 s.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c  |   10 ++++++----
 include/linux/mmc/host.h |    1 -
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 08a3cf2..3a83cdc 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2312,14 +2312,13 @@ int mmc_detect_card_removed(struct mmc_host *host)
 	 * The card will be considered unchanged unless we have been asked to
 	 * detect a change or host requires polling to provide card detection.
 	 */
-	if (!host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL) &&
-	    !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
+	if (!host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL))
 		return ret;
 
 	host->detect_change = 0;
 	if (!ret) {
 		ret = _mmc_detect_card_removed(host);
-		if (ret && (host->caps2 & MMC_CAP2_DETECT_ON_ERR)) {
+		if (ret && (host->caps & MMC_CAP_NEEDS_POLL)) {
 			/*
 			 * Schedule a detect work as soon as possible to let a
 			 * rescan handle the card removal.
@@ -2338,6 +2337,7 @@ void mmc_rescan(struct work_struct *work)
 	struct mmc_host *host =
 		container_of(work, struct mmc_host, detect.work);
 	int i;
+	unsigned int polltimeout_s = 1;
 
 	if (host->rescan_disable)
 		return;
@@ -2368,6 +2368,8 @@ void mmc_rescan(struct work_struct *work)
 
 	/* if there still is a card present, stop here */
 	if (host->bus_ops != NULL) {
+		/* set the poll timeout to 30 s when card is inserted */
+		polltimeout_s = 30;
 		mmc_bus_put(host);
 		goto out;
 	}
@@ -2396,7 +2398,7 @@ void mmc_rescan(struct work_struct *work)
 
  out:
 	if (host->caps & MMC_CAP_NEEDS_POLL)
-		mmc_schedule_delayed_work(&host->detect, HZ);
+		mmc_schedule_delayed_work(&host->detect, polltimeout_s * HZ);
 }
 
 void mmc_start_host(struct mmc_host *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d6f20cc..a018e2d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -272,7 +272,6 @@ struct mmc_host {
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
 #define MMC_CAP2_BROKEN_VOLTAGE	(1 << 7)	/* Use the broken voltage */
-#define MMC_CAP2_DETECT_ON_ERR	(1 << 8)	/* On I/O err check card removal */
 #define MMC_CAP2_HC_ERASE_SZ	(1 << 9)	/* High-capacity erase size */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
-- 
1.7.10

