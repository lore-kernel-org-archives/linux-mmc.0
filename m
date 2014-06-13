From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: add callback for card_type inits
Date: Fri, 13 Jun 2014 12:25:34 +0200
Message-ID: <1402655134-1189-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1402655134-1189-1-git-send-email-s.trumtrar@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52830 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaFMK0B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jun 2014 06:26:01 -0400
In-Reply-To: <1402655134-1189-1-git-send-email-s.trumtrar@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Dong Aisheng <b29396@freescale.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>

At least the i.MX35 (there may be others) currently implements a quirk
to turn of multiblock transfers for the esdhc host.
According to the errata this is only true for SD cards and NOT for
sdio cards.

When the sdio driver initializes the card, it knows the type of card
we actually have. So now the sdhci-esdhc-imx could decide based on
card type if multiblock transfers should be used or not

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes since v1:
	- rebased onto mmc-updates-for-3.16-rc1

 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ccec0e3..2bf9223 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
@@ -880,6 +881,20 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void esdhc_init_card_type(struct sdhci_host *host, struct mmc_card *card)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct mmc_host *mmc = host->mmc;
+
+	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207) {
+		if (card->type == MMC_TYPE_SDIO)
+			mmc->max_blk_count = 65535;
+		else
+			mmc->max_blk_count = 1;
+	}
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -893,6 +908,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
 	.reset = esdhc_reset,
+	.card_type_init = esdhc_init_card_type,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-- 
2.0.0.rc2

