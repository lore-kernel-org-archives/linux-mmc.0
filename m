From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci-pci: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for Medfield SDIO
Date: Tue,  7 Feb 2012 14:48:55 +0200
Message-ID: <1328618935-25175-5-git-send-email-adrian.hunter@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53459 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab2BGMs7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Feb 2012 07:48:59 -0500
In-Reply-To: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

SDIO is powered separated from the host controller, so the card
can remain on while the host controller is powered off during
suspend.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 9952535..3cb9abf 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -47,6 +47,7 @@ struct sdhci_pci_slot;
 
 struct sdhci_pci_fixes {
 	unsigned int		quirks;
+	unsigned int		quirks2;
 	bool			allow_runtime_pm;
 
 	int			(*probe) (struct sdhci_pci_chip *);
@@ -73,6 +74,7 @@ struct sdhci_pci_chip {
 	struct pci_dev		*pdev;
 
 	unsigned int		quirks;
+	unsigned int		quirks2;
 	bool			allow_runtime_pm;
 	const struct sdhci_pci_fixes *fixes;
 
@@ -272,6 +274,7 @@ static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.allow_runtime_pm = true,
 	.probe_slot	= mfd_sdio_probe_slot,
 };
@@ -1207,6 +1210,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 	host->hw_name = "PCI";
 	host->ops = &sdhci_pci_ops;
 	host->quirks = chip->quirks;
+	host->quirks2 = chip->quirks2;
 
 	host->irq = pdev->irq;
 
@@ -1366,6 +1370,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 	chip->fixes = (const struct sdhci_pci_fixes *)ent->driver_data;
 	if (chip->fixes) {
 		chip->quirks = chip->fixes->quirks;
+		chip->quirks2 = chip->fixes->quirks2;
 		chip->allow_runtime_pm = chip->fixes->allow_runtime_pm;
 	}
 	chip->num_slots = slots;
-- 
1.7.6.4

