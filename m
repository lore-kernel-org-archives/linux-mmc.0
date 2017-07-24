From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] sdhci: pci: Fix up power if device has ACPI companion
Date: Mon, 24 Jul 2017 18:07:50 +0300
Message-ID: <20170724150750.12217-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:21320 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753556AbdGXPHz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 11:07:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Fix up a power state in case PCI device has an ACPI companion.

Do it only for Intel Merrifield for now.

This is almost copy'n'paste of part of sdhci_acpi_probe() and might be
split out to a helper function in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index e1721ac37919..2c853cfa8389 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -730,6 +730,24 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
 #define INTEL_MRFLD_SD		2
 #define INTEL_MRFLD_SDIO	3
 
+#ifdef CONFIG_ACPI
+static void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot)
+{
+	struct acpi_device *device, *child;
+
+	device = ACPI_COMPANION(&slot->chip->pdev->dev);
+	if (!device)
+		return;
+
+	acpi_device_fix_up_power(device);
+	list_for_each_entry(child, &device->children, node)
+		if (child->status.present && child->status.enabled)
+			acpi_device_fix_up_power(child);
+}
+#else
+static inline void intel_mrfld_mmc_fix_up_power_slot(struct sdhci_pci_slot *slot) {}
+#endif
+
 static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	unsigned int func = PCI_FUNC(slot->chip->pdev->devfn);
@@ -751,6 +769,8 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
 	default:
 		return -ENODEV;
 	}
+
+	intel_mrfld_mmc_fix_up_power_slot(slot);
 	return 0;
 }
 
-- 
2.13.2

