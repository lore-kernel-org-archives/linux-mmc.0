From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 3/4] mmc: sdhci-acpi: Set MMC_CAP2_NO_SDIO_RESET if child has wake from S4 (hibernate)
Date: Fri, 21 Apr 2017 13:08:07 +0300
Message-ID: <1492769288-7474-4-git-send-email-adrian.hunter@intel.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

SDIO reset interferes with a SDIO function driver's restore from
hibernation. Set MMC_CAP2_NO_SDIO_RESET if a child node has _S4W method
which indicates a capability to wake from S4 (hibernate).

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c6a9a1bfaa22..e053a45db6b1 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -374,6 +374,14 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
 	return NULL;
 }
 
+static bool sdhci_acpi_child_has_s4w(struct acpi_device *child)
+{
+	acpi_handle handle = child->handle;
+	unsigned long long ret;
+
+	return ACPI_SUCCESS(acpi_evaluate_integer(handle, "_S4W", NULL, &ret));
+}
+
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -382,6 +390,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
+	bool child_has_s4w = false;
 	resource_size_t len;
 	const char *hid;
 	const char *uid;
@@ -393,8 +402,11 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
 	list_for_each_entry(child, &device->children, node)
-		if (child->status.present && child->status.enabled)
+		if (child->status.present && child->status.enabled) {
 			acpi_device_fix_up_power(child);
+			if (sdhci_acpi_child_has_s4w(child))
+				child_has_s4w = true;
+		}
 
 	if (acpi_bus_get_status(device) || !device->status.present)
 		return -ENODEV;
@@ -439,6 +451,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	if (child_has_s4w)
+		host->mmc->caps2 |= MMC_CAP2_NO_SDIO_RESET;
+
 	if (c->slot) {
 		if (c->slot->probe_slot) {
 			err = c->slot->probe_slot(pdev, hid, uid);
-- 
1.9.1

