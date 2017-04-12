From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 3/3] mmc: sdhci-acpi: Add DMI fix_up_power_blacklist
Date: Wed, 12 Apr 2017 20:19:22 +0200
Message-ID: <20170412181922.31833-3-hdegoede@redhat.com>
References: <20170412181922.31833-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbdDLST1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 12 Apr 2017 14:19:27 -0400
In-Reply-To: <20170412181922.31833-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

Add a DMI based blacklist for systems where calling
acpi_device_fix_up_power() is harmful.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Adjust for changes in mmc: sdhci-acpi: Add fix_up_power_blacklist module option
-Only use a single fix_up_power_dmi_blacklist for the GPDwin further testing
 has shown that the DMI strings are unique enough that we do not need the
 bios-date in there
Changes in v3:
-Adjust for changes to "mmc: sdhci-acpi: Add blacklist module option"
---
 drivers/mmc/host/sdhci-acpi.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 42bbc9a..495d1cc 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -36,6 +36,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
@@ -384,6 +385,28 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
+static const struct dmi_system_id fix_up_power_dmi_blacklist[] = {
+	{
+		/*
+		 * Match for the GPDwin which unfortunately uses somewhat
+		 * generic dmi strings, which is why we test for 4 strings.
+		 * Comparing against 23 other byt/cht boards, board_vendor
+		 * and board_name are unique to the GPDwin, where as only one
+		 * other board has the same board_serial and 3 others have
+		 * the same default product_name. Also the GPDwin is the
+		 * only device to have both board_ and product_name not set.
+		 */
+		.driver_data = "80860F14:2",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_SERIAL, "Default string"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Default string"),
+		},
+	},
+	{ }
+};
+
 static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
 							 const char *uid)
 {
@@ -406,6 +429,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	acpi_handle handle = ACPI_HANDLE(dev);
 	const char *bl = blacklist;
 	struct acpi_device *device, *child;
+	const struct dmi_system_id *dmi_id;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
@@ -420,6 +444,12 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	hid = acpi_device_hid(device);
 	uid = device->pnp.unique_id;
 
+	if (!bl) {
+		dmi_id = dmi_first_match(fix_up_power_dmi_blacklist);
+		if (dmi_id)
+			bl = dmi_id->driver_data;
+	}
+
 	if (sdhci_acpi_compare_hid_uid(bl, hid, uid))
 		return -ENODEV;
 
-- 
2.9.3

