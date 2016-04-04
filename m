From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: Add support and PCI IDs for more Broxton host controllers
Date: Mon,  4 Apr 2016 12:40:37 +0300
Message-ID: <1459762837-3729-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31292 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754454AbcDDJoT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Apr 2016 05:44:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add support and PCI IDs for more Broxton host controllers

Other BXT IDs were added in v4.4 so cc'ing stable. This patch
is dependent on commit 163cbe31e516 ("mmc: sdhci-pci: Fix card
detect race for Intel BXT/APL") but that is already in stable
since v4.4.4.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.4+
---
 drivers/mmc/host/sdhci-pci-core.c | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 62aa5d0efcee..79e19017343e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -390,6 +390,7 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	slot->cd_idx = 0;
 	slot->cd_override_level = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD)
 		slot->host->mmc_host_ops.get_cd = bxt_get_cd;
 
@@ -1173,6 +1174,30 @@ static const struct pci_device_id pci_ids[] = {
 
 	{
 		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BXTM_EMMC,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BXTM_SDIO,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BXTM_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
 		.device		= PCI_DEVICE_ID_INTEL_APL_EMMC,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d1a0b4db60db..89e7151684a1 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -28,6 +28,9 @@
 #define PCI_DEVICE_ID_INTEL_BXT_SD	0x0aca
 #define PCI_DEVICE_ID_INTEL_BXT_EMMC	0x0acc
 #define PCI_DEVICE_ID_INTEL_BXT_SDIO	0x0ad0
+#define PCI_DEVICE_ID_INTEL_BXTM_SD	0x1aca
+#define PCI_DEVICE_ID_INTEL_BXTM_EMMC	0x1acc
+#define PCI_DEVICE_ID_INTEL_BXTM_SDIO	0x1ad0
 #define PCI_DEVICE_ID_INTEL_APL_SD	0x5aca
 #define PCI_DEVICE_ID_INTEL_APL_EMMC	0x5acc
 #define PCI_DEVICE_ID_INTEL_APL_SDIO	0x5ad0
-- 
1.9.1

