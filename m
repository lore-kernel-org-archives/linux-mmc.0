From: Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH 3/4] sdio: introduce sdio_platform_pm_ops
Date: Fri, 12 Oct 2012 11:12:40 +0800
Message-ID: <1350011561-21039-4-git-send-email-aaron.lu@intel.com>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Some platform has the ability to set the sdio device into a low power
state with some specific method, e.g. ACPI on x86 based system can use
acpi control methods to change the device's power state.

Considering there may be different platforms utilizing different
mechanisms to achieve this, a new structure is introduced to let
individual platform to use these callbacks to do the job.

The structure contains 4 callbacks:
- is_manageable
  return true when the platform can manage the device's power;
  return false otherwise.
- choose_state
  Choose a proper power state for the device
- set_state
  Set the device's power state
- run_wake
  Enable the device's runtime wakeup capability from the platform's
  perspective.

And 4 functions to wrap these callbacks:
- bool platform_sdio_power_manageable(struct device *dev)
- int platform_sdio_choose_power_state(struct device *dev)
- int platform_sdio_set_power_state(struct device *dev, int state)
- int platform_sdio_run_wake(struct device *dev, bool enable)
So when these callbacks are desired, these wrapper functions should be
used. And if someday some sdio function driver which lives out of the
mmc subsystem has a need to use these wrapper functions, they can be
exported.

sdio_acpi.c implements these callbacks utilizing ACPI code.

The idea of this patch and the definition/wrapper of these callbacks
are heavily based on the one used in PCI subsystem.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/mmc/core/sdio.c      | 37 ++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio.h      | 28 ++++++++++++++++++++++++++
 drivers/mmc/core/sdio_acpi.c | 48 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/core/sdio.h

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index d4619e2..84b01b2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -27,6 +27,7 @@
 #include "sd_ops.h"
 #include "sdio_ops.h"
 #include "sdio_cis.h"
+#include "sdio.h"
 
 static int sdio_read_fbr(struct sdio_func *func)
 {
@@ -1178,3 +1179,39 @@ err:
 	return err;
 }
 
+static struct sdio_platform_pm_ops *sdio_platform_pm;
+
+int sdio_set_platform_pm(struct sdio_platform_pm_ops *ops)
+{
+	if (!ops->is_manageable || !ops->choose_state ||
+			!ops->set_state || !ops->run_wake)
+		return -EINVAL;
+
+	sdio_platform_pm = ops;
+
+	return 0;
+}
+
+bool platform_sdio_power_manageable(struct device *dev)
+{
+	return sdio_platform_pm ?
+		sdio_platform_pm->is_manageable(dev) : false;
+}
+
+int platform_sdio_run_wake(struct device *dev, bool enable)
+{
+	return sdio_platform_pm ?
+		sdio_platform_pm->run_wake(dev, enable) : -ENODEV;
+}
+
+int platform_sdio_choose_power_state(struct device *dev)
+{
+	return sdio_platform_pm ?
+		sdio_platform_pm->choose_state(dev) : SDIO_POWER_ERROR;
+}
+
+int platform_sdio_set_power_state(struct device *dev, int state)
+{
+	return sdio_platform_pm ?
+		sdio_platform_pm->set_state(dev, state) : -ENOSYS;
+}
diff --git a/drivers/mmc/core/sdio.h b/drivers/mmc/core/sdio.h
new file mode 100644
index 0000000..a95929e
--- /dev/null
+++ b/drivers/mmc/core/sdio.h
@@ -0,0 +1,28 @@
+#ifndef __SDIO_H
+#define __SDIO_H
+
+typedef int __bitwise sdio_power_t;
+
+#define SDIO_D0          ((sdio_power_t __force) 0)
+#define SDIO_D1          ((sdio_power_t __force) 1)
+#define SDIO_D2          ((sdio_power_t __force) 2)
+#define SDIO_D3hot       ((sdio_power_t __force) 3)
+#define SDIO_D3cold      ((sdio_power_t __force) 4)
+#define SDIO_UNKNOWN     ((sdio_power_t __force) 5)
+#define SDIO_POWER_ERROR ((sdio_power_t __force) -1)
+
+struct sdio_platform_pm_ops {
+	bool (*is_manageable)(struct device *dev);
+	int (*choose_state)(struct device *dev);
+	int (*set_state)(struct device *dev, sdio_power_t state);
+	int (*run_wake)(struct device *dev, bool enabel);
+};
+
+int sdio_set_platform_pm(struct sdio_platform_pm_ops *ops);
+
+bool platform_sdio_power_manageable(struct device *dev);
+sdio_power_t platform_sdio_choose_power_state(struct device *dev);
+int platform_sdio_set_power_state(struct device *dev, sdio_power_t state);
+int platform_sdio_run_wake(struct device *dev, bool enable);
+
+#endif
diff --git a/drivers/mmc/core/sdio_acpi.c b/drivers/mmc/core/sdio_acpi.c
index 0f92e90..a5b3012 100644
--- a/drivers/mmc/core/sdio_acpi.c
+++ b/drivers/mmc/core/sdio_acpi.c
@@ -4,8 +4,45 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
+#include "sdio.h"
 #include "sdio_bus.h"
 
+static bool acpi_sdio_power_manageable(struct device *dev)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+	return handle ? acpi_bus_power_manageable(handle) : false;
+}
+
+static int acpi_sdio_choose_power_state(struct device *dev)
+{
+	return acpi_pm_device_sleep_state(dev, NULL, ACPI_STATE_D3);
+}
+
+static int acpi_sdio_set_power_state(struct device *dev, int state)
+{
+	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
+
+	if (state < ACPI_STATE_D0 || state > ACPI_STATE_D3_COLD)
+		return -EINVAL;
+
+	if (!handle)
+		return -ENODEV;
+
+	return acpi_bus_set_power(handle, state);
+}
+
+static int acpi_sdio_run_wake(struct device *dev, bool enable)
+{
+	return acpi_pm_device_run_wake(dev, enable);
+}
+
+struct sdio_platform_pm_ops acpi_sdio_platform_pm = {
+	.is_manageable = acpi_sdio_power_manageable,
+	.choose_state = acpi_sdio_choose_power_state,
+	.set_state = acpi_sdio_set_power_state,
+	.run_wake = acpi_sdio_run_wake,
+};
+
 static int acpi_sdio_find_device(struct device *dev, acpi_handle *handle)
 {
 	struct sdio_func *func;
@@ -31,5 +68,14 @@ static struct acpi_bus_type acpi_sdio_bus = {
 
 int sdio_acpi_register(void)
 {
-	return register_acpi_bus_type(&acpi_sdio_bus);
+	int ret;
+
+	ret = register_acpi_bus_type(&acpi_sdio_bus);
+	if (ret)
+		goto out;
+
+	sdio_set_platform_pm(&acpi_sdio_platform_pm);
+
+out:
+	return ret;
 }
-- 
1.7.12.21.g871e293

