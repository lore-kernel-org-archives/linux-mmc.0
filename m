From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH v3 2/2] mmc4.5: host: poweroff notify rework
Date: Mon,  7 May 2012 19:11:24 +0530
Message-ID: <1336398084-23203-2-git-send-email-girish.shivananjappa@linaro.org>
References: <1336398084-23203-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51855 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab2EGNlp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 May 2012 09:41:45 -0400
Received: by dady13 with SMTP id y13so1269669dad.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 May 2012 06:41:45 -0700 (PDT)
In-Reply-To: <1336398084-23203-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, ulf.hansson@stericsson.com, saugata.das@linaro.org, girish.shivananjappa@linaro.org

This patch changes the structure member name to maintain consistency
of name for the poweroff notify feature

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |    4 ++--
 drivers/mmc/host/sdhci.c  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index ab3fc46..09ac734 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1791,9 +1791,9 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
-		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_SHORT;
 	else
-		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
+		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_NONE;
 
 	if (host->pdata->blk_settings) {
 		mmc->max_segs = host->pdata->blk_settings->max_segs;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e626732..958e5fe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2817,9 +2817,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * set notify to short power off notify timeout value.
 	 */
 	if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
-		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
+		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_SHORT;
 	else
-		mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
+		mmc->poweroff_notify_type = MMC_HOST_PW_OFF_NOTIFY_NONE;
 
 	/* Initial value for re-tuning timer count */
 	host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
-- 
1.7.4.1

