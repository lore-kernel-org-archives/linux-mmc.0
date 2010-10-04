From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/3] sdhci: Intel Medfield support
Date: Mon, 04 Oct 2010 15:24:52 +0100
Message-ID: <20101004142432.901.87030.stgit@localhost.localdomain>
References: <20101004142246.901.37491.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:46815 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275Ab0JDPri (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2010 11:47:38 -0400
Received: from localhost.localdomain (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id o94EhIFg024728
	for <linux-mmc@vger.kernel.org>; Mon, 4 Oct 2010 15:43:23 +0100
In-Reply-To: <20101004142246.901.37491.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

From: Xiaochen Shen <xiaochen.shen@intel.com>

Basic support for the Intel Medfield devices

Give them their own quirks as we will need to update this later.

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-pci.c |   48 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |    7 ++++++
 2 files changed, 55 insertions(+), 0 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 4f5d6d0..ec4b81d 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -145,6 +145,14 @@ static const struct sdhci_pci_fixes sdhci_cafe = {
 			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
 };
 
+static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc_sdio = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+
 static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
 {
 	u8 scratch;
@@ -494,6 +502,46 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.driver_data	= (kernel_ulong_t)&sdhci_via,
 	},
 
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MFD_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sd,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MFD_SDIO1,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MFD_SDIO2,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MFD_EMMC0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MFD_EMMC1,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+	},
+
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
 	},
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index acd38ac..bd33a06 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2424,6 +2424,13 @@
 #define PCI_DEVICE_ID_INTEL_82375	0x0482
 #define PCI_DEVICE_ID_INTEL_82424	0x0483
 #define PCI_DEVICE_ID_INTEL_82378	0x0484
+#define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
+#define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
+#define PCI_DEVICE_ID_INTEL_MFD_SD	0x0820
+#define PCI_DEVICE_ID_INTEL_MFD_SDIO1	0x0821
+#define PCI_DEVICE_ID_INTEL_MFD_SDIO2	0x0822
+#define PCI_DEVICE_ID_INTEL_MFD_EMMC0	0x0823
+#define PCI_DEVICE_ID_INTEL_MFD_EMMC1	0x0824
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062

