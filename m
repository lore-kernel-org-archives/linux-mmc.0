From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH 3/3] mmc: esdhci-imx: parse max-frequency from devicetree
Date: Wed,  5 Jun 2013 15:13:26 +0200
Message-ID: <1370438006-13093-3-git-send-email-l.stach@pengutronix.de>
References: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49715 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543Ab3FENP3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jun 2013 09:15:29 -0400
In-Reply-To: <1370438006-13093-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de

In order to make it possible to reduce the SD bus frequency, parse the
optional "max-frequency" attribute as documented in
devicetree/bindings/mmc/mmc.txt

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c          | 18 +++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f99c3c..ac36593 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -384,6 +384,20 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 	}
 }
 
+static unsigned int esdhc_pltfm_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+	struct esdhc_platform_data *boarddata = &imx_data->boarddata;
+
+	u32 f_host = clk_get_rate(pltfm_host->clk);
+
+	if (boarddata->f_max && (boarddata->f_max < f_host))
+		return boarddata->f_max;
+	else
+		return f_host;
+}
+
 static unsigned int esdhc_pltfm_get_min_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -447,7 +461,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.write_w = esdhc_writew_le,
 	.write_b = esdhc_writeb_le,
 	.set_clock = esdhc_pltfm_set_clock,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = esdhc_pltfm_get_max_clock,
 	.get_min_clock = esdhc_pltfm_get_min_clock,
 	.get_ro = esdhc_pltfm_get_ro,
 	.platform_bus_width = esdhc_pltfm_bus_width,
@@ -490,6 +504,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "bus-width", &boarddata->max_bus_width);
 
+	of_property_read_u32(np, "max-frequency", &boarddata->f_max);
+
 	return 0;
 }
 #else
diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
index b4a0521..d44912d 100644
--- a/include/linux/platform_data/mmc-esdhc-imx.h
+++ b/include/linux/platform_data/mmc-esdhc-imx.h
@@ -40,5 +40,6 @@ struct esdhc_platform_data {
 	enum wp_types wp_type;
 	enum cd_types cd_type;
 	int max_bus_width;
+	unsigned int f_max;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
-- 
1.8.2.rc2

