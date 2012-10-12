From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/4] MMC: omap_hsmmc: claim pinctrl at probe time
Date: Fri, 12 Oct 2012 12:58:14 +0200
Message-ID: <1350039495-360-4-git-send-email-zonque@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32913 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab2JLK6s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Oct 2012 06:58:48 -0400
In-Reply-To: <1350039495-360-1-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Daniel Mack <zonque@gmail.com>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org

This allows DT-driven board to set up the pin mux only when the driver
is in use.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org
---
 drivers/mmc/host/omap_hsmmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2c57b0d..86f0759 100644
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
@@ -1722,6 +1723,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
+	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1948,6 +1950,11 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			"pins are not configured from the driver\n");
+
 	omap_hsmmc_protect_card(host);
 
 	mmc_add_host(mmc);
-- 
1.7.11.4

