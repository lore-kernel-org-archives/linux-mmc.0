From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-pci: Add support for Intel SPT
Date: Mon,  5 Jan 2015 14:47:58 +0200
Message-ID: <1420462078-28868-3-git-send-email-adrian.hunter@intel.com>
References: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11016 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbbAEMtq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Jan 2015 07:49:46 -0500
In-Reply-To: <1420462078-28868-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add PCI IDs for SPT eMMC, SDIO and SD card.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 25 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 0342775..4f38554 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -993,6 +993,31 @@ static const struct pci_device_id pci_ids[] = {
 		.subdevice	= PCI_ANY_ID,
 		.driver_data	= (kernel_ulong_t)&sdhci_intel_mrfl_mmc,
 	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_SPT_EMMC,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_SPT_SDIO,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sdio,
+	},
+
+	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_SPT_SD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_sd,
+	},
+
 	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index d57c3d1..1ec684d 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -21,6 +21,9 @@
 #define PCI_DEVICE_ID_INTEL_CLV_EMMC0	0x08e5
 #define PCI_DEVICE_ID_INTEL_CLV_EMMC1	0x08e6
 #define PCI_DEVICE_ID_INTEL_QRK_SD	0x08A7
+#define PCI_DEVICE_ID_INTEL_SPT_EMMC	0x9d2b
+#define PCI_DEVICE_ID_INTEL_SPT_SDIO	0x9d2c
+#define PCI_DEVICE_ID_INTEL_SPT_SD	0x9d2d
 
 /*
  * PCI registers
-- 
1.9.1

