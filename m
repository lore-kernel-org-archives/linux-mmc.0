From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/17] i2c: nomadik: Convert to late and early system PM callbacks
Date: Tue,  4 Feb 2014 16:58:56 +0100
Message-ID: <1391529538-21685-16-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

At system suspend_late, runtime PM has been disabled by the PM core
which means we can safely operate on these resources. Consequentially
we no longer have to wait until the noirq phase of the system suspend.

Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 2d7dbc9..eda4f0d 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -890,9 +890,8 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-
-#ifdef CONFIG_PM
-static int nmk_i2c_suspend(struct device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int nmk_i2c_suspend_late(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
 	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
@@ -905,7 +904,7 @@ static int nmk_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int nmk_i2c_resume(struct device *dev)
+static int nmk_i2c_resume_early(struct device *dev)
 {
 	/* First go to the default state */
 	pinctrl_pm_select_default_state(dev);
@@ -914,9 +913,6 @@ static int nmk_i2c_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define nmk_i2c_suspend	NULL
-#define nmk_i2c_resume	NULL
 #endif
 
 #if CONFIG_PM
@@ -942,14 +938,8 @@ static int nmk_i2c_runtime_resume(struct device *dev)
 }
 #endif
 
-/*
- * We use noirq so that we suspend late and resume before the wakeup interrupt
- * to ensure that we do the !pm_runtime_suspended() check in resume before
- * there has been a regular pm runtime resume (via pm_runtime_get_sync()).
- */
 static const struct dev_pm_ops nmk_i2c_pm = {
-	.suspend_noirq	= nmk_i2c_suspend,
-	.resume_noirq	= nmk_i2c_resume,
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(nmk_i2c_suspend_late, nmk_i2c_resume_early)
 	SET_PM_RUNTIME_PM_OPS(nmk_i2c_runtime_suspend,
 			nmk_i2c_runtime_resume,
 			NULL)
-- 
1.7.9.5
