From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] mmc: sdhci-esdhc-imx: fix multiblock reads on i.MX53
Date: Thu, 14 Mar 2013 15:43:45 +0100
Message-ID: <1363272225-1304-1-git-send-email-l.stach@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36499 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3CNOoL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 10:44:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, Lucas Stach <l.stach@pengutronix.de>

The eSDHC controller on the i.MX53 needs an additional, non spec
compliant CMD12 after a multiblock read with a predefined number of
blocks. Otherwise the internal state machine won't go back to the
idle state.

This commit effectively reverts ebe31e44 (mmc: sdhci-esdhc-imx:
fix for mmc cards on i.MX5), which fixed part of the problem by
making multiblock reads work, however this fix was not sufficient
when multi- and singleblock reads got intermixed.

This implements the recommended workaround by manually sending a
CMD12 with the RSPTYP bits cleared.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   38 +++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 78ac002..bd3830d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -85,6 +85,14 @@ struct pltfm_imx_data {
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
 	struct clk *clk_per;
+	/*
+	 * controller multiblock status:
+	 * 0: no multiblock command pending
+	 * 1: exact multiblock command in process
+	 * 2: multiblock command finished by CMD12, waiting for response INT
+	 */
+	unsigned char multiblock_status;
+
 };
 
 static struct platform_device_id imx_esdhc_devtype[] = {
@@ -154,6 +162,8 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely(reg == SDHCI_CAPABILITIES)) {
@@ -175,6 +185,18 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			val &= ~ESDHC_INT_VENDOR_SPEC_DMA_ERR;
 			val |= SDHCI_INT_ADMA_ERROR;
 		}
+
+		/*
+		 * mask off the interrupt we get in response to the manually
+		 * sent CMD12
+		 */
+		if ((imx_data->multiblock_status == 2) &&
+		    ((val & SDHCI_INT_RESPONSE) == SDHCI_INT_RESPONSE)) {
+			val &= ~SDHCI_INT_RESPONSE;
+			writel(SDHCI_INT_RESPONSE, host->ioaddr +
+						   SDHCI_INT_STATUS);
+			imx_data->multiblock_status = 0;
+		}
 	}
 
 	return val;
@@ -211,6 +233,14 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			v = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 			v &= ~ESDHC_VENDOR_SPEC_SDIO_QUIRK;
 			writel(v, host->ioaddr + ESDHC_VENDOR_SPEC);
+
+			if (imx_data->multiblock_status == 1) {
+				/* send a manual CMD12 with RESPTYP=none */
+				data = MMC_STOP_TRANSMISSION << 24 |
+				       SDHCI_CMD_ABORTCMD << 16;
+				writel(data, host->ioaddr + SDHCI_TRANSFER_MODE);
+				imx_data->multiblock_status = 2;
+			}
 	}
 
 	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
@@ -277,11 +307,13 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		}
 		return;
 	case SDHCI_COMMAND:
-		if ((host->cmd->opcode == MMC_STOP_TRANSMISSION ||
-		     host->cmd->opcode == MMC_SET_BLOCK_COUNT) &&
-	            (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
+		if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
 			val |= SDHCI_CMD_ABORTCMD;
 
+		if ((host->cmd->opcode == MMC_SET_BLOCK_COUNT) &&
+		    (imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT))
+			imx_data->multiblock_status = 1;
+
 		if (is_imx6q_usdhc(imx_data))
 			writel(val << 16,
 			       host->ioaddr + SDHCI_TRANSFER_MODE);
-- 
1.7.10.4

