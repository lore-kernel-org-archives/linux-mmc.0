From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] sdhci: acpi: Use new method to get ACPI companion
Date: Mon, 24 Jul 2017 17:59:58 +0300
Message-ID: <20170724145958.34478-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64674 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753556AbdGXPAC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 11:00:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

ACPI_COMPANION() macro reduces a code to get a companion device out of
struct device.

Use it instead of an old method.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index ac678e9fb19a..4bbce8919c30 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -432,7 +432,6 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	acpi_handle handle = ACPI_HANDLE(dev);
 	struct acpi_device *device, *child;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
@@ -442,7 +441,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	const char *uid;
 	int err;
 
-	if (acpi_bus_get_device(handle, &device))
+	device = ACPI_COMPANION(dev);
+	if (!device)
 		return -ENODEV;
 
 	hid = acpi_device_hid(device);
-- 
2.13.2

