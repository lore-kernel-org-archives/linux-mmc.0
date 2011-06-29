From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-pci: allow 8-bit bus width for Intel Medfield eMMCs
Date: Wed, 29 Jun 2011 14:23:47 +0300
Message-ID: <1309346627-32630-3-git-send-email-adrian.hunter@intel.com>
References: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64578 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156Ab1F2LYD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 07:24:03 -0400
In-Reply-To: <1309346627-32630-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, Adrian Hunter <adrian.hunter@intel.com>

Unless MMC_CAP_8_BIT_DATA is set, the bus width defaults to 4.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e1ae855..26c5286 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -163,6 +163,12 @@ static int mrst_hc_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+static int mfd_emmc_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+	return 0;
+}
+
 static const struct sdhci_pci_fixes sdhci_intel_mrst_hc0 = {
 	.quirks		= SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_NO_HISPD_BIT,
 	.probe_slot	= mrst_hc_probe_slot,
@@ -177,8 +183,13 @@ static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 };
 
-static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc_sdio = {
+static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+};
+
+static const struct sdhci_pci_fixes sdhci_intel_mfd_emmc = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.probe_slot	= mfd_emmc_probe_slot,
 };
 
 /* O2Micro extra registers */
@@ -689,7 +700,7 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.device		= PCI_DEVICE_ID_INTEL_MFD_SDIO1,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sdio,
 	},
 
 	{
@@ -697,7 +708,7 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.device		= PCI_DEVICE_ID_INTEL_MFD_SDIO2,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_sdio,
 	},
 
 	{
@@ -705,7 +716,7 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.device		= PCI_DEVICE_ID_INTEL_MFD_EMMC0,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc,
 	},
 
 	{
@@ -713,7 +724,7 @@ static const struct pci_device_id pci_ids[] __devinitdata = {
 		.device		= PCI_DEVICE_ID_INTEL_MFD_EMMC1,
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
-		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc_sdio,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_mfd_emmc,
 	},
 
 	{
-- 
1.7.4.4

