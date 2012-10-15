From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/4] MMC: omap_hsmmc: claim pinctrl at probe time
Date: Mon, 15 Oct 2012 21:35:05 +0530
Message-ID: <1350317108-10657-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab2JOQFS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 12:05:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Venkatraman S <svenkatr@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>

From: Daniel Mack <zonque@gmail.com>

This allows DT-driven board to set up the pin mux only when the driver
is in use.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 54bfd0c..01eeeae 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -37,6 +37,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <plat/mmc.h>
@@ -1720,6 +1721,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
+	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1923,6 +1925,11 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			"pins are not configured from the driver\n");
+
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
-- 
1.7.11.1.25.g0e18bef

