From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4] sdhci-s3c: add support for new card detection methods
 (driver part)
Date: Thu, 22 Jul 2010 11:30:03 +0200
Message-ID: <1279791003-29763-1-git-send-email-m.szyprowski@samsung.com>
References: <000501cb2977d6cf210846d630$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <000501cb2977d6cf210846d630$%szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

On some Samsung SoCs not all SDHCI controllers have card detect (CD)
line. For some embedded designs it is not even needed, because ususally
the device (like SDIO flash memory or wifi controller) is permanently
wired to the controller. There are also systems which have a card detect
line connected to some of the external interrupt lines or the presence
of the card depends on some other actions (like enabling a power
regulator).

This patch adds support for all these cases. The following card
detection methods are possible:

1. internal sdhci host card detect line
2. external event
3. external gpio interrupt
4. no card detect line, controller will poll for the card
5. no card detect line, card is permanently wired to the controller
(once detected host won't poll it any more)

By default, all existing code would use method #1, what is compatible
with the previous version of the driver.

In case of external event, two callbacks must be provided in platdata:
ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
function that notifies the s3c-sdhci host contoller as their argument.
That callback function should be called from the even dispatcher to let
host notice the card insertion/removal.

In case of external gpio interrupt, a gpio pin number must be provided
in platdata (ext_cd_gpio parameter), as well as the information about
the polarity of that gpio pin (ext_cd_gpio_invert). By default
(ext_cd_gpio_invert == 0) gpio value 0 means 'card has been removed',
but this can be changed to 'card has been removed' when
ext_cd_gpio_invert == 1.

This patch adds changes to sdhci-s3c driver, it requires patch with
relevant platform changes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

Changes since V3:
- renamed patch to avoid confusion with the patch for the s3c-sdhci
platform changes - added "(driver part)" in subject

Changes since V2:
According to Andrew Morton's suggestion local_irq_save() call in the
sdhci_s3c_notify_change function has been replaced by spin_lock_irqsave
(host driver already has a spinlock that is used for protecting internal
state of the driver).

Changes since V1:
- added support for gpio external interrupt card based detect method
  directly to sdhci-s3c driver

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center

--- 

 drivers/mmc/host/sdhci-s3c.c |   75 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index b67414f..0d25285 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
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
@@ -242,6 +245,39 @@ static struct sdhci_ops sdhci_s3c_ops = {
 	.get_min_clock		= sdhci_s3c_get_min_clock,
 };
 
+static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	host = platform_get_drvdata(dev);
+	if (host) {
+		spin_lock_irqsave(&host->lock, flags);
+		if (state) {
+			dev_dbg(&dev->dev, "card inserted.\n");
+			host->flags &= ~SDHCI_DEVICE_DEAD;
+			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+			tasklet_schedule(&host->card_tasklet);
+		} else {
+			dev_dbg(&dev->dev, "card removed.\n");
+			host->flags |= SDHCI_DEVICE_DEAD;
+			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+			tasklet_schedule(&host->card_tasklet);
+		}
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}
+
+static irqreturn_t sdhci_s3c_gpio_card_detect_isr(int irq, void *dev_id)
+{
+	struct sdhci_s3c *sc = dev_id;
+	int status = gpio_get_value(sc->ext_cd_gpio);
+	if (sc->pdata->ext_cd_gpio_invert)
+		status = !status;
+	sdhci_s3c_notify_change(sc->pdev, status);
+	return IRQ_HANDLED;
+}
+
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
@@ -279,6 +315,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	sc->host = host;
 	sc->pdev = pdev;
 	sc->pdata = pdata;
+	sc->ext_cd_gpio = -1;
 
 	platform_set_drvdata(pdev, host);
 
@@ -361,6 +398,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
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
 
@@ -370,6 +414,27 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_add_host;
 	}
 
+	/* pdata->ext_cd_init might call sdhci_s3c_notify_change immediately,
+	   so it can be called only after sdhci_add_host() */
+	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
+		pdata->ext_cd_init(&sdhci_s3c_notify_change);
+
+	if (pdata->cd_type == S3C_SDHCI_CD_GPIO &&
+	    gpio_is_valid(pdata->ext_cd_gpio)) {
+
+		gpio_request(pdata->ext_cd_gpio, "SDHCI EXT CD");
+		sc->ext_cd_gpio = pdata->ext_cd_gpio;
+
+		sc->ext_cd_irq = gpio_to_irq(pdata->ext_cd_gpio);
+		if (sc->ext_cd_irq &&
+		    request_irq(sc->ext_cd_irq, sdhci_s3c_gpio_card_detect_isr,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), sc)) {
+			dev_err(&pdev->dev, "cannot request irq for card detect\n");
+			sc->ext_cd_irq = 0;
+		}
+	}
+
 	return 0;
 
  err_add_host:
@@ -394,10 +459,20 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
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
+		free_irq(sc->ext_cd_irq, sdhci_s3c_gpio_card_detect_isr);
+
+	if (sc->ext_cd_gpio != -1)
+		gpio_free(sc->ext_cd_gpio);
+
 	sdhci_remove_host(host, 1);
 
 	for (ptr = 0; ptr < 3; ptr++) {
-- 
1.7.1.569.g6f426
