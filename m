From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: use slot-gpio helpers for CD and WP
Date: Fri,  7 Dec 2012 21:32:48 +0800
Message-ID: <1354887168-3073-2-git-send-email-shawn.guo@linaro.org>
References: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47856 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030354Ab2LGNdR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Dec 2012 08:33:17 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so370202pbc.19
        for <linux-mmc@vger.kernel.org>; Fri, 07 Dec 2012 05:33:17 -0800 (PST)
In-Reply-To: <1354887168-3073-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Use slot-gpio helpers to save some code in the driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   56 +++++++++++-------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e07df81..dd7fcc1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
+#include <linux/mmc/slot-gpio.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
@@ -147,17 +148,16 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
 
-	/* fake CARD_PRESENT flag */
 	u32 val = readl(host->ioaddr + reg);
 
-	if (unlikely((reg == SDHCI_PRESENT_STATE)
-			&& gpio_is_valid(boarddata->cd_gpio))) {
-		if (gpio_get_value(boarddata->cd_gpio))
-			/* no card, if a valid gpio says so... */
+	if (unlikely(reg == SDHCI_PRESENT_STATE)) {
+		/*
+		 * After SDHCI core gets improved to never query
+		 * SDHCI_CARD_PRESENT state in GPIO case, we can
+		 * remove this check.
+		 */
+		if (boarddata->cd_type == ESDHC_CD_GPIO)
 			val &= ~SDHCI_CARD_PRESENT;
-		else
-			/* ... in all other cases assume card is present */
-			val |= SDHCI_CARD_PRESENT;
 	}
 
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
@@ -362,8 +362,7 @@ static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
 
 	switch (boarddata->wp_type) {
 	case ESDHC_WP_GPIO:
-		if (gpio_is_valid(boarddata->wp_gpio))
-			return gpio_get_value(boarddata->wp_gpio);
+		return mmc_gpio_get_ro(host->mmc);
 	case ESDHC_WP_CONTROLLER:
 		return !(readl(host->ioaddr + SDHCI_PRESENT_STATE) &
 			       SDHCI_WRITE_PROTECT);
@@ -394,14 +393,6 @@ static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
-static irqreturn_t cd_irq(int irq, void *data)
-{
-	struct sdhci_host *sdhost = (struct sdhci_host *)data;
-
-	tasklet_schedule(&sdhost->card_tasklet);
-	return IRQ_HANDLED;
-};
-
 #ifdef CONFIG_OF
 static int
 sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
@@ -527,37 +518,22 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	/* write_protect */
 	if (boarddata->wp_type == ESDHC_WP_GPIO) {
-		err = devm_gpio_request_one(&pdev->dev, boarddata->wp_gpio,
-					    GPIOF_IN, "ESDHC_WP");
+		err = mmc_gpio_request_ro(host->mmc, boarddata->wp_gpio);
 		if (err) {
-			dev_warn(mmc_dev(host->mmc),
-				 "no write-protect pin available!\n");
-			boarddata->wp_gpio = -EINVAL;
+			dev_err(mmc_dev(host->mmc),
+				"failed to request write-protect gpio!\n");
+			goto disable_clk;
 		}
-	} else {
-		boarddata->wp_gpio = -EINVAL;
+		host->mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 	}
 
 	/* card_detect */
-	if (boarddata->cd_type != ESDHC_CD_GPIO)
-		boarddata->cd_gpio = -EINVAL;
-
 	switch (boarddata->cd_type) {
 	case ESDHC_CD_GPIO:
-		err = devm_gpio_request_one(&pdev->dev, boarddata->cd_gpio,
-					    GPIOF_IN, "ESDHC_CD");
+		err = mmc_gpio_request_cd(host->mmc, boarddata->cd_gpio);
 		if (err) {
 			dev_err(mmc_dev(host->mmc),
-				"no card-detect pin available!\n");
-			goto disable_clk;
-		}
-
-		err = devm_request_irq(&pdev->dev,
-				 gpio_to_irq(boarddata->cd_gpio), cd_irq,
-				 IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-				 mmc_hostname(host->mmc), host);
-		if (err) {
-			dev_err(mmc_dev(host->mmc), "request irq error\n");
+				"failed to request card-detect gpio!\n");
 			goto disable_clk;
 		}
 		/* fall through */
-- 
1.7.9.5

