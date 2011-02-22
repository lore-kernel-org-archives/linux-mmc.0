From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 3/5] mmc: sdhci-esdhc-imx: add card detect on custom GPIO
Date: Tue, 22 Feb 2011 13:58:18 +0100
Message-ID: <1298379500-27590-4-git-send-email-w.sang@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55301 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1BVM61 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 07:58:27 -0500
In-Reply-To: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Marc Reilly <marc@cpdesign.com.au>
---

Change since last version:

* rewrote the warning message to apply to non-existant cd_gpio

 arch/arm/plat-mxc/include/mach/esdhc.h |    2 +
 drivers/mmc/host/sdhci-esdhc-imx.c     |   76 ++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index dbf6d56..7501d4e 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -16,9 +16,11 @@
  * strongly recommended for i.MX25/35, not needed for other variants
  *
  * @wp_gpio:	gpio for write_protect
+ * @cd_gpio:	gpio for card_detect interrupt
  */
 
 struct esdhc_platform_data {
 	unsigned int wp_gpio;
+	unsigned int cd_gpio;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 49c9801..241eb78 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -32,6 +32,39 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
 }
 
+static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
+{
+	/* fake CARD_PRESENT flag on mx25/35 */
+	u32 val = readl(host->ioaddr + reg);
+
+	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+		struct esdhc_platform_data *boarddata =
+				host->mmc->parent->platform_data;
+
+		if (boarddata && gpio_is_valid(boarddata->cd_gpio)
+				&& gpio_get_value(boarddata->cd_gpio))
+			/* no card, if a valid gpio says so... */
+			val &= SDHCI_CARD_PRESENT;
+		else
+			/* ... in all other cases assume card is present */
+			val |= SDHCI_CARD_PRESENT;
+	}
+
+	return val;
+}
+
+static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
+{
+	if (unlikely(reg == SDHCI_INT_ENABLE))
+		/*
+		 * these interrupts won't work with a custom card_detect gpio
+		 * (only applied to mx25/35)
+		 */
+		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+
+	writel(val, host->ioaddr + reg);
+}
+
 static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 {
 	if (unlikely(reg == SDHCI_HOST_VERSION))
@@ -121,6 +154,14 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 };
 
+static irqreturn_t cd_irq(int irq, void *data)
+{
+	struct sdhci_host *sdhost = (struct sdhci_host *)data;
+
+	tasklet_schedule(&sdhost->card_tasklet);
+	return IRQ_HANDLED;
+};
+
 static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -142,6 +183,8 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	if (cpu_is_mx25() || cpu_is_mx35()) {
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
+		/* card_detect can't be routed to controller, mark broken */
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		/* write_protect can't be routed to controller, use gpio */
 		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
 	}
@@ -153,9 +196,35 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 				"no write-protect pin available!\n");
 			boarddata->wp_gpio = err;
 		}
+
+		err = gpio_request_one(boarddata->cd_gpio, GPIOF_IN, "ESDHC_CD");
+		if (err) {
+			dev_warn(mmc_dev(host->mmc),
+				"no card-detect pin available!\n");
+			goto no_card_detect_pin;
+		}
+
+		err = request_irq(gpio_to_irq(boarddata->cd_gpio), cd_irq,
+				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
+				 mmc_hostname(host->mmc), host);
+		if (err) {
+			dev_warn(mmc_dev(host->mmc), "request irq error\n");
+			goto no_card_detect_irq;
+		}
+
+		sdhci_esdhc_ops.write_l = esdhc_writel_le;
+		sdhci_esdhc_ops.read_l = esdhc_readl_le;
+		/* Now we have a working card_detect again */
+		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
 
 	return 0;
+
+ no_card_detect_irq:
+	gpio_free(boarddata->cd_gpio);
+ no_card_detect_pin:
+	boarddata->cd_gpio = err;
+	return 0;
 }
 
 static void esdhc_pltfm_exit(struct sdhci_host *host)
@@ -166,6 +235,13 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 	if (boarddata && gpio_is_valid(boarddata->wp_gpio))
 		gpio_free(boarddata->wp_gpio);
 
+	if (boarddata && gpio_is_valid(boarddata->cd_gpio)) {
+		gpio_free(boarddata->cd_gpio);
+
+		if (!(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION))
+			free_irq(gpio_to_irq(boarddata->cd_gpio), host);
+	}
+
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 }
-- 
1.7.2.3

