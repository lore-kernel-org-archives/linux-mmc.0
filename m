From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH] mmc: sdio: Fix PM_SLEEP related build warnings
Date: Thu,  9 Aug 2012 11:32:21 +0200
Message-ID: <1344504741-12081-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62355 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab2HIJci (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Aug 2012 05:32:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Power management callbacks defined by SIMPLE_DEV_PM_OPS are only used if
the PM_SLEEP Kconfig symbol has been defined. If not, the compiler will
complain about them being unused. However, since the callback for this
driver doesn't do anything it can just as well be dropped.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/mmc/core/sdio_bus.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 236842e..6bf6879 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -193,14 +193,7 @@ static int sdio_bus_remove(struct device *dev)
 }
 
 #ifdef CONFIG_PM
-
-static int pm_no_operation(struct device *dev)
-{
-	return 0;
-}
-
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_no_operation, pm_no_operation)
 	SET_RUNTIME_PM_OPS(
 		pm_generic_runtime_suspend,
 		pm_generic_runtime_resume,
-- 
1.7.11.4

