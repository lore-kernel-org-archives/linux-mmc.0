From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 02/13] mmc: mmc_spi: Support CD/RO GPIOs
Date: Tue, 30 Jul 2013 12:37:26 +0200
Message-ID: <1375180657-23641-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:37602 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab3G3Kgo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2013 06:36:44 -0400
In-Reply-To: <1375180657-23641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-spi@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Add support for passing CD/RO GPIO numbers directly to the mmc_spi
driver instead of relying solely on board code callbacks to retrieve the
CD/RO signals values. The driver will enable debouncing on the card
detect GPIO if the cd_debounce field is set to a non-zero value.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/mmc_spi.c    | 33 ++++++++++++++++++++++---------
 drivers/mmc/host/of_mmc_spi.c | 46 +++++++++++--------------------------------
 include/linux/spi/mmc_spi.h   | 16 +++++++++++++++
 3 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 74145d1..62fb82d 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -36,6 +36,7 @@
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>		/* for R1_SPI_* bit values */
+#include <linux/mmc/slot-gpio.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/mmc_spi.h>
@@ -1278,11 +1279,8 @@ static int mmc_spi_get_ro(struct mmc_host *mmc)
 
 	if (host->pdata && host->pdata->get_ro)
 		return !!host->pdata->get_ro(mmc->parent);
-	/*
-	 * Board doesn't support read only detection; let the mmc core
-	 * decide what to do.
-	 */
-	return -ENOSYS;
+	else
+		return mmc_gpio_get_ro(mmc);
 }
 
 static int mmc_spi_get_cd(struct mmc_host *mmc)
@@ -1291,7 +1289,8 @@ static int mmc_spi_get_cd(struct mmc_host *mmc)
 
 	if (host->pdata && host->pdata->get_cd)
 		return !!host->pdata->get_cd(mmc->parent);
