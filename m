From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [RESEND PATCH] mmc: core: Re-use code for MMC_CAP2_DETECT_ON_ERR in polling mode
Date: Thu, 18 Apr 2013 11:02:07 +0200
Message-ID: <1366275727-6380-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:33925 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754470Ab3DRJCb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Apr 2013 05:02:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Previously the MMC_CAP2_DETECT_ON_ERR was invented for detecting
slow card removal. In was never a realy good solution and a proper
fix has been merged using gpio debouncing instead. We remove this
cap in this patch.

Although when using polling card detect mode, the code invented for
MMC_CAP2_DETECT_ON_ERR is re-used to complete card removal in an
earlier phase. There are no need waiting for the polling timeout to
elapse in this case.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c  |    5 ++---
 include/linux/mmc/host.h |    1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad7decc..59ae194 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2325,14 +2325,13 @@ int mmc_detect_card_removed(struct mmc_host *host)
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 17d7148..301892a 100644
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

