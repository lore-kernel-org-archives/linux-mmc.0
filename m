From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-pci: Add support for Intel GLK
Date: Tue, 22 Nov 2016 11:03:37 +0200
Message-ID: <1479805418-19603-2-git-send-email-adrian.hunter@intel.com>
References: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932307AbcKVJJE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 04:09:04 -0500
In-Reply-To: <1479805418-19603-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "David E. Box" <david.e.box@linux.intel.com>

Add support for eMMC/SD/SDIO Intel GLK host controllers.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 27 ++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci-pci.h      |  3 +++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1d9e00a00e9f..501098e65b0e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -390,7 +390,8 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
 	slot->cd_override_level = true;
 	if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXT_SD ||
 	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BXTM_SD ||
-	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD) {
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
+	    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_SD) {
 		slot->host->mmc_host_ops.get_cd = bxt_get_cd;
 		slot->host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
 	}
@@ -1277,6 +1278,30 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	},
 
 	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_GLK_EMMC,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_GLK_SDIO,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_GLK_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
 		.subvendor	= PCI_ANY_ID,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 6bccf56bc5ff..4abdaed72bd4 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -34,6 +34,9 @@
 #define PCI_DEVICE_ID_INTEL_APL_SD	0x5aca
 #define PCI_DEVICE_ID_INTEL_APL_EMMC	0x5acc
 #define PCI_DEVICE_ID_INTEL_APL_SDIO	0x5ad0
+#define PCI_DEVICE_ID_INTEL_GLK_SD	0x31ca
+#define PCI_DEVICE_ID_INTEL_GLK_EMMC	0x31cc
+#define PCI_DEVICE_ID_INTEL_GLK_SDIO	0x31d0
 
 /*
  * PCI registers
-- 
1.9.1

