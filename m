From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: Add another PCI ID for an Intel eMMC host controller
Date: Tue,  6 Oct 2015 10:26:21 +0300
Message-ID: <1444116381-31726-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38827 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbbJFH3U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Oct 2015 03:29:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add another PCI ID for an Intel eMMC host controller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 8 ++++++++
 drivers/mmc/host/sdhci-pci.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index b3b0a3e4fca1..7ccd4220076c 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1113,6 +1113,14 @@ static const struct pci_device_id pci_ids[] = {
 	},
 
 	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_DNV_EMMC,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
 		.subvendor	= PCI_ANY_ID,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 541f1cad5247..cd4f4d74377e 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -24,6 +24,7 @@
 #define PCI_DEVICE_ID_INTEL_SPT_EMMC	0x9d2b
 #define PCI_DEVICE_ID_INTEL_SPT_SDIO	0x9d2c
 #define PCI_DEVICE_ID_INTEL_SPT_SD	0x9d2d
+#define PCI_DEVICE_ID_INTEL_DNV_EMMC	0x19db
 
 /*
  * PCI registers
-- 
1.9.1

