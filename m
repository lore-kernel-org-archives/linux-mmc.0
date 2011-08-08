From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V4] mmc: Enable the ADMA2 on esdhc imx driver
Date: Mon, 8 Aug 2011 16:30:04 +0800
Message-ID: <1312792204-7652-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:8845
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834Ab1HHIaT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2011 04:30:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, pma@sysgo.com, cjb@laptop.org, avorontsov@ru.mvista.com, w.sang@pengutronix.de, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Eanble the ADMA2 mode for freescale esdhc imx driver,
tested on MX25 3DS board, MX51 BBG board and MX53 LOCO board.

This patch is only used to enable the ADMA2 for MX51/53 platforms.
MX25/35 can't support the ADMA2 mode, set BROKEN_ADMA quirk on
MX25/35 platforms.

The ADMA mode supported or not can be distinguished by the
bit20 of Capability Register(offset 0x40) in FSL eSDHC module.

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   45 +++++++++++++++++++++++++++++++++--
 1 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e62d33f..a966d5c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -30,6 +30,14 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
+/*
+ * There is INT DMA ERR mis-match between eSDHC and STD SDHC SPEC
+ * Bit25 is used in STD SPEC, and is reserved in fsl eSDHC design,
+ * but bit28 is used as the INT DMA ERR in fsl eSDHC design.
+ * Define this macro DMA error INT for fsl eSDHC
+ */
+#define  SDHCI_INT_VENDOR_SPEC_DMA_ERR	0x10000000
+
 #define ESDHC_FLAG_GPIO_FOR_CD		(1 << 0)
 /*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
@@ -79,6 +87,27 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			val |= SDHCI_CARD_PRESENT;
 	}
 
+	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		/* In FSL esdhc IC module, only bit20 is used to indicate the
+		 * ADMA2 capability of esdhc, but this bit is messed up on some
+		 * SOCs (e.x MX25,MX35 this bit is set, but it can't support the
+		 * ADMA2 actually). So set the BROKEN_ADMA quirk on MX25/35
+		 * paltforms.
+		 */
+
+		if (val & SDHCI_CAN_DO_ADMA1) {
+			val &= ~SDHCI_CAN_DO_ADMA1;
+			val |= SDHCI_CAN_DO_ADMA2;
+		}
+	}
+
+	if (unlikely(reg == SDHCI_INT_STATUS)) {
+		if (val & SDHCI_INT_VENDOR_SPEC_DMA_ERR) {
+			val &= ~SDHCI_INT_VENDOR_SPEC_DMA_ERR;
+			val |= SDHCI_INT_ADMA_ERROR;
+		}
+	}
+
 	return val;
 }
 
@@ -125,6 +154,14 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
 	}
 
+	if (unlikely((reg == SDHCI_INT_ENABLE)
+				|| (reg == SDHCI_SIGNAL_ENABLE))) {
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= SDHCI_INT_VENDOR_SPEC_DMA_ERR;
+		}
+	}
+
 	writel(val, host->ioaddr + reg);
 }
 
@@ -225,9 +262,10 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 };
 
 static struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
+			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
 			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
-	/* ADMA has issues. Might be fixable */
 	.ops = &sdhci_esdhc_ops,
 };
 
@@ -284,7 +322,8 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	if (cpu_is_mx25() || cpu_is_mx35()) {
 		/* Fix errata ENGcm07207 present on i.MX25 and i.MX35 */
-		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
+		host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK
+			| SDHCI_QUIRK_BROKEN_ADMA;
 		/* write_protect can't be routed to controller, use gpio */
 		sdhci_esdhc_ops.get_ro = esdhc_pltfm_get_ro;
 	}
-- 
1.7.1


