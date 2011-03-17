From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] MMC: use pci_dev->revision
Date: Thu, 17 Mar 2011 21:08:45 +0300
Message-ID: <201103172108.45989.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:56752 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754935Ab1CQSKW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Mar 2011 14:10:22 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: brucechang@via.com.tw, HaraldWelte@viatech.com

The SDHCI driver uses PCI_CLASS_REVISION instead of PCI_REVISION_ID, so it was
not converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65 (PCI: Change
all drivers to use pci_device->revision). The newer VIA driver has the similar
code too. So convert both drivers to using the 'revision' field of 'struct
pci_dev' now...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/mmc/host/sdhci-pci.c |    6 ++----
 drivers/mmc/host/via-sdmmc.c |    5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/mmc/host/sdhci-pci.c
===================================================================
--- linux-2.6.orig/drivers/mmc/host/sdhci-pci.c
+++ linux-2.6/drivers/mmc/host/sdhci-pci.c
@@ -1012,16 +1012,14 @@ static int __devinit sdhci_pci_probe(str
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
 
-	u8 slots, rev, first_bar;
+	u8 slots, first_bar;
 	int ret, i;
 
 	BUG_ON(pdev == NULL);
 	BUG_ON(ent == NULL);
 
-	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &rev);
-
 	dev_info(&pdev->dev, "SDHCI controller found [%04x:%04x] (rev %x)\n",
-		 (int)pdev->vendor, (int)pdev->device, (int)rev);
+		 (int)pdev->vendor, (int)pdev->device, (int)pdev->revision);
 
 	ret = pci_read_config_byte(pdev, PCI_SLOT_INFO, &slots);
 	if (ret)
Index: linux-2.6/drivers/mmc/host/via-sdmmc.c
===================================================================
--- linux-2.6.orig/drivers/mmc/host/via-sdmmc.c
+++ linux-2.6/drivers/mmc/host/via-sdmmc.c
@@ -1090,14 +1090,13 @@ static int __devinit via_sd_probe(struct
 	struct mmc_host *mmc;
 	struct via_crdr_mmc_host *sdhost;
 	u32 base, len;
-	u8 rev, gatt;
+	u8  gatt;
 	int ret;
 
-	pci_read_config_byte(pcidev, PCI_CLASS_REVISION, &rev);
 	pr_info(DRV_NAME
 		": VIA SDMMC controller found at %s [%04x:%04x] (rev %x)\n",
 		pci_name(pcidev), (int)pcidev->vendor, (int)pcidev->device,
-		(int)rev);
+		(int)pcidev->revision);
 
 	ret = pci_enable_device(pcidev);
 	if (ret)
