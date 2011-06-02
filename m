From: Richard Zhu <richard.zhu@linaro.org>
Subject: [RFC] mmc: Enable the ADMA on esdhc imx driver
Date: Thu, 2 Jun 2011 17:12:10 +0800
Message-ID: <1307005930-10935-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:41989
	"EHLO CH1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932164Ab1FBJMW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jun 2011 05:12:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, w.sang@pengutronix.de, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Eanble the ADMA mode on freescale esdhc imx driver,
tested on MX51 and MX53.

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   40 ++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a19967d..64f33cb 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,8 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
+#define  SDHCI_VENDOR_SPEC_INT_ADMA_ERR	0x10000000
+
 #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
 /*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
@@ -80,6 +82,20 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			val |= SDHCI_CARD_PRESENT;
 	}
 
+	if (unlikely(reg == SDHCI_CAPABILITIES)) {
+		if (val & SDHCI_CAN_DO_ADMA1) {
+			val &= ~SDHCI_CAN_DO_ADMA1;
+			val |= SDHCI_CAN_DO_ADMA2;
+		}
+	}
+
+	if (unlikely(reg == SDHCI_INT_STATUS)) {
+		if (val & SDHCI_VENDOR_SPEC_INT_ADMA_ERR) {
+			val &= ~SDHCI_VENDOR_SPEC_INT_ADMA_ERR;
+			val |= SDHCI_INT_ADMA_ERROR;
+		}
+	}
+
 	return val;
 }
 
@@ -105,6 +121,13 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
 	}
 
+	if (unlikely((reg == SDHCI_INT_ENABLE)
+				|| (reg == SDHCI_SIGNAL_ENABLE))) {
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= SDHCI_VENDOR_SPEC_INT_ADMA_ERR;
+		}
+	}
 	writel(val, host->ioaddr + reg);
 }
 
@@ -166,12 +189,16 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 	case SDHCI_HOST_CONTROL:
 		/* FSL messed up here, so we can just keep those two */
 		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
-		/* ensure the endianess */
+		/* ensure the endi1ness */
 		new_val |= ESDHC_HOST_CONTROL_LE;
-		/* DMA mode bits are shifted */
-		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+		if (val & SDHCI_CTRL_DMA_MASK) {
+			/* DMA mode bits are shifted */
+			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+
+			esdhc_clrset_le(host, 0xffff, new_val, reg);
+		} else
+			esdhc_clrset_le(host, 0xff, val, reg);
 
-		esdhc_clrset_le(host, 0xffff, new_val, reg);
 		return;
 	}
 	esdhc_clrset_le(host, 0xff, val, reg);
@@ -322,9 +349,10 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 }
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
+			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
+			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
 			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
-	/* ADMA has issues. Might be fixable */
 	.ops = &sdhci_esdhc_ops,
 	.init = esdhc_pltfm_init,
 	.exit = esdhc_pltfm_exit,
-- 
1.7.1


