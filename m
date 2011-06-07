From: Richard Zhu <richard.zhu@linaro.org>
Subject: [PATCH V1] mmc: Enable the ADMA on esdhc imx driver
Date: Tue, 7 Jun 2011 17:37:04 +0800
Message-ID: <1307439424-3549-1-git-send-email-richard.zhu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:9202 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab1FGJmN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 05:42:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, w.sang@pengutronix.de, eric.miao@linaro.org, Richard Zhu <richard.zhu@linaro.org>

Eanble the ADMA2 mode on freescale esdhc imx driver,
tested on MX51 and MX53.

Only ADMA2 mode is enabled, MX25/35 can't support the ADMA2 mode.
So this patch is only used for MX51/53.
The ADMA2 mode supported or not can be distinguished by the
Capability Register(offset 0x40) of eSDHC module.
Up to now, only MX51/MX53 set the ADMA2 supported bit(Bit20) in the
Capability Register.

Signed-off-by: Richard Zhu <richard.zhu@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a19967d..8015e1a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -31,6 +31,8 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
+#define  SDHCI_SPEC_INT_ADMA_ERR	0x10000000
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
+		if (val & SDHCI_SPEC_INT_ADMA_ERR) {
+			val &= ~SDHCI_SPEC_INT_ADMA_ERR;
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
+			val |= SDHCI_SPEC_INT_ADMA_ERR;
+		}
+	}
 	writel(val, host->ioaddr + reg);
 }
 
@@ -154,7 +177,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 
 static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 {
-	u32 new_val;
+	u16 new_val;
 
 	switch (reg) {
 	case SDHCI_POWER_CONTROL:
@@ -168,10 +191,12 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
 		/* ensure the endianess */
 		new_val |= ESDHC_HOST_CONTROL_LE;
-		/* DMA mode bits are shifted */
-		new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
+		if (val & SDHCI_CTRL_DMA_MASK)
+			/* DMA mode bits are shifted */
+			new_val |= (val & SDHCI_CTRL_DMA_MASK) << 5;
 
 		esdhc_clrset_le(host, 0xffff, new_val, reg);
+
 		return;
 	}
 	esdhc_clrset_le(host, 0xff, val, reg);
@@ -322,9 +347,10 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
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


