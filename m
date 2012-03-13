From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/3] mmc: sdhci-pci: Add MSI support
Date: Tue, 13 Mar 2012 18:16:40 +0100
Message-ID: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/mmc/host/sdhci-pci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 7165e6a..9382f27 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1379,6 +1379,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 
 	slots = chip->num_slots;	/* Quirk may have changed this */
 
+	pci_enable_msi(pdev);
+
 	for (i = 0; i < slots; i++) {
 		slot = sdhci_pci_probe_slot(pdev, chip, first_bar, i);
 		if (IS_ERR(slot)) {
@@ -1397,6 +1399,8 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 	return 0;
 
 free:
+	pci_disable_msi(pdev);
+
 	pci_set_drvdata(pdev, NULL);
 	kfree(chip);
 
@@ -1419,6 +1423,8 @@ static void __devexit sdhci_pci_remove(struct pci_dev *pdev)
 		for (i = 0; i < chip->num_slots; i++)
 			sdhci_pci_remove_slot(chip->slots[i]);
 
+		pci_disable_msi(pdev);
+
 		pci_set_drvdata(pdev, NULL);
 		kfree(chip);
 	}
-- 
1.7.3.4
