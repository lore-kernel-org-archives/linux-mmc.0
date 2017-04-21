From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 4/4] mmc: sdhci-pci: Set MMC_CAP2_NO_SDIO_RESET if child has wake from S4 (hibernate)
Date: Fri, 21 Apr 2017 13:08:08 +0300
Message-ID: <1492769288-7474-5-git-send-email-adrian.hunter@intel.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

SDIO reset interferes with a SDIO function driver's restore from
hibernation. Set MMC_CAP2_NO_SDIO_RESET if a child node has _S4W method
which indicates a capability to wake from S4 (hibernate).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 57d6f50b73dc..cc9fc7d54570 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -597,11 +597,42 @@ static int ni_set_max_freq(struct sdhci_pci_slot *slot)
 
 	return 0;
 }
+
+static bool __sdhci_pci_child_has_s4w(struct acpi_device *child)
+{
+	acpi_handle handle = child->handle;
+	unsigned long long ret;
+
+	return ACPI_SUCCESS(acpi_evaluate_integer(handle, "_S4W", NULL, &ret));
+}
+
+static bool sdhci_pci_child_has_s4w(struct sdhci_pci_slot *slot)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&slot->chip->pdev->dev);
+	struct acpi_device *child;
+	bool child_has_s4w = false;
+
+	if (!adev)
+		return false;
+
+	list_for_each_entry(child, &adev->children, node)
+		if (child->status.present && child->status.enabled) {
+			if (__sdhci_pci_child_has_s4w(child))
+				child_has_s4w = true;
+		}
+
+	return child_has_s4w;
+}
 #else
 static inline int ni_set_max_freq(struct sdhci_pci_slot *slot)
 {
 	return 0;
 }
+
+static bool sdhci_pci_child_has_s4w(struct sdhci_pci_slot *slot)
+{
+	return false;
+}
 #endif
 
 static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
@@ -1960,6 +1991,9 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 
 	host->ioaddr = pcim_iomap_table(pdev)[bar];
 
+	if (sdhci_pci_child_has_s4w(slot))
+		host->mmc->caps2 |= MMC_CAP2_NO_SDIO_RESET;
+
 	if (chip->fixes && chip->fixes->probe_slot) {
 		ret = chip->fixes->probe_slot(slot);
 		if (ret)
-- 
1.9.1
