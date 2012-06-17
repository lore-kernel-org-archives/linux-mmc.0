From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH v3 2/2] mmc: mmci.c: Remove wrong error handling of gpio 0
Date: Sun, 17 Jun 2012 12:11:33 +0200
Message-ID: <1339927893-8842-3-git-send-email-stigge@antcom.de>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1339927893-8842-1-git-send-email-stigge@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org
Cc: Roland Stigge <stigge@antcom.de>
List-Id: linux-mmc@vger.kernel.org

Zero is a valid GPIO and shouldn't be handled as an error return code from
of_get_named_gpio(). It was a leftover from old code before getting
pdata->gpio_*() was modified.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/mmc/host/mmci.c |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.orig/drivers/mmc/host/mmci.c
+++ linux-2.6/drivers/mmc/host/mmci.c
@@ -1216,12 +1216,7 @@ static void mmci_dt_populate_generic_pda
 	int bus_width = 0;
 
 	pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
-	if (!pdata->gpio_wp)
-		pdata->gpio_wp = -1;
-
 	pdata->gpio_cd = of_get_named_gpio(np, "cd-gpios", 0);
-	if (!pdata->gpio_cd)
-		pdata->gpio_cd = -1;
 
 	if (of_get_property(np, "cd-inverted", NULL))
 		pdata->cd_invert = true;
