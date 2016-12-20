From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] mmc: sdhci-acpi: Only powered up enabled acpi child devices
Date: Wed, 21 Dec 2016 00:19:19 +0100
Message-ID: <20161220231919.10458-1-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752767AbcLTXTX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 20 Dec 2016 18:19:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Commit e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are
powered when probing") introduced code to powerup any acpi child
nodes listed in the dstd. But some dstd-s list all possible devices
used on some board variants, while reporting if the device is actually
present and enabled in the status field of the device.

So we end up calling the acpi _PS0 (power-on) method for devices which
are not actually present. This does not always end well, e.g. on my
cube iwork8 air tablet, this results in freezing the entire tablet as
soon as the r8723bs module is loaded.

This commit fixes this by checking the child device's status.present
and status.enabled bits and only call acpi_device_fix_up_power()
if both are set.

Fixes: e5bbf30733f9 ("mmc: sdhci-acpi: Ensure connected devices are powered when probing")
BugLink: https://github.com/hadess/rtl8723bs/issues/80
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sdhci-acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 92096db..34ee237 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -396,7 +396,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	/* Power on the SDHCI controller and its children */
 	acpi_device_fix_up_power(device);
 	list_for_each_entry(child, &device->children, node)
-		acpi_device_fix_up_power(child);
+		if (child->status.present && child->status.enabled)
+			acpi_device_fix_up_power(child);
 
 	if (acpi_bus_get_status(device) || !device->status.present)
 		return -ENODEV;
-- 
2.9.3

