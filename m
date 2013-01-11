From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
Date: Fri, 11 Jan 2013 11:02:10 +0000
Message-ID: <20130111110210.GC30875@n2100.arm.linux.org.uk>
References: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44613 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab3AKLCW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Jan 2013 06:02:22 -0500
Content-Disposition: inline
In-Reply-To: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 10, 2013 at 09:29:15PM +0100, Andrew Lunn wrote:
> A NULL is a valid clk cookie, so we should not be tested with
> IS_ERR_NULL(). Replace it with IS_ERR().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/mmc/host/mvsdio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index de4c20b..d0050fa 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -839,7 +839,7 @@ out:
>  	if (r)
>  		release_resource(r);
>  	if (mmc)
> -		if (!IS_ERR_OR_NULL(host->clk)) {
> +		if (!IS_ERR(host->clk)) {
>  			clk_disable_unprepare(host->clk);
>  			clk_put(host->clk);
>  		}

Actually, no.

1. I've already recently pointed out that C is not python, and this code
   is broken.  (Look at the lack of missing braces around the code you've
   modified.)
2. host->clk _can_ be NULL here.

Here's the (untested) bare minimum needed to fix this driver:

 drivers/mmc/host/mvsdio.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index de4c20b..4190fb4 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -733,6 +733,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	host->res = r;
 	host->base_clock = mvsd_data->clock / 2;
+	host->clk = ERR_PTR(-EINVAL);
 
 	mmc->ops = &mvsd_ops;
 
@@ -837,13 +838,14 @@ static int __init mvsd_probe(struct platform_device *pdev)
 			iounmap(host->base);
 	}
 	if (r)
-		release_resource(r);
-	if (mmc)
-		if (!IS_ERR_OR_NULL(host->clk)) {
+		release_mem_resource(r->start, resource_size(r));
+	if (mmc) {
+		if (!IS_ERR(host->clk)) {
 			clk_disable_unprepare(host->clk);
 			clk_put(host->clk);
 		}
 		mmc_free_host(mmc);
+	}
 
 	return ret;
 }
@@ -866,7 +868,7 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 		del_timer_sync(&host->timer);
 		mvsd_power_down(host);
 		iounmap(host->base);
-		release_resource(host->res);
+		release_mem_resource(host->res->start, resource_size(host->res);
 
 		if (!IS_ERR(host->clk)) {
 			clk_disable_unprepare(host->clk);


But... we can do better than that.  We have the devm_* APIs which will
make this code simpler, and less prone to these kinds of silly errors.
I've left the request_irq()s alone because it isn't obvious to me that
there isn't a reason for releasing the IRQ at a particular point in the
cleanup, and there's no sign that IRQs may be asked on the device itself.

Note also that I found another bug in this driver - it requests a region
1K in size, but ioremaps 4K.  That's just wrong.  But anyway, the whole
issue goes away with devm_request_and_ioremap().

What remains?  The assumption that GPIO0 means "no GPIO" rather than
testing with gpio_valid() and the IRQ stuff.

 drivers/mmc/host/mvsdio.c |   61 +++++++++++++++-----------------------------
 1 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index de4c20b..4723310 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -50,7 +50,6 @@ struct mvsd_host {
 	struct timer_list timer;
 	struct mmc_host *mmc;
 	struct device *dev;
-	struct resource *res;
 	int irq;
 	struct clk *clk;
 	int gpio_card_detect;
@@ -718,10 +717,6 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (!r || irq < 0 || !mvsd_data)
 		return -ENXIO;
 
-	r = request_mem_region(r->start, SZ_1K, DRIVER_NAME);
-	if (!r)
-		return -EBUSY;
-
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
 	if (!mmc) {
 		ret = -ENOMEM;
@@ -731,8 +726,8 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dev = &pdev->dev;
-	host->res = r;
 	host->base_clock = mvsd_data->clock / 2;
+	host->clk = ERR_PTR(-EINVAL);
 
 	mmc->ops = &mvsd_ops;
 
@@ -752,7 +747,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->lock);
 
-	host->base = ioremap(r->start, SZ_4K);
+	host->base = devm_request_and_ioremap(&pdev->dev, r);
 	if (!host->base) {
 		ret = -ENOMEM;
 		goto out;
@@ -774,16 +769,15 @@ static int __init mvsd_probe(struct platform_device *pdev)
 
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
 			ret = request_irq(irq, mvsd_card_detect_irq,
 					  IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING,
@@ -792,17 +786,18 @@ static int __init mvsd_probe(struct platform_device *pdev)
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
+				            GPIOF_IN, DRIVER_NAME " wp");
 		if (ret == 0) {
-			gpio_direction_input(mvsd_data->gpio_write_protect);
 			host->gpio_write_protect =
 				mvsd_data->gpio_write_protect;
 		}
@@ -827,23 +822,15 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (host) {
 		if (host->irq)
 			free_irq(host->irq, host);
-		if (host->gpio_card_detect) {
+		if (host->gpio_card_detect)
 			free_irq(gpio_to_irq(host->gpio_card_detect), host);
-			gpio_free(host->gpio_card_detect);
-		}
-		if (host->gpio_write_protect)
-			gpio_free(host->gpio_write_protect);
-		if (host->base)
-			iounmap(host->base);
 	}
-	if (r)
-		release_resource(r);
-	if (mmc)
-		if (!IS_ERR_OR_NULL(host->clk)) {
+	if (mmc) {
+		if (!IS_ERR(host->clk))
 			clk_disable_unprepare(host->clk);
-			clk_put(host->clk);
-		}
+
 		mmc_free_host(mmc);
+	}
 
 	return ret;
 }
@@ -855,23 +842,17 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 	if (mmc) {
 		struct mvsd_host *host = mmc_priv(mmc);
 
-		if (host->gpio_card_detect) {
+		if (host->gpio_card_detect)
 			free_irq(gpio_to_irq(host->gpio_card_detect), host);
-			gpio_free(host->gpio_card_detect);
-		}
+
 		mmc_remove_host(mmc);
 		free_irq(host->irq, host);
-		if (host->gpio_write_protect)
-			gpio_free(host->gpio_write_protect);
 		del_timer_sync(&host->timer);
 		mvsd_power_down(host);
-		iounmap(host->base);
-		release_resource(host->res);
 
-		if (!IS_ERR(host->clk)) {
+		if (!IS_ERR(host->clk))
 			clk_disable_unprepare(host->clk);
-			clk_put(host->clk);
-		}
+
 		mmc_free_host(mmc);
 	}
 	platform_set_drvdata(pdev, NULL);

