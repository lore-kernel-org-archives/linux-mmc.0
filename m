From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
Date: Mon, 22 Apr 2013 21:54:58 +0200
Message-ID: <1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57873 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab3DVTzU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Apr 2013 15:55:20 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm14so1871345wib.5
        for <linux-mmc@vger.kernel.org>; Mon, 22 Apr 2013 12:55:19 -0700 (PDT)
In-Reply-To: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: jason@lakedaemon.net, andrew@lunn.ch, cjb@laptop.org, thomas.petazzoni@free-electrons.com

The slot-gpio helper functions allow to specify whether card detect and
write protect GPIO lines are active high or active low.  Since DT
allows to specify active low/high for GPIO lines as well, we can simply
initialize the flags for slot-gpio using the GPIO flags to support all
cases.

We need to adapt the dts files that use CD/WP via GPIO accordingly.
Only the dts for "MPL CEC4" is affected by this change.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 arch/arm/boot/dts/kirkwood-mplcec4.dts |    2 +-
 drivers/mmc/host/mvsdio.c              |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 7588241..bf3a58c 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -136,7 +136,7 @@
 			pinctrl-0 = <&pmx_sdio &pmx_sdio_cd>;
 			pinctrl-names = "default";
 			status = "okay";
-			cd-gpios = <&gpio1 15 0>;
+			cd-gpios = <&gpio1 15 1>;
 			/* No WP GPIO */
 		};
 	};
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 145cdaf..d444efd 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -691,6 +691,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret, irq;
 	int gpio_card_detect, gpio_write_protect;
+	enum of_gpio_flags gpio_flags;
 	struct pinctrl *pinctrl;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -731,8 +732,17 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		}
 
 		host->base_clock = clk_get_rate(host->clk) / 2;
-		gpio_card_detect = of_get_named_gpio(np, "cd-gpios", 0);
-		gpio_write_protect = of_get_named_gpio(np, "wp-gpios", 0);
+		gpio_card_detect = of_get_named_gpio_flags(np, "cd-gpios", 0,
+						     &gpio_flags);
+		if (gpio_is_valid(gpio_card_detect) &&
+		    !(gpio_flags & OF_GPIO_ACTIVE_LOW))
+			mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
+		gpio_write_protect = of_get_named_gpio_flags(np, "wp-gpios", 0,
+						       &gpio_flags);
+		if (gpio_is_valid(gpio_write_protect) &&
+		    !(gpio_flags & OF_GPIO_ACTIVE_LOW))
+			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 	} else {
 		const struct mvsdio_platform_data *mvsd_data;
 		mvsd_data = pdev->dev.platform_data;
-- 
1.7.9.5

