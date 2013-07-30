From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 01/13] mmc: slot-gpio: Add debouncing capability to mmc_gpio_request_cd()
Date: Tue, 30 Jul 2013 12:37:25 +0200
Message-ID: <1375180657-23641-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

Add a debounce parameter to the mmc_gpio_request_cd() function that
enables GPIO debouncing when set to a non-zero value. This can be used
by MMC host drivers to enable debouncing on the card detect signal.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/core/host.c            |  2 +-
 drivers/mmc/core/slot-gpio.c       | 14 +++++++++++++-
 drivers/mmc/host/jz4740_mmc.c      |  2 +-
 drivers/mmc/host/mvsdio.c          |  3 ++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  2 +-
 drivers/mmc/host/sdhci-pxav3.c     |  3 ++-
 drivers/mmc/host/sdhci-sirf.c      |  2 +-
 drivers/mmc/host/sh_mmcif.c        |  2 +-
 drivers/mmc/host/tmio_mmc_pio.c    |  2 +-
 include/linux/mmc/slot-gpio.h      |  3 ++-
 10 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 6fb6f77..49bc403 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -374,7 +374,7 @@ int mmc_of_parse(struct mmc_host *host)
 			if (!(flags & OF_GPIO_ACTIVE_LOW))
 				gpio_inv_cd = true;
 
-			ret = mmc_gpio_request_cd(host, gpio);
+			ret = mmc_gpio_request_cd(host, gpio, 0);
 			if (ret < 0) {
 				dev_err(host->parent,
 					"Failed to request CD GPIO #%d: %d!\n",
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 3242351..46596b71 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -135,6 +135,7 @@ EXPORT_SYMBOL(mmc_gpio_request_ro);
  * mmc_gpio_request_cd - request a gpio for card-detection
  * @host: mmc host
  * @gpio: gpio number requested
+ * @debounce: debounce time in microseconds
  *
  * As devm_* managed functions are used in mmc_gpio_request_cd(), client
  * drivers do not need to explicitly call mmc_gpio_free_cd() for freeing up,
@@ -143,9 +144,14 @@ EXPORT_SYMBOL(mmc_gpio_request_ro);
  * switching for card-detection, they are responsible for calling
  * mmc_gpio_request_cd() and mmc_gpio_free_cd() as a pair on their own.
  *
+ * If GPIO debouncing is desired, set the debounce parameter to a non-zero
+ * value. The caller is responsible for ensuring that the GPIO driver associated
+ * with the GPIO supports debouncing, otherwise an error will be returned.
+ *
  * Returns zero on success, else an error.
  */
-int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
+int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
+			unsigned int debounce)
 {
 	struct mmc_gpio *ctx;
 	int irq = gpio_to_irq(gpio);
@@ -167,6 +173,12 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 		 */
 		return ret;
 
+	if (debounce) {
+		ret = gpio_set_debounce(gpio, debounce);
+		if (ret < 0)
+			return ret;
+	}
+
 	/*
 	 * Even if gpio_to_irq() returns a valid IRQ number, the platform might
 	 * still prefer to poll, e.g., because that IRQ number is already used
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0308c9f..d868946 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -713,7 +713,7 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
 	if (gpio_is_valid(pdata->gpio_card_detect)) {
-		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect);
+		ret = mmc_gpio_request_cd(mmc, pdata->gpio_card_detect, 0);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 4ddd83f..06c5b0b 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -757,7 +757,8 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		if (mvsd_data->gpio_card_detect &&
 		    gpio_is_valid(mvsd_data->gpio_card_detect)) {
 			ret = mmc_gpio_request_cd(mmc,
-						  mvsd_data->gpio_card_detect);
+						  mvsd_data->gpio_card_detect,
+						  0);
 			if (ret)
 				goto out;
 		} else {
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1dd5ba8..abc8cf0 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -616,7 +616,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	/* card_detect */
 	switch (boarddata->cd_type) {
 	case ESDHC_CD_GPIO:
-		err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio);
+		err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio, 0);
 		if (err) {
 			dev_err(mmc_dev(host->mmc),
 				"failed to request card-detect gpio!\n");
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index bf99359..793dacd 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -278,7 +278,8 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			host->mmc->pm_caps |= pdata->pm_caps;
 
 		if (gpio_is_valid(pdata->ext_cd_gpio)) {
-			ret = mmc_gpio_request_cd(host->mmc, pdata->ext_cd_gpio);
+			ret = mmc_gpio_request_cd(host->mmc, pdata->ext_cd_gpio,
+						  0);
 			if (ret) {
 				dev_err(mmc_dev(host->mmc),
 					"failed to allocate card detect gpio\n");
diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 62a4a83..696122c 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -84,7 +84,7 @@ static int sdhci_sirf_probe(struct platform_device *pdev)
 	 * gets setup in sdhci_add_host() and we oops.
 	 */
 	if (gpio_is_valid(priv->gpio_cd)) {
-		ret = mmc_gpio_request_cd(host->mmc, priv->gpio_cd);
+		ret = mmc_gpio_request_cd(host->mmc, priv->gpio_cd, 0);
 		if (ret) {
 			dev_err(&pdev->dev, "card detect irq request failed: %d\n",
 				ret);
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 6706b5e..35f61cc 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1436,7 +1436,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	}
 
 	if (pd && pd->use_cd_gpio) {
-		ret = mmc_gpio_request_cd(mmc, pd->cd_gpio);
+		ret = mmc_gpio_request_cd(mmc, pd->cd_gpio, 0);
 		if (ret < 0)
 			goto erqcd;
 	}
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b72edb7..8486a22 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1106,7 +1106,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
 	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
-		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio);
+		ret = mmc_gpio_request_cd(mmc, pdata->cd_gpio, 0);
 		if (ret < 0) {
 			tmio_mmc_host_remove(_host);
 			return ret;
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 7d88d27..b0c73e4 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -18,7 +18,8 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio);
 void mmc_gpio_free_ro(struct mmc_host *host);
 
 int mmc_gpio_get_cd(struct mmc_host *host);
-int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio);
+int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio,
+			unsigned int debounce);
 void mmc_gpio_free_cd(struct mmc_host *host);
 
 #endif
-- 
1.8.1.5

