From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: [PATCH] sdhci-of-esdhc: Support 8BIT bus width.
Date: Mon, 20 Apr 2015 23:11:36 +0200
Message-ID: <1429564296-30396-1-git-send-email-joakim.tjernlund@transmode.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:58396 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbbDTVTF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Apr 2015 17:19:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 22e9111..7130130 100644
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
@@ -252,6 +260,8 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 
 	if (vvn > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
+
+	host->mmc->caps |= MMC_CAP_8_BIT_DATA;
 }
 
 static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
-- 
2.0.5

