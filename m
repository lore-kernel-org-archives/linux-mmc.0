From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] ACPI / PM: Export acpi_device_fix_up_power()
Date: Thu, 19 May 2016 15:25:41 +0200
Message-ID: <1463664342-19209-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Laszlo Fiat <laszlo.fiat@gmail.com>, Nicholas Krause <xerofoify@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Drivers that needs acpi_device_fix_up_power(), allow them to be built as
modules by exporting this function.

Cc: <stable@vger.kernel.org> # 4.5+
Tested-by: Laszlo Fiat <laszlo.fiat@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Rafael/Len, if you are okay with using acpi_device_fix_up_power() as a fix
for an issue in patch 2/2, then I would like to request an ack so I can take
both these patches via my MMC tree.

---
 drivers/acpi/device_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index cd2c3d6..993fd31 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -319,6 +319,7 @@ int acpi_device_fix_up_power(struct acpi_device *device)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(acpi_device_fix_up_power);
 
 int acpi_device_update_power(struct acpi_device *device, int *state_p)
 {
-- 
1.9.1

