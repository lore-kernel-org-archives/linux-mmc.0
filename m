From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 1/5] mmc: mvsdio: use devm_ API to simplify/correct error paths.
Date: Wed, 16 Jan 2013 14:13:56 +0100
Message-ID: <1358342040-7130-2-git-send-email-andrew@lunn.ch>
References: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:49287 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754096Ab3APNOe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Jan 2013 08:14:34 -0500
In-Reply-To: <1358342040-7130-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>

There are a number of bugs in the error paths of this driver.  Make
use of devm_ functions to simplify the cleanup on error.

Based on a patch by Russell King.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/mmc/host/mvsdio.c |   92 +++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index de4c20b..f8dd361 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -50,8 +50,6 @@ struct mvsd_host {
 	struct timer_list timer;
 	struct mmc_host *mmc;
 	struct device *dev;
-	struct resource *res;
-	int irq;
 	struct clk *clk;
 	int gpio_card_detect;
 	int gpio_write_protect;
@@ -718,10 +716,6 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (!r || irq < 0 || !mvsd_data)
 		return -ENXIO;
 
-	r = request_mem_region(r->start, SZ_1K, DRIVER_NAME);
-	if (!r)
-		return -EBUSY;
-
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
@@ -731,8 +725,8 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
-	host->res = r;
 	host->base_clock = mvsd_data->clock / 2;
+	host->clk = ERR_PTR(-EINVAL);
 
 	mmc->ops = &mvsd_ops;
 
@@ -752,7 +746,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = ioremap(r->start, SZ_4K);
+	host->base = devm_request_and_ioremap(&pdev->dev, r);
 	if (!host->base) {
 		ret = -ENOMEM;
 		goto out;
@@ -765,44 +759,45 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	mvsd_power_down(host);
 
-	ret = request_irq(irq, mvsd_irq, 0, DRIVER_NAME, host);
+	ret = devm_request_irq(&pdev->dev, irq, mvsd_irq, 0, DRIVER_NAME, host);
 	if (ret) {
 		pr_err("%s: cannot assign irq %d\n", DRIVER_NAME, irq);
 		goto out;
-	} else
-		host->irq = irq;
+	}
 
 	/* Not all platforms can gate the clock, so it is not
 	   an error if the clock does not exists. */
-	host->clk = clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(host->clk)) {
+	host->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(host->clk))
 		clk_prepare_enable(host->clk);
-	}
 
 	if (mvsd_data->gpio_card_detect) {
-		ret = gpio_request(mvsd_data->gpio_card_detect,
-				   DRIVER_NAME " cd");
+		ret = devm_gpio_request_one(&pdev->dev,
+					    mvsd_data->gpio_card_detect,
+					    GPIOF_IN, DRIVER_NAME " cd");
 		if (ret == 0) {
-			gpio_direction_input(mvsd_data->gpio_card_detect);
 			irq = gpio_to_irq(mvsd_data->gpio_card_detect);
-			ret = request_irq(irq, mvsd_card_detect_irq,
-					  IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING,
-					  DRIVER_NAME " cd", host);
+			ret = devm_request_irq(&pdev->dev, irq,
+					       mvsd_card_detect_irq,
+					       IRQ_TYPE_EDGE_RISING |
+					       IRQ_TYPE_EDGE_FALLING,
+					       DRIVER_NAME " cd", host);
 			if (ret == 0)
 				host->gpio_card_detect =
 					mvsd_data->gpio_card_detect;
 			else
-				gpio_free(mvsd_data->gpio_card_detect);
+				devm_gpio_free(&pdev->dev,
+					       mvsd_data->gpio_card_detect);
 		}
 	}
 	if (!host->gpio_card_detect)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (mvsd_data->gpio_write_protect) {
-		ret = gpio_request(mvsd_data->gpio_write_protect,
-				   DRIVER_NAME " wp");
+		ret = devm_gpio_request_one(&pdev->dev,
+					    mvsd_data->gpio_write_protect,
+					    GPIOF_IN, DRIVER_NAME " wp");
 		if (ret == 0) {
-			gpio_direction_input(mvsd_data->gpio_write_protect);
 			host->gpio_write_protect =
 				mvsd_data->gpio_write_protect;
 		}
@@ -824,26 +819,11 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	return 0;
 
 out:
-	if (host) {
-		if (host->irq)
-			free_irq(host->irq, host);
-		if (host->gpio_card_detect) {
-			free_irq(gpio_to_irq(host->gpio_card_detect), host);
-			gpio_free(host->gpio_card_detect);
-		}
-		if (host->gpio_write_protect)
-			gpio_free(host->gpio_write_protect);
-		if (host->base)
-			iounmap(host->base);
-	}
-	if (r)
-		release_resource(r);
-	if (mmc)
-		if (!IS_ERR_OR_NULL(host->clk)) {
+	if (mmc) {
+		if (!IS_ERR(host->clk))
 			clk_disable_unprepare(host->clk);
-			clk_put(host->clk);
-		}
 		mmc_free_host(mmc);
+	}
 
 	return ret;
 }
@@ -852,28 +832,16 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 
-	if (mmc) {
-		struct mvsd_host *host = mmc_priv(mmc);
+	struct mvsd_host *host = mmc_priv(mmc);
 
-		if (host->gpio_card_detect) {
-			free_irq(gpio_to_irq(host->gpio_card_detect), host);
-			gpio_free(host->gpio_card_detect);
-		}
-		mmc_remove_host(mmc);
-		free_irq(host->irq, host);
-		if (host->gpio_write_protect)
-			gpio_free(host->gpio_write_protect);
-		del_timer_sync(&host->timer);
-		mvsd_power_down(host);
-		iounmap(host->base);
-		release_resource(host->res);
+	mmc_remove_host(mmc);
+	del_timer_sync(&host->timer);
+	mvsd_power_down(host);
+
+	if (!IS_ERR(host->clk))
+		clk_disable_unprepare(host->clk);
+	mmc_free_host(mmc);
 
-		if (!IS_ERR(host->clk)) {
-			clk_disable_unprepare(host->clk);
-			clk_put(host->clk);
-		}
-		mmc_free_host(mmc);
-	}
 	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
-- 
1.7.10.4

