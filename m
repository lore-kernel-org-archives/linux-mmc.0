From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH v2 1/2] mmc: sdhci: restore host settings when card is removed
Date: Fri, 29 Jun 2012 16:17:31 +0800
Message-ID: <1340957852-28936-2-git-send-email-aaron.lu@amd.com>
References: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.207] ([213.199.154.207]:44504 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752273Ab2F2ISh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Jun 2012 04:18:37 -0400
In-Reply-To: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>

Some of the host settings are affected by different cards inserted, e.g.
when an UHS-I card is inserted, the SDHCI_NEEDS_RETUING flag might be
set when the tuning timer expired and host's max_blk_count will be
reduced to make sure the data transfer for a command does not exceed 4MiB
to meet the retuning mode 1's requirement.

When the card is removed, we should restore the original setting of the
host since we can't be sure the next card being inserted will still be
an UHS-I card that needs tuning. The original setting include its
max_blk_count and no set of the flag of SDHCI_NEEDS_RETUNING.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff522ec..7e182ad 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -245,6 +245,18 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 static void sdhci_reinit(struct sdhci_host *host)
 {
 	sdhci_init(host, 0);
+	/*
+	 * Retuning stuffs are affected by different cards inserted and only
+	 * applicable to UHS-I cards. So reset these fields to their initial
+	 * value when card is removed.
+	 */
+	if (host->version >= SDHCI_SPEC_300 && host->tuning_count &&
+			host->tuning_mode == SDHCI_TUNING_MODE_1) {
+		del_timer_sync(&host->tuning_timer);
+		host->flags &= ~SDHCI_NEEDS_RETUNING;
+		host->mmc->max_blk_count =
+			(host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
+	}
 	sdhci_enable_card_detection(host);
 }
 
-- 
1.7.11.1


