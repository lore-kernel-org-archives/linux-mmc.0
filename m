From: Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH 4/4] sdio: pm: set device's power state after driver runtime suspended it
Date: Fri, 12 Oct 2012 11:12:41 +0800
Message-ID: <1350011561-21039-5-git-send-email-aaron.lu@intel.com>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>
List-Id: linux-mmc@vger.kernel.org

In sdio bus level runtime callback function, after call the driver's
runtime suspend callback, we will check if the device supports a
platform level power management, and if so, a proper power state is
chosen by the corresponding platform callback and then set.

Platform level runtime wakeup is also set, if device is enabled for
runtime wakeup by its driver, it will be armed the ability to generate
a wakeup event by the platform.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/mmc/core/sdio_bus.c | 49 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index aaec9e2..d83dea8 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -23,6 +23,7 @@
 
 #include "sdio_cis.h"
 #include "sdio_bus.h"
+#include "sdio.h"
 #include "sdio_acpi.h"
 
 /* show configuration fields */
@@ -194,10 +195,54 @@ static int sdio_bus_remove(struct device *dev)
 }
 
 #ifdef CONFIG_PM
+
+static int sdio_bus_runtime_suspend(struct device *dev)
+{
+	int ret;
+	sdio_power_t state;
+
+	ret = pm_generic_runtime_suspend(dev);
+	if (ret)
+		goto out;
+
+	if (!platform_sdio_power_manageable(dev))
+		goto out;
+
+	platform_sdio_run_wake(dev, true);
+
+	state = platform_sdio_choose_power_state(dev);
+	if (state == SDIO_POWER_ERROR) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = platform_sdio_set_power_state(dev, state);
+
+out:
+	return ret;
+}
+
+static int sdio_bus_runtime_resume(struct device *dev)
+{
+	int ret;
+
+	if (platform_sdio_power_manageable(dev)) {
+		platform_sdio_run_wake(dev, false);
+		ret = platform_sdio_set_power_state(dev, SDIO_D0);
+		if (ret)
+			goto out;
+	}
+
+	ret = pm_generic_runtime_resume(dev);
+
+out:
+	return ret;
+}
+
 static const struct dev_pm_ops sdio_bus_pm_ops = {
 	SET_RUNTIME_PM_OPS(
-		pm_generic_runtime_suspend,
-		pm_generic_runtime_resume,
+		sdio_bus_runtime_suspend,
+		sdio_bus_runtime_resume,
 		pm_generic_runtime_idle
 	)
 };
-- 
1.7.12.21.g871e293

