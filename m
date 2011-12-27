From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V4 5/7] mmc: sdhci-pci: remove SDHCI_QUIRK2_OWN_CARD_DETECTION
Date: Tue, 27 Dec 2011 15:48:45 +0200
Message-ID: <1324993727-7508-6-git-send-email-adrian.hunter@intel.com>
References: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49580 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab1L0NtH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 27 Dec 2011 08:49:07 -0500
In-Reply-To: <1324993727-7508-1-git-send-email-adrian.hunter@intel.com>
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
 drivers/mmc/host/sdhci.c     |    1 -
 include/linux/mmc/sdhci.h    |    2 --
 3 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 646680a..83a152e 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -212,7 +212,6 @@ static void sdhci_pci_add_own_cd(struct sdhci_pci_slot *slot)
 
 	slot->cd_gpio = gpio;
 	slot->cd_irq = irq;
-	slot->host->quirks2 |= SDHCI_QUIRK2_OWN_CARD_DETECTION;
 
 	return;
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e6c6cd6..6f1fd02 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -147,7 +147,6 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	u32 present, irqs;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    (host->quirks2 & SDHCI_QUIRK2_OWN_CARD_DETECTION) ||
 	    !mmc_card_is_removable(host->mmc))
 		return;
 
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

