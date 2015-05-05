From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: [PATCHv2] sdhci-of-esdhc: Support 8BIT bus width.
Date: Tue,  5 May 2015 14:17:36 +0200
Message-ID: <1430828256-6197-1-git-send-email-joakim.tjernlund@transmode.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:61837 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbbEEMRp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 May 2015 08:17:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>

The custom esdhc_pltfm_set_bus_width() is buggy w.r.t 8BIT
and esdhc_readb()/esdhc_writeb() did not mask the proper bits either.

Just drop esdhc_pltfm_set_bus_width() and emulate SDHCI_CTRL_8BITBUS
in esdhc_readb()/esdhc_writeb() properly.

Note: This assumes that SDHCI_CTRL_8BITBUS and SDHCI_CTRL_4BITBUS cannot
be set simultaneously in SDHCI_HOST_CONTROL.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
---
 v2 - I had fogotten to add bus-width = <8> to my DTS.
      Adding this simplified things
 drivers/mmc/host/sdhci-of-esdhc.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 1804bdb..7a98a22 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -82,6 +82,10 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
 		/* fixup the result */
 		ret &= ~SDHCI_CTRL_DMA_MASK;
 		ret |= dma_bits;
+
+		/* 8BIT is bit 29 in Control register */
+		ret |= ((ret << 3) & SDHCI_CTRL_8BITBUS);
+		ret &= ~(SDHCI_CTRL_8BITBUS >> 3);
 	}
 
 	return ret;
@@ -134,6 +138,10 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 			dma_bits);
 		val &= ~SDHCI_CTRL_DMA_MASK;
 		val |= in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK;
+
+		/* 8BIT is bit 29 in Control register */
+		val |= ((val & SDHCI_CTRL_8BITBUS) >> 3);
+		val = (val & ~SDHCI_CTRL_8BITBUS);
 	}
 
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
@@ -254,28 +262,6 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
-static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
-{
-	u32 ctrl;
-
-	switch (width) {
-	case MMC_BUS_WIDTH_8:
-		ctrl = ESDHC_CTRL_8BITBUS;
-		break;
-
-	case MMC_BUS_WIDTH_4:
-		ctrl = ESDHC_CTRL_4BITBUS;
-		break;
-
-	default:
-		ctrl = 0;
-		break;
-	}
-
-	clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
-			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
-}
-
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
@@ -297,7 +283,6 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.get_min_clock = esdhc_of_get_min_clock,
 	.platform_init = esdhc_of_platform_init,
 	.adma_workaround = esdhci_of_adma_workaround,
-	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
-- 
2.3.6

