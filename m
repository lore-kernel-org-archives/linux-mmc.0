From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/7] sdhci: Intel Medfield support
Date: Mon, 13 Sep 2010 18:39:13 +0100
Message-ID: <20100913173909.20345.12606.stgit@localhost.localdomain>
References: <20100913172738.20345.61119.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21097 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab0IMSXp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 14:23:45 -0400
In-Reply-To: <20100913172738.20345.61119.stgit@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

From: Xiaochen Shen <xiaochen.shen@intel.com>

Basic support for the Intel Medfield devices

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/mmc/host/sdhci-pci.c |   49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |    5 ++++
 2 files changed, 54 insertions(+), 0 deletions(-)


diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 9b0a348..1324369 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -426,6 +426,15 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1 = {
 	.host_ops	= &sdhci_intel_mrst_hc,
 };
 
+static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc_sdio = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+
+
 #endif
 
 static const struct pci_device_id pci_ids[] __devinitdata = {
@@ -541,6 +550,46 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrst_hc1,
 	},
+
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
 #endif
 	{	/* Generic SD host controller */
 		PCI_DEVICE_CLASS((PCI_CLASS_SYSTEM_SDHCI << 8), 0xFFFF00)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 674316e..fd619e8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2412,6 +2412,11 @@
 #define PCI_DEVICE_ID_INTEL_82378	0x0484
 #define PCI_DEVICE_ID_INTEL_MRST_SD0	0x0807
 #define PCI_DEVICE_ID_INTEL_MRST_SD1	0x0808
+#define PCI_DEVICE_ID_INTEL_MFD_SD	0x0820
+#define PCI_DEVICE_ID_INTEL_MFD_SDIO1	0x0821
+#define PCI_DEVICE_ID_INTEL_MFD_SDIO2	0x0822
+#define PCI_DEVICE_ID_INTEL_MFD_EMMC0	0x0823
+#define PCI_DEVICE_ID_INTEL_MFD_EMMC1	0x0824
 #define PCI_DEVICE_ID_INTEL_I960	0x0960
 #define PCI_DEVICE_ID_INTEL_I960RM	0x0962
 #define PCI_DEVICE_ID_INTEL_8257X_SOL	0x1062

