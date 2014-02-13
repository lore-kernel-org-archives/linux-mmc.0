From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V2 11/17] i2c: nomadik: Convert to devm functions
Date: Thu, 13 Feb 2014 15:09:02 +0100
Message-ID: <1392300547-23365-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Use devm_* functions to simplify code and error handling.

Cc: Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Changes in v2:
	Rebased on top of latest i2c-nomadik branch.

---
 drivers/i2c/busses/i2c-nomadik.c |   29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index bc8ba02..5faf9e2 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -981,7 +981,7 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 		return -ENODEV;
 	}
 
-	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
+	dev = devm_kzalloc(&adev->dev, sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&adev->dev, "cannot allocate memory\n");
 		ret = -ENOMEM;
@@ -1011,27 +1011,28 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	/* If possible, let's go to idle until the first transfer */
 	pinctrl_pm_select_idle_state(&adev->dev);
 
-	dev->virtbase = ioremap(adev->res.start, resource_size(&adev->res));
+	dev->virtbase = devm_ioremap(&adev->dev, adev->res.start,
+				resource_size(&adev->res));
 	if (!dev->virtbase) {
 		ret = -ENOMEM;
-		goto err_no_ioremap;
+		goto err_no_mem;
 	}
 
 	dev->irq = adev->irq[0];
-	ret = request_irq(dev->irq, i2c_irq_handler, 0,
+	ret = devm_request_irq(&adev->dev, dev->irq, i2c_irq_handler, 0,
 				DRIVER_NAME, dev);
 	if (ret) {
 		dev_err(&adev->dev, "cannot claim the irq %d\n", dev->irq);
-		goto err_irq;
+		goto err_no_mem;
 	}
 
 	pm_suspend_ignore_children(&adev->dev, true);
 
-	dev->clk = clk_get(&adev->dev, NULL);
+	dev->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		dev_err(&adev->dev, "could not get i2c clock\n");
 		ret = PTR_ERR(dev->clk);
-		goto err_no_clk;
+		goto err_no_mem;
 	}
 
 	adap = &dev->adap;
@@ -1053,21 +1054,13 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
 	ret = i2c_add_adapter(adap);
 	if (ret) {
 		dev_err(&adev->dev, "failed to add adapter\n");
-		goto err_add_adap;
+		goto err_no_mem;
 	}
 
 	pm_runtime_put(&adev->dev);
 
 	return 0;
 
- err_add_adap:
-	clk_put(dev->clk);
- err_no_clk:
-	free_irq(dev->irq, dev);
- err_irq:
-	iounmap(dev->virtbase);
- err_no_ioremap:
-	kfree(dev);
  err_no_mem:
 
 	return ret;
@@ -1084,13 +1077,9 @@ static int nmk_i2c_remove(struct amba_device *adev)
 	clear_all_interrupts(dev);
 	/* disable the controller */
 	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
-	free_irq(dev->irq, dev);
-	iounmap(dev->virtbase);
 	if (res)
 		release_mem_region(res->start, resource_size(res));
-	clk_put(dev->clk);
 	pm_runtime_disable(&adev->dev);
-	kfree(dev);
 
 	return 0;
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
