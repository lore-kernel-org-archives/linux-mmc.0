From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/1] mmc: sdhci-pci: add another device id
Date: Thu, 20 Jun 2013 12:57:59 +0300
Message-ID: <1371722279-16975-2-git-send-email-adrian.hunter@intel.com>
References: <1371722279-16975-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49953 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753845Ab3FTJwZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 20 Jun 2013 05:52:25 -0400
In-Reply-To: <1371722279-16975-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Add another PCI device id for an eMMC host controller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index e082fac..d7d6bc8 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
 #define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
 #define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
+#define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50
 
 /*
  * PCI registers
@@ -931,6 +932,14 @@ static const struct pci_device_id pci_ids[] = {
 	},
 
 	{
+		.vendor		= PCI_VENDOR_ID_INTEL,
+		.device		= PCI_DEVICE_ID_INTEL_BYT_EMMC2,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (kernel_ulong_t)&sdhci_intel_byt_emmc,
+	},
+
+	{
 		.vendor		= PCI_VENDOR_ID_O2,
 		.device		= PCI_DEVICE_ID_O2_8120,
 		.subvendor	= PCI_ANY_ID,
-- 
1.7.11.7

