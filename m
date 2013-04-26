From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/3] mmc: sdhci-pci: add more device ids
Date: Fri, 26 Apr 2013 11:27:23 +0300
Message-ID: <1366964843-20413-4-git-send-email-adrian.hunter@intel.com>
References: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14477 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758893Ab3DZIXF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Apr 2013 04:23:05 -0400
In-Reply-To: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Add three more PCI device ids.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0012d3f..701d06d 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -33,6 +33,9 @@
  */
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
+#define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
+#define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
+#define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
 
 /*
  * PCI registers
@@ -304,6 +307,33 @@ static const struct sdhci_pci_fixes sdhci_intel_pch_sdio = {
 	.probe_slot	= pch_hc_probe_slot,
 };
 
+static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE;
+	slot->host->mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ;
+	return 0;
+}
+
+static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE;
+	return 0;
+}
+
+static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
+	.allow_runtime_pm = true,
+	.probe_slot	= byt_emmc_probe_slot,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
+	.quirks2	= SDHCI_QUIRK2_HOST_OFF_CARD_ON,
+	.allow_runtime_pm = true,
+	.probe_slot	= byt_sdio_probe_slot,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
+};
+
 /* O2Micro extra registers */
 #define O2_SD_LOCK_WP		0xD3
 #define O2_SD_MULTI_VCC3V	0xEE
@@ -856,6 +886,30 @@ static const struct pci_device_id pci_ids[] = {
 	},
 
 	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BYT_SDIO,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BYT_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
 		.subvendor	= PCI_ANY_ID,
-- 
1.7.11.7

