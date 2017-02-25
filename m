From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/3] mmc: sdhci-acpi: Add a quirk to not break wifi on GPD WIN I55 machines
Date: Sat, 25 Feb 2017 18:23:57 +0100
Message-ID: <20170225172357.26294-4-hdegoede@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170225172357.26294-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The GPD WIN (I55) has a bug in its ACPI tables where putting the unused
80860F14 UID 2 (SDIO) device in PS0 toggles a gpio disabling the pcie wifi
until the next reboot.

Add a quirk to skip probing of the unused SDIO controller, fixing this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 873beae..957d0b8 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -36,6 +36,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/pm.h>
@@ -397,6 +398,18 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_status(device) || !device->status.present)
 		return -ENODEV;
 
+	hid = acpi_device_hid(device);
+	uid = device->pnp.unique_id;
+
+	/*
+	 * The GPD WIN (I55) has a bug in its ACPI tables where putting the
+	 * unused 80860F14 UID 2 (SDIO) device in PS0 toggles a gpio
+	 * disabling the pcie wifi.
+	 */
+	if (strcmp(hid, "80860F14") == 0 && strcmp(uid, "2") == 0 &&
+			dmi_match(DMI_PRODUCT_NAME, "GPD-WINI55"))
+		return -ENODEV;
+
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
 	list_for_each_entry(child, &device->children, node)
@@ -406,9 +419,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-	hid = acpi_device_hid(device);
-	uid = device->pnp.unique_id;
-
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem)
 		return -ENOMEM;
-- 
2.9.3
