From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 04/13] mmc: mxs-mmc: Let device core handle pinctrl
Date: Mon, 6 May 2013 15:05:52 -0300
Message-ID: <1367863561-11534-4-git-send-email-fabio.estevam@freescale.com>
References: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:45632
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754278Ab3EFSGa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 14:06:30 -0400
In-Reply-To: <1367863561-11534-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org
Cc: kernel@pengutronix.de, festevam@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
we can rely on device core for handling pinctrl.

So remove devm_pinctrl_get_select_default() from the driver. 

Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxs-mmc.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4efe302..2f64e5a 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -41,7 +41,6 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/stmp_device.h>
 #include <linux/spi/mxs-spi.h>
 
@@ -592,7 +591,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
 	struct resource *iores, *dmares;
-	struct pinctrl *pinctrl;
 	int ret = 0, irq_err, irq_dma;
 	dma_cap_mask_t mask;
 	struct regulator *reg_vmmc;
@@ -651,12 +649,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		}
 	}
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl)) {
-		ret = PTR_ERR(pinctrl);
-		goto out_mmc_free;
-	}
-
 	ssp->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
 		ret = PTR_ERR(ssp->clk);
-- 
1.7.9.5


