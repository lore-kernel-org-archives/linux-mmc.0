From: Shuah Khan <shuah.kh@samsung.com>
Subject: [RFT][PATCH 10/12] mmc: change tmio_mmc platform power management to use dev_pm_ops
Date: Mon, 10 Feb 2014 09:15:04 -0700
Message-ID: <e0668e4c3737e44854a42ee273a37e2161f40b13.1392040068.git.shuah.kh@samsung.com>
References: <cover.1392040064.git.shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1392040064.git.shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, ian@mnementh.co.uk, chris@printf.net
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-mmc@vger.kernel.org

Change tmio_mmc platform driver to register pm ops using dev_pm_ops instead
of legacy pm_ops. .pm hooks call existing legacy suspend and resume interfaces
by passing in the right pm state.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/mmc/host/tmio_mmc.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 1900abb..e9b0a06 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -24,7 +24,7 @@
 #include "tmio_mmc.h"
 
 #ifdef CONFIG_PM
-static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
+static int __tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
 {
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	int ret;
@@ -38,7 +38,22 @@ static int tmio_mmc_suspend(struct platform_device *dev, pm_message_t state)
 	return ret;
 }
 
-static int tmio_mmc_resume(struct platform_device *dev)
+static int tmio_mmc_suspend(struct device *dev)
+{
+	return __tmio_mmc_suspend(to_platform_device(dev), PMSG_SUSPEND);
+}
+
+static int tmio_mmc_freeze(struct device *dev)
+{
+	return __tmio_mmc_suspend(to_platform_device(dev), PMSG_FREEZE);
+}
+
+static int tmio_mmc_poweroff(struct device *dev)
+{
+	return __tmio_mmc_suspend(to_platform_device(dev), PMSG_HIBERNATE);
+}
+
+static int __tmio_mmc_resume(struct platform_device *dev)
 {
 	const struct mfd_cell *cell = mfd_get_cell(dev);
 	int ret = 0;
@@ -52,9 +67,21 @@ static int tmio_mmc_resume(struct platform_device *dev)
 
 	return ret;
 }
-#else
-#define tmio_mmc_suspend NULL
-#define tmio_mmc_resume NULL
+
+static int tmio_mmc_resume(struct device *dev)
+{
+	return __tmio_mmc_resume(to_platform_device(dev));
+}
+
+static const struct dev_pm_ops tmio_mmc_dev_pm_ops = {
+	.suspend = tmio_mmc_suspend,
+	.resume = tmio_mmc_resume,
+	/* Hibernate hooks */
+	.freeze = tmio_mmc_freeze,
+	.thaw = tmio_mmc_resume,
+	.poweroff = tmio_mmc_poweroff,
+	.restore = tmio_mmc_resume,
+};
 #endif
 
 static int tmio_mmc_probe(struct platform_device *pdev)
@@ -138,11 +165,12 @@ static struct platform_driver tmio_mmc_driver = {
 	.driver = {
 		.name = "tmio-mmc",
 		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &tmio_mmc_dev_pm_ops,
+#endif
 	},
 	.probe = tmio_mmc_probe,
 	.remove = tmio_mmc_remove,
-	.suspend = tmio_mmc_suspend,
-	.resume = tmio_mmc_resume,
 };
 
 module_platform_driver(tmio_mmc_driver);
-- 
1.7.10.4
