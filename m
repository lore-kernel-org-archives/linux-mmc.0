From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/3] mmc: host: don't use devm_pinctrl_get_select_default() in probe
Date: Mon, 22 Dec 2014 23:16:54 +0100
Message-ID: <1419286616-9893-2-git-send-email-wsa@the-dreams.de>
References: <1419286616-9893-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419286616-9893-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Since commit ab78029ecc34 (drivers/pinctrl: grab default handles from device
core), we can rely on device core for setting the default pins.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/mmc/host/mvsdio.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 4f8618f4522d..a2cb92851f1f 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -25,7 +25,6 @@
 #include <linux/of_irq.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/slot-gpio.h>
-#include <linux/pinctrl/consumer.h>
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
@@ -704,7 +703,6 @@ static int mvsd_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct resource *r;
 	int ret, irq;
-	struct pinctrl *pinctrl;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
@@ -721,10 +719,6 @@ static int mvsd_probe(struct platform_device *pdev)
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev, "no pins associated\n");
-
 	/*
 	 * Some non-DT platforms do not pass a clock, and the clock
 	 * frequency is passed through platform_data. On DT platforms,
-- 
2.1.3
