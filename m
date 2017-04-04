From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] mmc: sdhci-acpi: Add fix_up_power module option
Date: Tue,  4 Apr 2017 10:50:12 +0200
Message-ID: <20170404085013.19837-3-hdegoede@redhat.com>
References: <20170404085013.19837-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752076AbdDDIuT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Apr 2017 04:50:19 -0400
In-Reply-To: <20170404085013.19837-1-hdegoede@redhat.com>
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

This commit adds a new sdhci_acpi.fix_up_power module option which
defaults to 1 (leaving the existing behavior intact) and can be set
to 0 disable the calling of acpi_device_fix_up_power() fixing the
wifi not working on this machine.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9fd8d7a..8fe46ba 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -83,6 +83,8 @@ struct sdhci_acpi_host {
 	bool				use_runtime_pm;
 };
 
+static int fix_up_power = 1;
+
 static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 {
 	return c->slot && (c->slot->flags & flag);
@@ -394,10 +396,12 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
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
@@ -575,6 +579,10 @@ static struct platform_driver sdhci_acpi_driver = {
 
 module_platform_driver(sdhci_acpi_driver);
 
+module_param(fix_up_power, int, 0444);
+MODULE_PARM_DESC(fix_up_power,
+		 "Call acpi_device_fix_up_power on sdio host and its children");
+
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface ACPI driver");
 MODULE_AUTHOR("Adrian Hunter");
 MODULE_LICENSE("GPL v2");
-- 
2.9.3

