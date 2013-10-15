From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: create struct esdhc_soc_data
Date: Tue, 15 Oct 2013 12:55:21 +0800
Message-ID: <1381812921-18525-1-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:41761
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750918Ab3JOEyo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Oct 2013 00:54:44 -0400
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>

Currently, the SoC functional flags are passed through of_device_id.data
by casting the integer to void pointer.  This is less scalable
considering we may have more SoC specific data to define in the future.

Let's create a struct esdhc_soc_data to define SoC specific data like
the 'flags' and pass the data using the structure pointer.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   62 +++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f2cd5b0..d3d34cf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -100,19 +100,37 @@
  */
 #define ESDHC_FLAG_USDHC		BIT(3)
 
-#define IMX25_ESDHC	(ESDHC_FLAG_NO_DMAS_BITS | ESDHC_FLAG_ENGCM07207)
-#define IMX35_ESDHC	(ESDHC_FLAG_ENGCM07207)
-#define IMX51_ESDHC	(0)
-#define IMX53_ESDHC	(ESDHC_FLAG_MULTIBLK_NO_INT)
-#define IMX6Q_USDHC	(ESDHC_FLAG_USDHC)
+struct esdhc_soc_data {
+	u32 flags;
+};
+
+static struct esdhc_soc_data esdhc_imx25_data = {
+	.flags = ESDHC_FLAG_NO_DMAS_BITS | ESDHC_FLAG_ENGCM07207,
+};
+
+static struct esdhc_soc_data esdhc_imx35_data = {
+	.flags = ESDHC_FLAG_ENGCM07207,
+};
+
+static struct esdhc_soc_data esdhc_imx51_data = {
+	.flags = 0,
+};
+
+static struct esdhc_soc_data esdhc_imx53_data = {
+	.flags = ESDHC_FLAG_MULTIBLK_NO_INT,
+};
+
+static struct esdhc_soc_data esdhc_imx6q_data = {
+	.flags = ESDHC_FLAG_USDHC,
+};
 
 struct pltfm_imx_data {
-	int flags;
 	u32 scratchpad;
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pins_default;
 	struct pinctrl_state *pins_100mhz;
 	struct pinctrl_state *pins_200mhz;
+	const struct esdhc_soc_data *socdata;
 	struct esdhc_platform_data boarddata;
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
@@ -128,13 +146,13 @@ struct pltfm_imx_data {
 static struct platform_device_id imx_esdhc_devtype[] = {
 	{
 		.name = "sdhci-esdhc-imx25",
-		.driver_data = IMX25_ESDHC,
+		.driver_data = (kernel_ulong_t) &esdhc_imx25_data,
 	}, {
 		.name = "sdhci-esdhc-imx35",
-		.driver_data = IMX35_ESDHC,
+		.driver_data = (kernel_ulong_t) &esdhc_imx35_data,
 	}, {
 		.name = "sdhci-esdhc-imx51",
-		.driver_data = IMX51_ESDHC,
+		.driver_data = (kernel_ulong_t) &esdhc_imx51_data,
 	}, {
 		/* sentinel */
 	}
@@ -142,18 +160,18 @@ static struct platform_device_id imx_esdhc_devtype[] = {
 MODULE_DEVICE_TABLE(platform, imx_esdhc_devtype);
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = (void *) IMX25_ESDHC, },
-	{ .compatible = "fsl,imx35-esdhc", .data = (void *) IMX35_ESDHC, },
-	{ .compatible = "fsl,imx51-esdhc", .data = (void *) IMX51_ESDHC, },
-	{ .compatible = "fsl,imx53-esdhc", .data = (void *) IMX53_ESDHC, },
-	{ .compatible = "fsl,imx6q-usdhc", .data = (void *) IMX6Q_USDHC, },
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
+	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
+	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
+	{ .compatible = "fsl,imx6q-usdhc", .data = &esdhc_imx6q_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
 static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
 {
-	return !!(data->flags & ESDHC_FLAG_USDHC);
+	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
 }
 
 static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, int reg)
@@ -251,7 +269,7 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 		}
 	}
 
-	if (unlikely((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
+	if (unlikely((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
 				&& (reg == SDHCI_INT_STATUS)
 				&& (val & SDHCI_INT_DATA_END))) {
 			u32 v;
@@ -350,7 +368,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
 		return;
 	case SDHCI_TRANSFER_MODE:
-		if ((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
+		if ((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
 				&& (host->cmd->opcode == SD_IO_RW_EXTENDED)
 				&& (host->cmd->data->blocks > 1)
 				&& (host->cmd->data->flags & MMC_DATA_READ)) {
@@ -382,7 +400,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			val |= SDHCI_CMD_ABORTCMD;
 
 		if ((host->cmd->opcode == MMC_SET_BLOCK_COUNT) &&
-		    (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
+		    (imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
 			imx_data->multiblock_status = MULTIBLK_IN_PROCESS;
 
 		if (esdhc_is_usdhc(imx_data))
@@ -419,7 +437,7 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		/* ensure the endianness */
 		new_val |= ESDHC_HOST_CONTROL_LE;
 		/* bits 8&9 are reserved on mx25 */
-		if (!(imx_data->flags & ESDHC_FLAG_NO_DMAS_BITS)) {
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_NO_DMAS_BITS)) {
 			/* DMA mode bits are shifted */
 			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
 		}
@@ -838,8 +856,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		goto free_sdhci;
 	}
 
-	imx_data->flags = of_id ? (int) of_id->data :
-				    pdev->id_entry->driver_data;
+	imx_data->socdata = of_id ? of_id->data : (struct esdhc_soc_data *)
+						  pdev->id_entry->driver_data;
 	pltfm_host->priv = imx_data;
 
 	imx_data->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
@@ -882,7 +900,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	if (imx_data->flags & ESDHC_FLAG_ENGCM07207)
+	if (imx_data->socdata->flags & ESDHC_FLAG_ENGCM07207)
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
 		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
 			| SDHCI_QUIRK_BROKEN_ADMA;
-- 
1.7.9.5


