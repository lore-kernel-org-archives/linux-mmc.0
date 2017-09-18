From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: Add support for Intel CDF
Date: Mon, 18 Sep 2017 15:17:05 +0300
Message-ID: <1505737025-18977-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:11271 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753156AbdIRMXp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Sep 2017 08:23:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Add PCI Id for Intel CDF.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 1 +
 drivers/mmc/host/sdhci-pci.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index d0ccc6729fd2..5f3f7b51299f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1288,6 +1288,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	SDHCI_PCI_DEVICE(INTEL, SPT_SDIO,  intel_byt_sdio),
 	SDHCI_PCI_DEVICE(INTEL, SPT_SD,    intel_byt_sd),
 	SDHCI_PCI_DEVICE(INTEL, DNV_EMMC,  intel_byt_emmc),
+	SDHCI_PCI_DEVICE(INTEL, CDF_EMMC,  intel_glk_emmc),
 	SDHCI_PCI_DEVICE(INTEL, BXT_EMMC,  intel_byt_emmc),
 	SDHCI_PCI_DEVICE(INTEL, BXT_SDIO,  intel_byt_sdio),
 	SDHCI_PCI_DEVICE(INTEL, BXT_SD,    intel_byt_sd),
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 75196a2b5289..3c1dd79fdbde 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -25,6 +25,7 @@
 #define PCI_DEVICE_ID_INTEL_SPT_SDIO	0x9d2c
 #define PCI_DEVICE_ID_INTEL_SPT_SD	0x9d2d
 #define PCI_DEVICE_ID_INTEL_DNV_EMMC	0x19db
+#define PCI_DEVICE_ID_INTEL_CDF_EMMC	0x18db
 #define PCI_DEVICE_ID_INTEL_BXT_SD	0x0aca
 #define PCI_DEVICE_ID_INTEL_BXT_EMMC	0x0acc
 #define PCI_DEVICE_ID_INTEL_BXT_SDIO	0x0ad0
-- 
1.9.1

