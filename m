From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH 1/2] mmc: sdhci: Fix tuning timer incorrect setting when suspending host
Date: Wed, 28 Dec 2011 11:11:12 +0800
Message-ID: <1325041873-1320-2-git-send-email-aaron.lu@amd.com>
References: <1325041873-1320-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:11518 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101Ab1L1DLm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Dec 2011 22:11:42 -0500
In-Reply-To: <1325041873-1320-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, Aaron Lu <aaron.lu@amd.com>, stable@kernel.org

When suspending host, the tuning timer shoule be deactivated.
And the HOST_NEEDS_TUNING flag should be set after tuning timer is
deactivated.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Aaron Lu <aaron.lu@amd.com>
Cc: stable@kernel.org
---
 drivers/mmc/host/sdhci.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab6018f..2007d37 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2346,9 +2346,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	/* Disable tuning since we are suspending */
 	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
 	    host->tuning_mode == SDHCI_TUNING_MODE_1) {
+		del_timer_sync(&host->tuning_timer);
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
-		mod_timer(&host->tuning_timer, jiffies +
-			host->tuning_count * HZ);
 	}
 
 	ret = mmc_suspend_host(host->mmc);
-- 
1.7.7.4


