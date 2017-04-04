From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] mmc: sdhci-acpi: Remove unneeded acpi_bus_get_status() call
Date: Tue,  4 Apr 2017 10:50:11 +0200
Message-ID: <20170404085013.19837-2-hdegoede@redhat.com>
References: <20170404085013.19837-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbdDDIuS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Apr 2017 04:50:18 -0400
In-Reply-To: <20170404085013.19837-1-hdegoede@redhat.com>
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

