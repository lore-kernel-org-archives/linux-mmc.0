From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-acpi: Ensure connected devices are powered when probing
Date: Thu, 19 May 2016 15:25:42 +0200
Message-ID: <1463664342-19209-2-git-send-email-ulf.hansson@linaro.org>
References: <1463664342-19209-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1463664342-19209-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Laszlo Fiat <laszlo.fiat@gmail.com>, Nicholas Krause <xerofoify@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Some devices connected to the SDHCI controller may have separate enabling
lines that are controlled through GPIO. These devices need to be powered
on and enabled before probing. This is to ensure all devices connected can
be seen by the controller.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Laszlo Fiat <laszlo.fiat@gmail.com>
Cc: <stable@vger.kernel.org> # 4.5+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index b2d70ba..2d1c4870 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -378,7 +378,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	acpi_handle handle = ACPI_HANDLE(dev);
-	struct acpi_device *device;
+	struct acpi_device *device, *child;
 	struct sdhci_acpi_host *c;
 	struct sdhci_host *host;
 	struct resource *iomem;
@@ -390,6 +390,11 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (acpi_bus_get_device(handle, &device))
 		return -ENODEV;
 
+	/* Power on the SDHCI controller and its children */
+	acpi_device_fix_up_power(device);
+	list_for_each_entry(child, &device->children, node)
+		acpi_device_fix_up_power(child);
+
 	if (acpi_bus_get_status(device) || !device->status.present)
 		return -ENODEV;
 
-- 
1.9.1

