From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH 1/3 resend] omap_hsmmc: reuse mmc/slot-gpio for write protect detection
Date: Fri,  8 Aug 2014 12:16:58 +0200
Message-ID: <1407493020-11566-2-git-send-email-afenkart@gmail.com>
References: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1407493020-11566-1-git-send-email-afenkart@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, daniel@zonque.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2f944d7..1c10e6c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -36,6 +36,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/core.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
@@ -239,15 +240,6 @@ static int omap_hsmmc_card_detect(struct device *dev, int slot)
 	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
 }
 
-static int omap_hsmmc_get_wp(struct device *dev, int slot)
-{
-	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
-	struct omap_mmc_platform_data *mmc = host->pdata;
-
-	/* NOTE: assumes write protect signal is active-high */
-	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
-}
-
 static int omap_hsmmc_get_cover_state(struct device *dev, int slot)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -449,7 +441,8 @@ static inline int omap_hsmmc_have_reg(void)
 
 #endif
 
-static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
+static int omap_hsmmc_gpio_init(struct mmc_host *mmc,
+				struct omap_mmc_platform_data *pdata)
 {
 	int ret;
 
@@ -471,31 +464,31 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 		pdata->slots[0].switch_pin = -EINVAL;
 
 	if (gpio_is_valid(pdata->slots[0].gpio_wp)) {
-		pdata->slots[0].get_ro = omap_hsmmc_get_wp;
-		ret = gpio_request(pdata->slots[0].gpio_wp, "mmc_wp");
-		if (ret)
-			goto err_free_cd;
-		ret = gpio_direction_input(pdata->slots[0].gpio_wp);
-		if (ret)
-			goto err_free_wp;
-	} else
-		pdata->slots[0].gpio_wp = -EINVAL;
+		/* copy & paste from from mmc_of_parse */
+		ret = mmc_gpio_request_ro(mmc, pdata->slots[0].gpio_wp);
+		if (ret < 0) {
+			dev_err(pdata->dev,
+				"Failed to request WP GPIO: %d!\n", ret);
+			goto err;
+		} else {
+			dev_info(pdata->dev, "Got WP GPIO #%d.\n",
+				 pdata->slots[0].gpio_wp);
+		}
+	}
 
 	return 0;
 
-err_free_wp:
-	gpio_free(pdata->slots[0].gpio_wp);
-err_free_cd:
+err:
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
 err_free_sp:
 		gpio_free(pdata->slots[0].switch_pin);
 	return ret;
 }
 
-static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
+static void omap_hsmmc_gpio_free(struct mmc_host *mmc,
+				 struct omap_mmc_platform_data *pdata)
 {
-	if (gpio_is_valid(pdata->slots[0].gpio_wp))
-		gpio_free(pdata->slots[0].gpio_wp);
+	mmc_gpio_free_ro(mmc);
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
 		gpio_free(pdata->slots[0].switch_pin);
 }
@@ -1673,15 +1666,6 @@ static int omap_hsmmc_get_cd(struct mmc_host *mmc)
 	return mmc_slot(host).card_detect(host->dev, host->slot_id);
 }
 
-static int omap_hsmmc_get_ro(struct mmc_host *mmc)
-{
-	struct omap_hsmmc_host *host = mmc_priv(mmc);
-
-	if (!mmc_slot(host).get_ro)
-		return -ENOSYS;
-	return mmc_slot(host).get_ro(host->dev, 0);
-}
-
 static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
@@ -1837,7 +1821,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
 	.request = omap_hsmmc_request,
 	.set_ios = omap_hsmmc_set_ios,
 	.get_cd = omap_hsmmc_get_cd,
-	.get_ro = omap_hsmmc_get_ro,
+	.get_ro = mmc_gpio_get_ro,
 	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
 };
@@ -2063,16 +2047,15 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	ret = omap_hsmmc_gpio_init(pdata);
-	if (ret)
-		goto err;
-
 	mmc = mmc_alloc_host(sizeof(struct omap_hsmmc_host), &pdev->dev);
 	if (!mmc) {
-		ret = -ENOMEM;
-		goto err_alloc;
+		return -ENOMEM;
 	}
 
+	ret = omap_hsmmc_gpio_init(mmc, pdata);
+	if (ret)
+		goto err;
+
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->pdata	= pdata;
@@ -2302,10 +2285,9 @@ err_irq:
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 err1:
-	mmc_free_host(mmc);
-err_alloc:
-	omap_hsmmc_gpio_free(pdata);
+	omap_hsmmc_gpio_free(mmc, pdata);
 err:
+	mmc_free_host(mmc);
 	return ret;
 }
 
@@ -2330,7 +2312,7 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
-	omap_hsmmc_gpio_free(host->pdata);
+	omap_hsmmc_gpio_free(host->mmc, host->pdata);
 	mmc_free_host(host->mmc);
 
 	return 0;
diff --git a/include/linux/platform_data/mmc-omap.h b/include/linux/platform_data/mmc-omap.h
index 51e70cf..7fe0c14 100644
--- a/include/linux/platform_data/mmc-omap.h
+++ b/include/linux/platform_data/mmc-omap.h
@@ -120,7 +120,6 @@ struct omap_mmc_platform_data {
 		int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
 		int (*set_power)(struct device *dev, int slot,
 				 int power_on, int vdd);
-		int (*get_ro)(struct device *dev, int slot);
 		void (*remux)(struct device *dev, int slot, int power_on);
 		/* Call back before enabling / disabling regulators */
 		void (*before_set_reg)(struct device *dev, int slot,
-- 
2.0.0

