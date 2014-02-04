From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 17/17] i2c: nomadik: Fixup system suspend
Date: Tue,  4 Feb 2014 16:58:58 +0100
Message-ID: <1391529538-21685-18-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

For !CONFIG_PM_RUNTIME, the device were never put back into active
state while resuming.

For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
while we were about to handle it at suspend late, which is just too
optimistic.

Even if the driver uses pm_runtime_put_sync() after each tranfer to
return it's runtime PM resources, there are no guarantees this will
actually mean the device will inactivated. The reason is that the PM
core will prevent runtime suspend during system suspend, and thus when
a transfer occurs during the early phases of system suspend the device
will be kept active after the transfer.

To handle both issues above, we need to re-use the runtime PM callbacks
and check the runtime PM state of the device before proceeding with our
operations for system suspend.

Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 2004eea..e6dbe66 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -887,21 +887,36 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 #ifdef CONFIG_PM_SLEEP
 static int nmk_i2c_suspend_late(struct device *dev)
 {
-	struct amba_device *adev = to_amba_device(dev);
-	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
+	if (!pm_runtime_status_suspended(dev)) {
+		int ret = 0;
+		if (dev->pm_domain && dev->pm_domain->ops.runtime_suspend)
+			ret = dev->pm_domain->ops.runtime_suspend(dev);
+		else
+			ret = dev->bus->pm->runtime_suspend(dev);
+		if (ret)
+			return ret;
+
+		pm_runtime_set_suspended(dev);
+	}
 
 	pinctrl_pm_select_sleep_state(dev);
-
 	return 0;
 }
 
 static int nmk_i2c_resume_early(struct device *dev)
 {
-	/* First go to the default state */
-	pinctrl_pm_select_default_state(dev);
-	/* Then let's idle the pins until the next transfer happens */
-	pinctrl_pm_select_idle_state(dev);
+	int ret = 0;
+
+	if (dev->pm_domain && dev->pm_domain->ops.runtime_resume)
+		ret = dev->pm_domain->ops.runtime_resume(dev);
+	else
+		ret = dev->bus->pm->runtime_resume(dev);
+	if (ret) {
+		dev_err(dev, "problem resuming\n");
+		return ret;
+	}
 
+	pm_runtime_set_active(dev);
 	return 0;
 }
 #endif
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
