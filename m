From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] mmc: sdio: Fix PM_SLEEP related build warnings
Date: Thu,  9 Aug 2012 08:56:53 +0200
Message-ID: <1344495413-7164-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Power management callbacks defined by SIMPLE_DEV_PM_OPS are only used if
the PM_SLEEP Kconfig symbol has been defined. If not, the compiler will
complain about them being unused.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/mmc/core/sdio_bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 236842e..f8f90b4 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -193,11 +193,12 @@ static int sdio_bus_remove(struct device *dev)
 }
 
 #ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 static int pm_no_operation(struct device *dev)
 {
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_no_operation, pm_no_operation)
-- 
1.7.11.4
