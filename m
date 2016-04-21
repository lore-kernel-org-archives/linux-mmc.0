From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: sdhci-of-at91: add presets setup
Date: Thu, 21 Apr 2016 15:54:06 +0200
Message-ID: <1461246846-30925-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:8531 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbcDUNxj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 09:53:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

The controller claims to support SDR104. In fact, it only supports a
degraded SDR104 since the maximum frequency of the SD clock is 120 MHz
instead of 208 MHz.
The sdhci core is unaware of it and will compute a wrong clock divider.
We can deal with this specific case by using presets.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index c1923c0..76308b1 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/module.h>
@@ -163,6 +164,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	unsigned int			clk_base, clk_mul;
 	unsigned int			gck_rate, real_gck_rate;
 	int				ret;
+	unsigned int			preset_div, preset_common = 0x400; /* drv type B, programmable clock mode */
 
 	match = of_match_device(sdhci_at91_dt_match, &pdev->dev);
 	if (!match)
@@ -230,6 +232,28 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 			 clk_mul, real_gck_rate);
 	}
 
+	/*
+	 * We have to set preset values because it depends on the clk_mul
+	 * value. Moreover, SDR104 is supported in a degraded mode since the
+	 * maximum sd clock value is 120 MHz instead of 208 MHz. For that
+	 * reason, we need to use presets to support SDR104.
+	 */
+	preset_div = DIV_ROUND_UP(real_gck_rate, 24000000) - 1;
+	writew(preset_common | preset_div,
+	       host->ioaddr + SDHCI_PRESET_FOR_SDR12);
+	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
+	writew(preset_common | preset_div,
+	       host->ioaddr + SDHCI_PRESET_FOR_SDR25);
+	preset_div = DIV_ROUND_UP(real_gck_rate, 100000000) - 1;
+	writew(preset_common | preset_div,
+	       host->ioaddr + SDHCI_PRESET_FOR_SDR50);
+	preset_div = DIV_ROUND_UP(real_gck_rate, 120000000) - 1;
+	writew(preset_common | preset_div,
+	       host->ioaddr + SDHCI_PRESET_FOR_SDR104);
+	preset_div = DIV_ROUND_UP(real_gck_rate, 50000000) - 1;
+	writew(preset_common | preset_div,
+	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
+
 	clk_prepare_enable(priv->mainck);
 	clk_prepare_enable(priv->gck);
 
-- 
2.5.0

