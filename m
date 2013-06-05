From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/3] mmc: dw: don't check resource with devm_ioremap_resource
Date: Wed,  5 Jun 2013 12:24:10 +0300
Message-ID: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:15377 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753552Ab3FEJYT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jun 2013 05:24:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pltfm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 37873f1..526abae 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -25,7 +25,7 @@
 #include "dw_mmc.h"
 
 int dw_mci_pltfm_register(struct platform_device *pdev,
-				const struct dw_mci_drv_data *drv_data)
+			  const struct dw_mci_drv_data *drv_data)
 {
 	struct dw_mci *host;
 	struct resource	*regs;
@@ -35,10 +35,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	if (!host)
 		return -ENOMEM;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs)
-		return -ENXIO;
-
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0)
 		return host->irq;
@@ -47,6 +43,8 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	host->dev = &pdev->dev;
 	host->irq_flags = 0;
 	host->pdata = pdev->dev.platform_data;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, regs);
 	if (IS_ERR(host->regs))
 		return PTR_ERR(host->regs);
-- 
1.8.2.rc0.22.gb3600c3

