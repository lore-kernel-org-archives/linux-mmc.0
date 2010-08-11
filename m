From: akpm@linux-foundation.org
Subject: [patch 052/177] sdhci-s3c: add support for new card detection methods
Date: Tue, 10 Aug 2010 18:01:58 -0700
Message-ID: <201008110101.o7B11w2J027103@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44842 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932320Ab0HKBWK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:22:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

On some Samsung SoCs not all SDHCI controllers have card detect (CD) line.
 For some embedded designs it is not even needed, because ususally the
device (like SDIO flash memory or wifi controller) is permanently wired to
the controller.  There are also systems which have a card detect line
connected to some of the external interrupt lines or the presence of the
card depends on some other actions (like enabling a power regulator).

This patch adds support for all these cases.  The following card detection
methods are possible:

1. internal sdhci host card detect line
2. external event
3. external gpio interrupt
4. no card detect line, controller will poll for the card
5. no card detect line, card is permanently wired to the controller
(once detected host won't poll it any more)

By default, all existing code would use method #1, what is compatible with
the previous version of the driver.

In case of external event, two callbacks must be provided in platdata:
ext_cd_init and ext_cd_cleanup.  Both of them get a callback to a function
that notifies the s3c-sdhci host contoller as their argument.  That
callback function should be called from the even dispatcher to let host
notice the card insertion/removal.

In case of external gpio interrupt, a gpio pin number must be provided in
platdata (ext_cd_gpio parameter), as well as the information about the
polarity of that gpio pin (ext_cd_gpio_invert).  By default
(ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed', but
this can be changed to 'card has been removed' when ext_cd_gpio_invert ==
1.

This patch adds all required changes to sdhci-s3c driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-s3c.c |   85 +++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h     |    1 
 2 files changed, 86 insertions(+)

diff -puN drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-add-support-for-new-card-detection-methods drivers/mmc/host/sdhci-s3c.c
--- a/drivers/mmc/host/sdhci-s3c.c~sdhci-s3c-add-support-for-new-card-detection-methods
+++ a/drivers/mmc/host/sdhci-s3c.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <linux/mmc/host.h>
 
@@ -44,6 +45,8 @@ struct sdhci_s3c {
 	struct resource		*ioarea;
 	struct s3c_sdhci_platdata *pdata;
 	unsigned int		cur_clk;
+	int			ext_cd_irq;
+	int			ext_cd_gpio;
 
 	struct clk		*clk_io;
 	struct clk		*clk_bus[MAX_BUS_CLK];
@@ -235,6 +238,61 @@ static struct sdhci_ops sdhci_s3c_ops = 
 	.get_min_clock		= sdhci_s3c_get_min_clock,
 };
 
+static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+	if (host) {
+		mutex_lock(&host->lock);
+		if (state) {
+			dev_dbg(&dev->dev, "card inserted.\n");
+			host->flags &= ~SDHCI_DEVICE_DEAD;
+			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		} else {
+			dev_dbg(&dev->dev, "card removed.\n");
+			host->flags |= SDHCI_DEVICE_DEAD;
+			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		}
+		sdhci_card_detect(host);
+		mutex_unlock(&host->lock);
+	}
+}
+
+static irqreturn_t sdhci_s3c_gpio_card_detect_thread(int irq, void *dev_id)
+{
+	struct sdhci_s3c *sc = dev_id;
+	int status = gpio_get_value(sc->ext_cd_gpio);
+	if (sc->pdata->ext_cd_gpio_invert)
+		status = !status;
+	sdhci_s3c_notify_change(sc->pdev, status);
+	return IRQ_HANDLED;
+}
+
+static void sdhci_s3c_setup_card_detect_gpio(struct sdhci_s3c *sc)
+{
+	struct s3c_sdhci_platdata *pdata = sc->pdata;
+	struct device *dev = &sc->pdev->dev;
+
+	if (gpio_request(pdata->ext_cd_gpio, "SDHCI EXT CD") == 0) {
+		sc->ext_cd_gpio = pdata->ext_cd_gpio;
+		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
+		if (sc->ext_cd_irq &&
+		    request_threaded_irq(sc->ext_cd_irq, NULL,
+					 sdhci_s3c_gpio_card_detect_thread,
+					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					 dev_name(dev), sc) == 0) {
+			int status = gpio_get_value(sc->ext_cd_gpio);
+			if (pdata->ext_cd_gpio_invert)
+				status = !status;
+			sdhci_s3c_notify_change(sc->pdev, status);
+		} else {
+			dev_warn(dev, "cannot request irq for card detect\n");
+			sc->ext_cd_irq = 0;
+		}
+	} else {
+		dev_err(dev, "cannot request gpio for card detect\n");
+	}
+}
+
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
@@ -272,6 +330,7 @@ static int __devinit sdhci_s3c_probe(str
 	sc->host = host;
 	sc->pdev = pdev;
 	sc->pdata = pdata;
+	sc->ext_cd_gpio = -1; /* invalid gpio number */
 
 	platform_set_drvdata(pdev, host);
 
@@ -353,6 +412,13 @@ static int __devinit sdhci_s3c_probe(str
 	 * SDHCI block, or a missing configuration that needs to be set. */
 	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
 
+	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
+	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
+		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
@@ -365,6 +431,15 @@ static int __devinit sdhci_s3c_probe(str
 		goto err_add_host;
 	}
 
+	/* The following two methods of card detection might call
+	   sdhci_s3c_notify_change() immediately, so they can be called
+	   only after sdhci_add_host(). Setup errors are ignored. */
+	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
+		pdata->ext_cd_init(&sdhci_s3c_notify_change);
+	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
+	    gpio_is_valid(pdata->ext_cd_gpio))
+		sdhci_s3c_setup_card_detect_gpio(sc);
+
 	return 0;
 
  err_add_host:
@@ -389,10 +464,20 @@ static int __devinit sdhci_s3c_probe(str
 
 static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 {
+	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
 	int ptr;
 
+	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
+		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
+
+	if (sc->ext_cd_irq)
+		free_irq(sc->ext_cd_irq, sc);
+
+	if (gpio_is_valid(sc->ext_cd_gpio))
+		gpio_free(sc->ext_cd_gpio);
+
 	sdhci_remove_host(host, 1);
 
 	for (ptr = 0; ptr < 3; ptr++) {
diff -puN drivers/mmc/host/sdhci.h~sdhci-s3c-add-support-for-new-card-detection-methods drivers/mmc/host/sdhci.h
--- a/drivers/mmc/host/sdhci.h~sdhci-s3c-add-support-for-new-card-detection-methods
+++ a/drivers/mmc/host/sdhci.h
@@ -412,6 +412,7 @@ static inline void *sdhci_priv(struct sd
 	return (void *)host->private;
 }
 
+extern void sdhci_card_detect(struct sdhci_host *host);
 extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 
_
