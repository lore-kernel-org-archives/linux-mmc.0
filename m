From: Tony Lin <tony.lin@freescale.com>
Subject: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on freescale eSDHC
Date: Thu, 28 Jul 2011 15:16:00 +0800
Message-ID: <1311837360-16179-2-git-send-email-tony.lin@freescale.com>
References: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:4098 "EHLO
	VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab1G1HLw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2011 03:11:52 -0400
In-Reply-To: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org

apply workaround for imx eSDHC controller to avoid missing
the card interrupt so that SDIO function is workable

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   44 +++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 710b706..e62d33f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -25,6 +25,7 @@
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
+#define	SDHCI_CTRL_D3CD			0x08
 /* VENDOR SPEC register */
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
@@ -85,14 +86,35 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
-
-	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD)))
-		/*
-		 * these interrupts won't work with a custom card_detect gpio
-		 * (only applied to mx25/35)
-		 */
-		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+	u32 data;
+
+	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
+		if (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD)
+			/*
+			 * these interrupts won't work with a
+			 * custom card_detect gpio
+			 * (only applied to mx25/35)
+			 */
+			val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
+
+		if (val & SDHCI_INT_CARD_INT) {
+			/*
+			 * clear D3CD bit and set D3CD bit to avoid
+			 * missing the card interrupt
+			 * this is a eSDHC controller problem so that
+			 * we need to apply the following workaround
+			 * clear and set D3CD bit will make eSDHC
+			 * re-sample the card interrupt, In case
+			 * a card interrupt was lost, re-sample it by
+			 * the following steps.
+			 */
+			data = readl(host->ioaddr + SDHCI_HOST_CONTROL);
+			data &= ~SDHCI_CTRL_D3CD;
+			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
+			data |= SDHCI_CTRL_D3CD;
+			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
+		}
+	}
 
 	if (unlikely((imx_data->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
 				&& (reg == SDHCI_INT_STATUS)
@@ -162,8 +184,10 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		 */
 		return;
 	case SDHCI_HOST_CONTROL:
-		/* FSL messed up here, so we can just keep those two */
-		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
+		/* FSL messed up here, so we can just keep those three */
+		new_val = val & (SDHCI_CTRL_LED | \
+				SDHCI_CTRL_4BITBUS | \
+				SDHCI_CTRL_D3CD);
 		/* ensure the endianess */
 		new_val |= ESDHC_HOST_CONTROL_LE;
 		/* DMA mode bits are shifted */
-- 
1.7.0.4


