From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] mmc: sdhci-acpi: Add DMI fix_up_power_blacklist
Date: Tue,  4 Apr 2017 10:50:13 +0200
Message-ID: <20170404085013.19837-4-hdegoede@redhat.com>
References: <20170404085013.19837-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752129AbdDDIuU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Apr 2017 04:50:20 -0400
In-Reply-To: <20170404085013.19837-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

Add a DMI based blacklist for systems where calling
acpi_device_fix_up_power() is harmful.

Note as the comment added above the GPDwin entry explains unfortunately
the GPDwin dmi strings are somewhat generic, so I've added the bios-date
string for a more unique match, which means we need 3 entries for the
GPDwin for the 3 known BIOS versions out there.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8fe46ba..826e34f 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -36,6 +36,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
@@ -83,7 +84,7 @@ struct sdhci_acpi_host {
 	bool				use_runtime_pm;
 };
 
-static int fix_up_power = 1;
+static int fix_up_power = -1;
 
 static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 {
@@ -363,6 +364,42 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
+static const struct dmi_system_id fix_up_power_blacklist[] = {
+	{
+		/*
+		 * Match for the GPDwin which unfortunately uses somewhat
+		 * generic dmi strings, which is why the bios-date match is
+		 * included and we need multiple entries :| These strings have
+		 * been checked against 6 other byt/cht boards and board_vendor
+		 * and board_name are unique to the GPDwin (in the test set)
+		 * where as only one other board has the same board_version.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+			DMI_MATCH(DMI_BIOS_DATE, "10/25/2016"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+			DMI_MATCH(DMI_BIOS_DATE, "11/18/2016"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "Default string"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Default string"),
+			DMI_MATCH(DMI_BIOS_DATE, "02/21/2017"),
+		},
+	},
+	{ }
+};
+
 static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
 							 const char *uid)
 {
@@ -395,6 +432,13 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
 
+	if (fix_up_power == -1) {
+		if (dmi_check_system(fix_up_power_blacklist))
+			fix_up_power = 0;
+		else
+			fix_up_power = 1;
+	}
+
 	/* Power on the SDHCI controller and its children */
 	if (fix_up_power) {
 		acpi_device_fix_up_power(device);
-- 
2.9.3

