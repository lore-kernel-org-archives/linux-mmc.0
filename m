From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 resend 1/3] mmc: sdhci-acpi: Remove unneeded acpi_bus_get_status() call
Date: Wed, 24 May 2017 12:47:53 +0200
Message-ID: <20170524104755.25274-2-hdegoede@redhat.com>
References: <20170524104755.25274-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939658AbdEXKsB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 May 2017 06:48:01 -0400
In-Reply-To: <20170524104755.25274-1-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org

The acpi-subsys already calls acpi_bus_get_status() and checks that
device->status.present is set before even registering the platform_device
so out probe function will never get called if device->status.present is
false and there is no need for this check.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes in v2:
-This is a new patch replacing "mmc: sdhci-acpi: Check device status
 before calling fix_up_power()"
---
 drivers/mmc/host/sdhci-acpi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index c6a9a1bfaa22..89d9a8c014f5 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -396,9 +396,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		if (child->status.present && child->status.enabled)
 			acpi_device_fix_up_power(child);
 
-	if (acpi_bus_get_status(device) || !device->status.present)
-		return -ENODEV;
-
 	if (sdhci_acpi_byt_defer(dev))
 		return -EPROBE_DEFER;
 
-- 
2.13.0

