From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/3] mmc: sdhci-acpi: Check device status before calling fix_up_power()
Date: Sat, 25 Feb 2017 18:23:56 +0100
Message-ID: <20170225172357.26294-3-hdegoede@redhat.com>
References: <20170225172357.26294-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751559AbdBYRYF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 25 Feb 2017 12:24:05 -0500
In-Reply-To: <20170225172357.26294-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jean Delvare <jdelvare@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Calling acpi_device_fix_up_power() on a device which is not present
is not a good idea.

While at it also call acpi_bus_get_status() on the children before
the status check to make sure that child->status contains valid data.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 96465ff..873beae 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -394,15 +394,15 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
 
+	if (acpi_bus_get_status(device) || !device->status.present)
+		return -ENODEV;
+
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
 	list_for_each_entry(child, &device->children, node)
 		if (child->status.present && child->status.enabled)
 			acpi_device_fix_up_power(child);
 
-	if (acpi_bus_get_status(device) || !device->status.present)
-		return -ENODEV;
-
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-- 
2.9.3

