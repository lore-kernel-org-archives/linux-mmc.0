From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH] mmc: sdhci: deactivate tuning timer when host is suspending
Date: Tue, 27 Dec 2011 12:22:30 +0800
Message-ID: <1324959750-18203-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:8850 "EHLO
	VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881Ab1L0EXC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Dec 2011 23:23:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: stable@kernel.org, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lu@amd.com>, Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

Since we are suspending, the tuning timer should be deactivated.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Acked-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab6018f..1abbd26 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2347,8 +2347,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
 	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		mod_timer(&host->tuning_timer, jiffies +
-			host->tuning_count * HZ);
+		del_timer_sync(&host->tuning_timer);
 	}
 
 	ret = mmc_suspend_host(host->mmc);
-- 
1.7.7.4


