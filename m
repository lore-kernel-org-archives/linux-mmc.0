From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 5/5] mmc: mvsdio: add pinctrl integration
Date: Wed, 16 Jan 2013 14:14:00 +0100
Message-ID: <1358342040-7130-6-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49280 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab3APNOb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Jan 2013 08:14:31 -0500
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On many Marvell SoCs, the pins used for the SDIO interface are part of
the MPP pins, that are muxable pins. In order to get the muxing of
those pins correct, this commit integrates the mvsdio driver with the
pinctrl infrastructure by calling devm_pinctrl_get_select_default()
during ->probe().

Note that we permit this function to fail because not all Marvell
platforms have yet been fully converted to using the pinctrl
infrastructure.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mpl.ch>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/mmc/host/mvsdio.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 5ea0b96..a8b27dd 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -25,6 +25,7 @@
 #include <linux/of_irq.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
@@ -690,6 +691,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret, irq;
 	int gpio_card_detect, gpio_write_protect;
+	struct pinctrl *pinctrl;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
@@ -706,6 +708,10 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "no pins associated\n");
+
 	/* Some non-DT platforms do not pass a clock, and the clock
 	   frequency is passed through platform_data. On DT platforms,
 	   a clock must always be passed, even if there is no gatable
-- 
1.7.10.4

