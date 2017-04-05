From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 2/3] mmc: sdhci-acpi: Add fix_up_power_blacklist module option
Date: Wed,  5 Apr 2017 15:00:06 +0200
Message-ID: <20170405130007.5826-2-hdegoede@redhat.com>
References: <20170405130007.5826-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933174AbdDENAT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Apr 2017 09:00:19 -0400
In-Reply-To: <20170405130007.5826-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
powered when probing") introduced unconditional calling of
acpi_device_fix_up_power() on the mmc controller and its children.

This broke wifi on some systems because acpi_device_fix_up_power()
was called even for disabled children sometimes leaving gpio-s in
a state where wifi would not work, this was fixed in
commit e1d070c3793a ("mmc: sdhci-acpi: Only powered up enabled acpi
child devices").

Unfortunately on some devices calling acpi_device_fix_up_power()
still causes issues. Specifically on the GPDwin mini clam-shell PC
which has a pcie wifi module, it causes the wifi module to get
turned off. This is a BIOS bug and I've tried to get the manufacturer
to fix this but sofar they have not responded (and even if they do
then we cannot assume all users will update their BIOS).

This commit adds a new sdhci_acpi.fix_up_power_blacklist module option
which can be set to an ACPI hid:uid pair, e.g. "80860F14:2" to disable
the calling of acpi_device_fix_up_power() for the sdhci host matching
the hid:uid pair, fixing the wifi not working on this machine.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Make the module option take a hid:uid pair string, instead of it
 being a boolean option, so that it only applies to one host
---
 drivers/mmc/host/sdhci-acpi.c | 48 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9fd8d7a..5a73174 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -83,6 +83,29 @@ struct sdhci_acpi_host {
 	bool				use_runtime_pm;
 };
 
+static char *fix_up_power_blacklist;
+
+static bool sdhci_acpi_compare_hid_uid(const char *match, const char *hid,
+				       const char *uid)
+{
+	const char *sep;
+
+	if (!match)
+		return false;
+
+	sep = strchr(match, ':');
+	if (!match)
+		return false;
+
+	if (strncmp(match, hid, sep - match))
+		return false;
+
+	if (strcmp(sep + 1, uid))
+		return false;
+
+	return true;
+}
+
 static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 {
 	return c->slot && (c->slot->flags & flag);
@@ -381,6 +404,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
+	const char *fix_up_power_bl = fix_up_power_blacklist;
+	bool fix_up_power = true;
 	struct acpi_device *device, *child;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
@@ -393,18 +418,23 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
 
+	hid = acpi_device_hid(device);
+	uid = device->pnp.unique_id;
+
+	if (sdhci_acpi_compare_hid_uid(fix_up_power_bl, hid, uid))
+		fix_up_power = false;
+
 	/* Power on the SDHCI controller and its children */
-	acpi_device_fix_up_power(device);
-	list_for_each_entry(child, &device->children, node)
-		if (child->status.present && child->status.enabled)
-			acpi_device_fix_up_power(child);
+	if (fix_up_power) {
+		acpi_device_fix_up_power(device);
+		list_for_each_entry(child, &device->children, node)
+			if (child->status.present && child->status.enabled)
+				acpi_device_fix_up_power(child);
+	}
 
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-	hid = acpi_device_hid(device);
-	uid = device->pnp.unique_id;
-
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem)
 		return -ENOMEM;
@@ -575,6 +605,10 @@ static struct platform_driver sdhci_acpi_driver = {
 
 module_platform_driver(sdhci_acpi_driver);
 
+module_param(fix_up_power_blacklist, charp, 0444);
+MODULE_PARM_DESC(fix_up_power,
+		 "ACPI HID:UID for which to not call acpi_device_fix_up_power");
+
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface ACPI driver");
 MODULE_AUTHOR("Adrian Hunter");
 MODULE_LICENSE("GPL v2");
-- 
2.9.3

