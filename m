From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: remove SDHCI_QUIRK2_OWN_CARD_DETECTION
Date: Fri,  9 Dec 2011 09:36:38 +0200
Message-ID: <1323416198-14200-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:47063 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab1LIHgt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 Dec 2011 02:36:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Even if a driver provides separate card detection,
an interrupt is still needed to abort mmc requests
that are in progress.  SDHCI_QUIRK2_OWN_CARD_DETECTION
prevents that, so remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    1 -
 drivers/mmc/host/sdhci.c     |    3 ---
 include/linux/mmc/sdhci.h    |    2 --
 3 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d2e77fb..abced67 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -233,7 +233,6 @@ static int mfd_sd_probe_slot(struct sdhci_pci_slot *slot)
 
 	slot->cd_gpio = gpio;
 	slot->cd_irq = irq;
-	slot->host->quirks2 |= SDHCI_QUIRK2_OWN_CARD_DETECTION;
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ab6018f..ec10288 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -149,9 +149,6 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		return;
 
-	if (host->quirks2 & SDHCI_QUIRK2_OWN_CARD_DETECTION)
-		return;
-
 	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
 			      SDHCI_CARD_PRESENT;
 	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e4b6935..dad7a46 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -90,8 +90,6 @@ struct sdhci_host {
 
 	unsigned int quirks2;	/* More deviations from spec. */
 
-#define SDHCI_QUIRK2_OWN_CARD_DETECTION			(1<<0)
-
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.7.6.4

