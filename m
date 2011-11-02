From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/4] mmc: sdhci: prevent card detection activity for non-removable cards
Date: Wed,  2 Nov 2011 08:57:19 +0200
Message-ID: <1320217041-2580-3-git-send-email-adrian.hunter@intel.com>
References: <1320217041-2580-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320217041-2580-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Do not enable card detection interrupts for non-removable cards.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5b01eff..2213366 100644
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
