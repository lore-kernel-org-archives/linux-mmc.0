From: yisun1 <yi.y.sun@intel.com>
Subject: [PATCH] mmc: sdhci: support eMMC, SD, SDIO on Moorefield.
Date: Tue, 15 Jul 2014 13:43:31 +0800
Message-ID: <1405403011-13070-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6322 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbaGOFtb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Jul 2014 01:49:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: yunpeng.gao@intel.com, yi.y.sun@intel.com

This patch is to enable eMMC, SD and SDIO on Moorefield.

Signed-off-by: yisun1 <yi.y.sun@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |   62 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h |    3 ++
 2 files changed, 65 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..1817fa1 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -316,6 +316,43 @@ static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
 	.probe_slot	= intel_mrfl_mmc_probe_slot,
 };
 
+static int intel_moor_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA |
+				MMC_CAP_NONREMOVABLE |
+				MMC_CAP_1_8V_DDR;
+
+	/* Enable HS200 */
+	slot->host->mmc->caps2 |= MMC_CAP2_HS200;
+
+	return 0;
+}
+
+static int intel_moor_sdio_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+
+	return 0;
+}
+
+static const struct sdhci_pci_fixes sdhci_intel_moor_emmc = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.allow_runtime_pm = true,
+	.probe_slot	= intel_moor_emmc_probe_slot,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_moor_sd = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.allow_runtime_pm = true,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_moor_sdio = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.allow_runtime_pm = true,
+	.probe_slot	= intel_moor_sdio_probe_slot,
+};
+
 /* O2Micro extra registers */
 #define O2_SD_LOCK_WP		0xD3
 #define O2_SD_MULTI_VCC3V	0xEE
@@ -911,6 +948,31 @@ static const struct pci_device_id pci_ids[] = {
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrfl_mmc,
 	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MOOR_EMMC,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_moor_emmc,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MOOR_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_moor_sd,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_MOOR_SDIO,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_moor_sdio,
+	},
+
 	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 6d71871..e006ecd 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -12,6 +12,9 @@
 #define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
 #define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50
 #define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
+#define PCI_DEVICE_ID_INTEL_MOOR_EMMC	0x1490
+#define PCI_DEVICE_ID_INTEL_MOOR_SD	0x1491
+#define PCI_DEVICE_ID_INTEL_MOOR_SDIO	0x1492
 #define PCI_DEVICE_ID_INTEL_CLV_SDIO0	0x08f9
 #define PCI_DEVICE_ID_INTEL_CLV_SDIO1	0x08fa
 #define PCI_DEVICE_ID_INTEL_CLV_SDIO2	0x08fb
-- 
1.7.9.5

