From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 1/2] mmc: sdhci-esdhc-imx: add support for write protect on custom GPIO
Date: Mon, 18 Oct 2010 13:57:56 +0200
Message-ID: <1287403077-519-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42659 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0JRL6H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2010 07:58:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <w.sang@pengutronix.de>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2e9cca1..afbac9a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -15,8 +15,10 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdhci-pltfm.h>
+#include <mach/esdhc.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -99,9 +101,21 @@ static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 	return clk_get_rate(pltfm_host->clk) / 256 / 16;
 }
 
+static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
+{
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+
+	if (boarddata)
+		return gpio_get_value(boarddata->wp_gpio);
+	else
+		/* No GPIO -> always writable! */
+		return 0;
+}
+
 static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pdata)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
 	struct clk *clk;
 
 	clk = clk_get(mmc_dev(host->mmc), NULL);
@@ -112,12 +126,20 @@ static int esdhc_pltfm_init(struct sdhci_host *host, struct sdhci_pltfm_data *pd
 	clk_enable(clk);
 	pltfm_host->clk = clk;
 
+	if (boarddata) {
+		gpio_request(boarddata->wp_gpio, "SD_WP");
+		gpio_direction_input(boarddata->wp_gpio);
+	}
 	return 0;
 }
 
 static void esdhc_pltfm_exit(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct esdhc_platform_data *boarddata = host->mmc->parent->platform_data;
+
+	if (boarddata)
+		gpio_free(boarddata->wp_gpio);
 
 	clk_disable(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
@@ -130,6 +152,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_clock = esdhc_set_clock,
 	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
+	.get_ro = esdhc_pltfm_get_ro,
 };
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
1.7.1

