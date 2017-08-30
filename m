From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/2] driver core: detach device's pm_domain after devres_release_all
Date: Wed, 30 Aug 2017 09:34:26 +0800
Message-ID: <1504056867-199188-2-git-send-email-shawn.lin@rock-chips.com>
References: <1504056867-199188-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1504056867-199188-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

The intention of this patch is to move dev_pm_domain_detach after
devres_release_all to avoid possible accessing device's registers
with genpd been powered off.

Many common IP drivers use devm_request_irq to request irq for either
shared irq or non-shared irq. So we rely on devres_release_all to
free irq automatically. However we could see a situation that if the
driver use devm_request_irq to register a shared irq and unbind the
driver later, the irq could be triggerd cocurrently just between
finishing dev_pm_domain_detach and calling devm_irq_release, so that
driver's ISR should be called and try to access device's register, which
may hang up the system. The reason is that some SoCs, including Rockchips'
SoCs, couldn't support accessing controllers' registers w/o clk and power
domain enabled.

Also we have CONFIG_DEBUG_SHIRQ to theoretically expose this kind of
problem as devm_free_irq -> __free_irq says: "It's a shared IRQ -- the
driver ought to be prepared for an IRQ event to happen even now it's being
freed". That will simulate the aforementioned situation as it fires
extra irq action to make sure driver/system is robust enough to deal
with this kind of problem.

So now we face a two possible choices to fix this by
(1) either using request_irq and free_irq directly
(2) or moving dev_pm_domain_detach after devres_release_all which
makes sure we free the irq before powering off power domain.

However, choice (1) implies that devm_request_irq shouldn't exist
or at least shouldn't be used for shared irq case. Meanwhile we don't
know how many drivers have this kind of issue and need to fix. So
choice (2) makes more sense to me, and that is the reason for why we
need to fix it like what this patch does.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3:
- fix the code path for consolidating the attach for both of driver
  and bus driver, and then move detach to the error path
- rework the changelog

 drivers/base/dd.c       | 16 ++++++++++++++++
 drivers/base/platform.c | 18 ++----------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index ad44b40..aea0bb1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,7 +25,9 @@
 #include <linux/kthread.h>
 #include <linux/wait.h>
 #include <linux/async.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/pinctrl/devinfo.h>
 
 #include "base.h"
@@ -356,6 +358,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	int local_trigger_count = atomic_read(&deferred_trigger_count);
 	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
 			   !drv->suppress_bind_attrs;
+	struct platform_driver *pdrv;
 
 	if (defer_all_probes) {
 		/*
@@ -409,6 +412,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	 */
 	devices_kset_move_last(dev);
 
+	ret = dev_pm_domain_attach(dev, true);
+	pdrv = to_platform_driver(dev->driver);
+	/* don't fail if just dev_pm_domain_attach failed */
+	if (pdrv && pdrv->prevent_deferred_probe &&
+	    ret == -EPROBE_DEFER) {
+		dev_warn(dev, "probe deferral not supported\n");
+		ret = -ENXIO;
+		goto probe_failed;
+	}
+
 	if (dev->bus->probe) {
 		ret = dev->bus->probe(dev);
 		if (ret)
@@ -428,6 +441,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			drv->remove(dev);
 
 		devres_release_all(dev);
+		dev_pm_domain_detach(dev, true);
 		driver_sysfs_remove(dev);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
@@ -458,6 +472,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
 	devres_release_all(dev);
+	dev_pm_domain_detach(dev, true);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 	dev_set_drvdata(dev, NULL);
@@ -864,6 +879,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		dma_deconfigure(dev);
 
 		devres_release_all(dev);
+		dev_pm_domain_detach(dev, true);
 		dev->driver = NULL;
 		dev_set_drvdata(dev, NULL);
 		if (dev->pm_domain && dev->pm_domain->dismiss)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d1bd992..8fa688d 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -572,22 +572,8 @@ static int platform_drv_probe(struct device *_dev)
 	if (ret < 0)
 		return ret;
 
-	ret = dev_pm_domain_attach(_dev, true);
-	if (ret != -EPROBE_DEFER) {
-		if (drv->probe) {
-			ret = drv->probe(dev);
-			if (ret)
-				dev_pm_domain_detach(_dev, true);
-		} else {
-			/* don't fail if just dev_pm_domain_attach failed */
-			ret = 0;
-		}
-	}
-
-	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
-		dev_warn(_dev, "probe deferral not supported\n");
-		ret = -ENXIO;
-	}
+	if (drv->probe)
+		ret = drv->probe(dev);
 
 	return ret;
 }
-- 
1.9.1
