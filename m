From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: add flag for devices that can support runtime PM
Date: Mon, 17 Oct 2011 10:52:44 +0300
Message-ID: <1318837964-28654-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46092 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752695Ab1JQHxU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Oct 2011 03:53:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Only allow runtime PM for devices that specifically indicate
that they support it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index f49b184..c22d810 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -47,6 +47,7 @@ struct sdhci_pci_slot;
 
 struct sdhci_pci_fixes {
 	unsigned int		quirks;
+	unsigned int		allow_runtime_pm:1;
 
 	int			(*probe) (struct sdhci_pci_chip *);
 
@@ -72,6 +73,7 @@ struct sdhci_pci_chip {
 	struct pci_dev		*pdev;
 
 	unsigned int		quirks;
+	unsigned int		allow_runtime_pm:1;
 	const struct sdhci_pci_fixes *fixes;
 
 	int			num_slots;	/* Slots on controller */
@@ -305,16 +307,19 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.allow_runtime_pm = 1,
 	.probe_slot	= mfd_sd_probe_slot,
 	.remove_slot	= mfd_sd_remove_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.allow_runtime_pm = 1,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.allow_runtime_pm = 1,
 	.probe_slot	= mfd_emmc_probe_slot,
 	.remove_slot	= mfd_emmc_remove_slot,
 };
@@ -1355,8 +1360,10 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 
 	chip->pdev = pdev;
 	chip->fixes = (const struct sdhci_pci_fixes *)ent->driver_data;
-	if (chip->fixes)
+	if (chip->fixes) {
 		chip->quirks = chip->fixes->quirks;
+		chip->allow_runtime_pm = chip->fixes->allow_runtime_pm;
+	}
 	chip->num_slots = slots;
 
 	pci_set_drvdata(pdev, chip);
@@ -1381,7 +1388,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 		chip->slots[i] = slot;
 	}
 
-	sdhci_pci_runtime_pm_allow(&pdev->dev);
+	if (chip->allow_runtime_pm)
+		sdhci_pci_runtime_pm_allow(&pdev->dev);
 
 	return 0;
 
@@ -1399,11 +1407,12 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
 	int i;
 	struct sdhci_pci_chip *chip;
 
-	sdhci_pci_runtime_pm_forbid(&pdev->dev);
-
 	chip = pci_get_drvdata(pdev);
 
 	if (chip) {
+		if (chip->allow_runtime_pm)
+			sdhci_pci_runtime_pm_forbid(&pdev->dev);
+
 		for (i = 0; i < chip->num_slots; i++)
 			sdhci_pci_remove_slot(chip->slots[i]);
 
-- 
1.7.6.4

