From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 2/5] mmc: mvsdio: use slot-gpio infrastructure for write protect gpio
Date: Wed, 16 Jan 2013 14:13:57 +0100
Message-ID: <1358342040-7130-3-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49301 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142Ab3APNOv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Jan 2013 08:14:51 -0500
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The MMC core subsystem provides in drivers/mmc/core/slot-gpio.c a nice
set of helper functions to simplify the management of the write
protect GPIO in MMC host drivers. This patch migrates the mvsdio
driver to using those helpers, which will make the ->probe() code
simpler, and therefore ease the process of adding a Device Tree
binding for this driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mpl.ch>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/mmc/host/mvsdio.c |   30 +++++-------------------------
 1 file changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index f8dd361..c6dc8fd 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
@@ -52,7 +53,6 @@ struct mvsd_host {
 	struct device *dev;
 	struct clk *clk;
 	int gpio_card_detect;
-	int gpio_write_protect;
 };
 
 #define mvsd_write(offs, val)	writel(val, iobase + (offs))
@@ -564,20 +564,6 @@ static void mvsd_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int mvsd_get_ro(struct mmc_host *mmc)
-{
-	struct mvsd_host *host = mmc_priv(mmc);
-
-	if (host->gpio_write_protect)
-		return gpio_get_value(host->gpio_write_protect);
-
-	/*
-	 * Board doesn't support read only detection; let the mmc core
-	 * decide what to do.
-	 */
-	return -ENOSYS;
-}
-
 static void mvsd_power_up(struct mvsd_host *host)
 {
 	void __iomem *iobase = host->base;
@@ -674,7 +660,7 @@ static void mvsd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 static const struct mmc_host_ops mvsd_ops = {
 	.request		= mvsd_request,
-	.get_ro			= mvsd_get_ro,
+	.get_ro			= mmc_gpio_get_ro,
 	.set_ios		= mvsd_set_ios,
 	.enable_sdio_irq	= mvsd_enable_sdio_irq,
 };
@@ -793,15 +779,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (!host->gpio_card_detect)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
-	if (mvsd_data->gpio_write_protect) {
-		ret = devm_gpio_request_one(&pdev->dev,
-					    mvsd_data->gpio_write_protect,
-					    GPIOF_IN, DRIVER_NAME " wp");
-		if (ret == 0) {
-			host->gpio_write_protect =
-				mvsd_data->gpio_write_protect;
-		}
-	}
+	mmc_gpio_request_ro(mmc, mvsd_data->gpio_write_protect);
 
 	setup_timer(&host->timer, mvsd_timeout_timer, (unsigned long)host);
 	platform_set_drvdata(pdev, mmc);
@@ -820,6 +798,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 out:
 	if (mmc) {
+		mmc_gpio_free_ro(mmc);
 		if (!IS_ERR(host->clk))
 			clk_disable_unprepare(host->clk);
 		mmc_free_host(mmc);
@@ -834,6 +813,7 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 
 	struct mvsd_host *host = mmc_priv(mmc);
 
+	mmc_gpio_free_ro(mmc);
 	mmc_remove_host(mmc);
 	del_timer_sync(&host->timer);
 	mvsd_power_down(host);
-- 
1.7.10.4

