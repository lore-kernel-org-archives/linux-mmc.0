From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 2/7] mmc: sdhci: prevent card detection activity for non-removable cards
Date: Tue, 27 Dec 2011 15:48:42 +0200
Message-ID: <1324993727-7508-3-git-send-email-adrian.hunter@intel.com>
References: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38094 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921Ab1L0NtG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Dec 2011 08:49:06 -0500
In-Reply-To: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Do not enable card detection interrupts for non-removable cards.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6a35d03..e6c6cd6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -146,10 +146,9 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present, irqs;
 
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		return;
-
-	if (host->quirks2 & SDHCI_QUIRK2_OWN_CARD_DETECTION)
+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
+	    (host->quirks2 & SDHCI_QUIRK2_OWN_CARD_DETECTION) ||
+	    !mmc_card_is_removable(host->mmc))
 		return;
 
 	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
-- 
1.7.6.4

