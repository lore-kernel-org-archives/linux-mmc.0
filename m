From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] pci: Add a quirk for the Ricoh 0xe22 SD card reader
Date: Sat,  1 Dec 2012 12:37:20 -0800
Message-ID: <33c411da9bb44eae8a5f9e0609f8eb0aa4eda601.1354385950.git.luto@amacapital.net>
References: <33c411da9bb44eae8a5f9e0609f8eb0aa4eda600.1354385950.git.luto@amacapital.net>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <33c411da9bb44eae8a5f9e0609f8eb0aa4eda600.1354385950.git.luto@amacapital.net>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Ball <cjb@laptop.org>, Andy Lutomirski <luto@amacapital.net>, linux-mmc@vger.kernel.org, Manoj Iyer <manoj.iyer@canonical.com>, stable@kernel.org
List-Id: linux-mmc@vger.kernel.org

Otherwise it fails like this on cards like the Transcend 16GB SDHC card:
mmc0: new SDHC card at address b368
mmcblk0: mmc0:b368 SDC   15.0 GiB
mmcblk0: error -110 sending status command, retrying
mmcblk0: error -84 transferring data, sector 0, nr 8, cmd respons
e 0x900, card status 0xb0

Tested on my Lenovo x200 laptop.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
Acked-by: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
Cc: Manoj Iyer <manoj.iyer@canonical.com>
Cc: <stable@kernel.org>
---
 drivers/pci/quirks.c    | 7 +++++--
 include/linux/pci_ids.h | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7a451ff..7165f2a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2686,7 +2686,7 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 	if (PCI_FUNC(dev->devfn))
 		return;
 	/*
-	 * RICOH 0xe823 SD/MMC card reader fails to recognize
+	 * RICOH 0xe822 and 0xe823 SD/MMC card readers fails to recognize
 	 * certain types of SD/MMC cards. Lowering the SD base
 	 * clock frequency from 200Mhz to 50Mhz fixes this issue.
 	 *
@@ -2697,7 +2697,8 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 	 * 0xf9  - Key register for 0x150
 	 * 0xfc  - key register for 0xe1
 	 */
-	if (dev->device == PCI_DEVICE_ID_RICOH_R5CE823) {
+	if (dev->device == PCI_DEVICE_ID_RICOH_R5CE822 ||
+	    dev->device == PCI_DEVICE_ID_RICOH_R5CE823) {
 		pci_write_config_byte(dev, 0xf9, 0xfc);
 		pci_write_config_byte(dev, 0x150, 0x10);
 		pci_write_config_byte(dev, 0xf9, 0x00);
@@ -2724,6 +2725,8 @@ static void ricoh_mmc_fixup_r5c832(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5C832, ricoh_mmc_fixup_r5c832);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE822, ricoh_mmc_fixup_r5c832);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE822, ricoh_mmc_fixup_r5c832);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823, ricoh_mmc_fixup_r5c832);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_RICOH, PCI_DEVICE_ID_RICOH_R5CE823, ricoh_mmc_fixup_r5c832);
 #endif /*CONFIG_MMC_RICOH_MMC*/
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 9d36b82..d16ad56 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1568,6 +1568,7 @@
 #define PCI_DEVICE_ID_RICOH_RL5C476	0x0476
 #define PCI_DEVICE_ID_RICOH_RL5C478	0x0478
 #define PCI_DEVICE_ID_RICOH_R5C822	0x0822
+#define PCI_DEVICE_ID_RICOH_R5CE822	0xe822
 #define PCI_DEVICE_ID_RICOH_R5CE823	0xe823
 #define PCI_DEVICE_ID_RICOH_R5C832	0x0832
 #define PCI_DEVICE_ID_RICOH_R5C843	0x0843
-- 
1.7.11.7
