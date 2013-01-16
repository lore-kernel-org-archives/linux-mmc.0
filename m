From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 3/5] mmc: mvsdio: use slot-gpio for card detect gpio
Date: Wed, 16 Jan 2013 14:13:58 +0100
Message-ID: <1358342040-7130-4-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49309 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753526Ab3APNPA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Jan 2013 08:15:00 -0500
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The MMC core subsystem provides in drivers/mmc/core/slot-gpio.c a nice
set of helper functions to simplify the management of the card detect
GPIO in MMC host drivers. This patch migrates the mvsdio driver to
using those helpers, which will make the ->probe() code simpler, and
therefore ease the process of adding a Device Tree binding for this
driver.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Stefan Peter <s.peter@mpl.ch>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/mmc/host/mvsdio.c |   39 +++++++++------------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index c6dc8fd..704b7a3 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -52,7 +52,6 @@ struct mvsd_host {
 	struct mmc_host *mmc;
 	struct device *dev;
 	struct clk *clk;
-	int gpio_card_detect;
 };
 
 #define mvsd_write(offs, val)	writel(val, iobase + (offs))
@@ -538,13 +537,6 @@ static void mvsd_timeout_timer(unsigned long data)
 		mmc_request_done(host->mmc, mrq);
 }
 
-static irqreturn_t mvsd_card_detect_irq(int irq, void *dev)
-{
-	struct mvsd_host *host = dev;
-	mmc_detect_change(host->mmc, msecs_to_jiffies(100));
-	return IRQ_HANDLED;
-}
-
 static void mvsd_enable_sdio_irq(struct mmc_host *mmc, int enable)
 {
 	struct mvsd_host *host = mmc_priv(mmc);
@@ -757,26 +749,11 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (!IS_ERR(host->clk))
 		clk_prepare_enable(host->clk);
 
-	if (mvsd_data->gpio_card_detect) {
-		ret = devm_gpio_request_one(&pdev->dev,
-					    mvsd_data->gpio_card_detect,
-					    GPIOF_IN, DRIVER_NAME " cd");
-		if (ret == 0) {
-			irq = gpio_to_irq(mvsd_data->gpio_card_detect);
-			ret = devm_request_irq(&pdev->dev, irq,
-					       mvsd_card_detect_irq,
-					       IRQ_TYPE_EDGE_RISING |
-					       IRQ_TYPE_EDGE_FALLING,
-					       DRIVER_NAME " cd", host);
-			if (ret == 0)
-				host->gpio_card_detect =
-					mvsd_data->gpio_card_detect;
-			else
-				devm_gpio_free(&pdev->dev,
-					       mvsd_data->gpio_card_detect);
-		}
-	}
-	if (!host->gpio_card_detect)
+	if (gpio_is_valid(mvsd_data->gpio_card_detect)) {
+		ret = mmc_gpio_request_cd(mmc, mvsd_data->gpio_card_detect);
+		if (ret)
+			goto out;
+	} else
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	mmc_gpio_request_ro(mmc, mvsd_data->gpio_write_protect);
@@ -789,15 +766,16 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	pr_notice("%s: %s driver initialized, ",
 			   mmc_hostname(mmc), DRIVER_NAME);
-	if (host->gpio_card_detect)
+	if (!(mmc->caps & MMC_CAP_NEEDS_POLL))
 		printk("using GPIO %d for card detection\n",
-		       host->gpio_card_detect);
+		       mvsd_data->gpio_card_detect);
 	else
 		printk("lacking card detect (fall back to polling)\n");
 	return 0;
 
 out:
 	if (mmc) {
+		mmc_gpio_free_cd(mmc);
 		mmc_gpio_free_ro(mmc);
 		if (!IS_ERR(host->clk))
 			clk_disable_unprepare(host->clk);
@@ -813,6 +791,7 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 
 	struct mvsd_host *host = mmc_priv(mmc);
 
+	mmc_gpio_free_cd(mmc);
 	mmc_gpio_free_ro(mmc);
 	mmc_remove_host(mmc);
 	del_timer_sync(&host->timer);
-- 
1.7.10.4