-	return -ENOSYS;
+	else
+		return mmc_gpio_get_cd(mmc);
 }
 
 static const struct mmc_host_ops mmc_spi_ops = {
@@ -1324,6 +1323,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	struct mmc_host		*mmc;
 	struct mmc_spi_host	*host;
 	int			status;
+	bool			has_ro = false;
 
 	/* We rely on full duplex transfers, mostly to reduce
 	 * per-transfer overheads (by making fewer transfers).
@@ -1448,18 +1448,33 @@ static int mmc_spi_probe(struct spi_device *spi)
 	}
 
 	/* pass platform capabilities, if any */
-	if (host->pdata)
+	if (host->pdata) {
 		mmc->caps |= host->pdata->caps;
+		mmc->caps2 |= host->pdata->caps2;
+	}
 
 	status = mmc_add_host(mmc);
 	if (status != 0)
 		goto fail_add_host;
 
+	if (host->pdata && host->pdata->flags & MMC_SPI_USE_CD_GPIO) {
+		status = mmc_gpio_request_cd(mmc, host->pdata->cd_gpio,
+					     host->pdata->cd_debounce);
+		if (status != 0)
+			goto fail_add_host;
+	}
+
+	if (host->pdata && host->pdata->flags & MMC_SPI_USE_RO_GPIO) {
+		has_ro = true;
+		status = mmc_gpio_request_ro(mmc, host->pdata->ro_gpio);
+		if (status != 0)
+			goto fail_add_host;
+	}
+
 	dev_info(&spi->dev, "SD/MMC host %s%s%s%s%s\n",
 			dev_name(&mmc->class_dev),
 			host->dma_dev ? "" : ", no DMA",
-			(host->pdata && host->pdata->get_ro)
-				? "" : ", no WP",
+			has_ro ? "" : ", no WP",
 			(host->pdata && host->pdata->setpower)
 				? "" : ", no poweroff",
 			(mmc->caps & MMC_CAP_NEEDS_POLL)
diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index d720b5e..6e218fb 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -50,25 +50,6 @@ static struct of_mmc_spi *to_of_mmc_spi(struct device *dev)
 	return container_of(dev->platform_data, struct of_mmc_spi, pdata);
 }
 
-static int of_mmc_spi_read_gpio(struct device *dev, int gpio_num)
-{
-	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
-	bool active_low = oms->alow_gpios[gpio_num];
-	bool value = gpio_get_value(oms->gpios[gpio_num]);
-
-	return active_low ^ value;
-}
-
-static int of_mmc_spi_get_cd(struct device *dev)
-{
-	return of_mmc_spi_read_gpio(dev, CD_GPIO);
-}
-
-static int of_mmc_spi_get_ro(struct device *dev)
-{
-	return of_mmc_spi_read_gpio(dev, WP_GPIO);
-}
-
 static int of_mmc_spi_init(struct device *dev,
 			   irqreturn_t (*irqhandler)(int, void *), void *mmc)
 {
@@ -130,20 +111,22 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 		if (!gpio_is_valid(oms->gpios[i]))
 			continue;
 
-		ret = gpio_request(oms->gpios[i], dev_name(dev));
-		if (ret < 0) {
-			oms->gpios[i] = -EINVAL;
-			continue;
-		}
-
 		if (gpio_flags & OF_GPIO_ACTIVE_LOW)
 			oms->alow_gpios[i] = true;
 	}
 
-	if (gpio_is_valid(oms->gpios[CD_GPIO]))
-		oms->pdata.get_cd = of_mmc_spi_get_cd;
-	if (gpio_is_valid(oms->gpios[WP_GPIO]))
-		oms->pdata.get_ro = of_mmc_spi_get_ro;
+	if (gpio_is_valid(oms->gpios[CD_GPIO])) {
+		oms->pdata.cd_gpio = oms->gpios[CD_GPIO];
+		oms->pdata.flags |= MMC_SPI_USE_CD_GPIO;
+		if (!oms->alow_gpios[CD_GPIO])
+			oms->pdata.caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+	}
+	if (gpio_is_valid(oms->gpios[WP_GPIO])) {
+		oms->pdata.ro_gpio = oms->gpios[WP_GPIO];
+		oms->pdata.flags |= MMC_SPI_USE_RO_GPIO;
+		if (!oms->alow_gpios[WP_GPIO])
+			oms->pdata.caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+	}
 
 	oms->detect_irq = irq_of_parse_and_map(np, 0);
 	if (oms->detect_irq != 0) {
@@ -166,15 +149,10 @@ void mmc_spi_put_pdata(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
-	int i;
 
 	if (!dev->platform_data || !np)
 		return;
 
-	for (i = 0; i < ARRAY_SIZE(oms->gpios); i++) {
-		if (gpio_is_valid(oms->gpios[i]))
-			gpio_free(oms->gpios[i]);
-	}
 	kfree(oms);
 	dev->platform_data = NULL;
 }
diff --git a/include/linux/spi/mmc_spi.h b/include/linux/spi/mmc_spi.h
index 32be8db..87cdb35 100644
--- a/include/linux/spi/mmc_spi.h
+++ b/include/linux/spi/mmc_spi.h
@@ -7,6 +7,11 @@
 struct device;
 struct mmc_host;
 
+#define MMC_SPI_USE_CD_GPIO			(1 << 0)
+#define MMC_SPI_USE_RO_GPIO			(1 << 1)
+#define MMC_SPI_CD_GPIO_ACTIVE_LOW		(1 << 2)
+#define MMC_SPI_RO_GPIO_ACTIVE_LOW		(1 << 3)
+
 /* Put this in platform_data of a device being used to manage an MMC/SD
  * card slot.  (Modeled after PXA mmc glue; see that for usage examples.)
  *
@@ -30,8 +35,19 @@ struct mmc_spi_platform_data {
 	 */
 	int (*get_cd)(struct device *);
 
+	/*
+	 * Card Detect and Read Only GPIOs. To enable debouncing on the card
+	 * detect GPIO, set the cd_debounce to the debounce time in
+	 * microseconds.
+	 */
+	unsigned int flags;
+	unsigned int cd_gpio;
+	unsigned int cd_debounce;
+	unsigned int ro_gpio;
+
 	/* Capabilities to pass into mmc core (e.g. MMC_CAP_NEEDS_POLL). */
 	unsigned long caps;
+	unsigned long caps2;
 
 	/* how long to debounce card detect, in msecs */
 	u16 detect_delay;
-- 
1.8.1.5

