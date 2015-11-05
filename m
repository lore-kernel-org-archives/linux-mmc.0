From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: core: Keep host claimed in mmc_rescan() while calling host ops
Date: Thu,  5 Nov 2015 16:08:08 +0100
Message-ID: <1446736088-11715-2-git-send-email-ulf.hansson@linaro.org>
References: <1446736088-11715-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35880 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161579AbbKEPIO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2015 10:08:14 -0500
Received: by lbblt2 with SMTP id lt2so18461414lbb.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2015 07:08:12 -0800 (PST)
In-Reply-To: <1446736088-11715-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

As mmc_claim_host() invokes pm_runtime_get_sync() for the mmc host device,
it's important that the host is kept claimed for *all* accesses to it via
the host_ops callbacks.

In mmc_rescan(), the ->card_event() and the ->get_cd() callback are being
invoked without claiming the host, let's fix this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c1027a4..394963d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2576,7 +2576,9 @@ void mmc_rescan(struct work_struct *work)
 	host->rescan_entered = 1;
 
 	if (host->trigger_card_event && host->ops->card_event) {
+		mmc_claim_host(host);
 		host->ops->card_event(host);
+		mmc_release_host(host);
 		host->trigger_card_event = false;
 	}
 
@@ -2611,15 +2613,14 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
+	mmc_claim_host(host);
 	if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
 			host->ops->get_cd(host) == 0) {
-		mmc_claim_host(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
 		goto out;
 	}
 
-	mmc_claim_host(host);
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
 		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
 			break;
-- 
1.9.1

