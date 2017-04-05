From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/3] mmc: sdhci-acpi: Remove unneeded acpi_bus_get_status() call
Date: Wed,  5 Apr 2017 15:00:05 +0200
Message-ID: <20170405130007.5826-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755112AbdDENAR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Apr 2017 09:00:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Takashi Iwai <tiwai@suse.de>, linux-mmc@vger.kernel.org

The acpi-subsys already calls acpi_bus_get_status() and checks that
device->status.present is set before even registering the platform_device
so out probe function will never get called if device->status.present is
false and there is no need for this check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch replacing "mmc: sdhci-acpi: Check device status
 before calling fix_up_power()"
---
 drivers/mmc/host/sdhci-acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 237f318..9fd8d7a 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -399,9 +399,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		if (child->status.present && child->status.enabled)
 			acpi_device_fix_up_power(child);
 
-	if (acpi_bus_get_status(device) || !device->status.present)
-		return -ENODEV;
-
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-- 
2.9.3

