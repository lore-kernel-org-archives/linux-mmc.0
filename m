From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] sdhci: Fix crash on boot with C0 stepping Moorestown platforms
Date: Tue, 09 Nov 2010 13:57:29 +0000
Message-ID: <20101109135708.21760.22164.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36888 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab0KIOSU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 09:18:20 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Try again with the header fixed properly this time (thought I'd fixed it
the last time - sorry)

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

SDHC2 is newly added in C0 stepping of Langwell. Without the Moorestown
specific quirk, the default pci_probe will be called and crash the kernel.

This patch unblocks the crash problem on C0 by using the same probing
function as HC1, which limits the number of slots to one.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-pci.c |   20 ++++++++++++++------
 include/linux/pci_ids.h      |    1 +
 2 files changed, 15 insertions(+), 6 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d196e77..3d9c246 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -149,11 +149,11 @@ static const struct sdhci_pci_fixes sdhci_cafe = {
  * ADMA operation is disabled for Moorestown platform due to
  * hardware bugs.
  */
-static int mrst_hc1_probe(struct sdhci_pci_chip *chip)
+static int mrst_hc_probe(struct sdhci_pci_chip *chip)
 {
 	/*
-	 * slots number is fixed here for MRST as SDIO3 is never used and has
-	 * hardware bugs.
+	 * slots number is fixed here for MRST as SDIO3/5 are never used and
+	 * have hardware bugs.
 	 */
 	chip->num_slots = 1;
 	return 0;
@@ -163,9 +163,9 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
 	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
 };
 
-static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 = {
+static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
 	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
-	.probe		= mrst_hc1_probe,
+	.probe		= mrst_hc_probe,
 };
 
 static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
@@ -538,7 +538,15 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.device		= PCI_DEVICE_ID_INTEL_MRST_SD1,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1_hc2,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MRST_SD2,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1_hc2,
 	},
 
 	{
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c6bcfe9..d369b53 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2441,6 +2441,7 @@
 #define PCI_DEVICE_ID_INTEL_MFD_SDIO2	0x0822
 #define PCI_DEVICE_ID_INTEL_MFD_EMMC0	0x0823
 #define PCI_DEVICE_ID_INTEL_MFD_EMMC1	0x0824
+#define PCI_DEVICE_ID_INTEL_MRST_SD2	0x084F
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062

