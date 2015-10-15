From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 5/5] mmc: sdhci-pxav3: enable modifying MMC_CARD bit during card initialization
Date: Thu, 15 Oct 2015 18:25:46 +0200
Message-ID: <1444926346-29763-6-git-send-email-mw@semihalf.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33835 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbbJOQR5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Oct 2015 12:17:57 -0400
Received: by lbbwb3 with SMTP id wb3so13273799lbb.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Oct 2015 09:17:55 -0700 (PDT)
In-Reply-To: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com, jszhang@marvell.com

On Marvell Armada 38x SoC's the MMC_CARD bit in SD_CE_ATA_1 register must
be set to 0x1 when a MMC card is supposed to work in DDR mode, or when
commands CMD11, CMD14 and CMD20 are used.

This commit enables the above for all MMC cards by modifying the host
registers during card initialization. It is done by using init_card()
callback with pxa->mbus_win_regs as a flag, which notifies if Armada 38x
controller is in use.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index d813233..8742afd 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -57,6 +57,7 @@
 
 #define SD_SPI_MODE          0x108
 #define SD_CE_ATA_1          0x10C
+#define SDCE_MMC_CARD		BIT(28)
 
 #define SD_CE_ATA_2          0x10E
 #define SDCE_MISC_INT		(1<<2)
@@ -230,6 +231,26 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static void pxav3_init_card(struct sdhci_host *host, struct mmc_card *card)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_pxa *pxa = pltfm_host->priv;
+	u32 reg_val;
+
+	/*
+	 * Armada 38x SDHCI controller requires update of
+	 * MMC_CARD bit depending on inserted card type.
+	 */
+	if (pxa->mbus_win_regs) {
+		reg_val = sdhci_readl(host, SD_CE_ATA_1);
+		if (mmc_card_mmc(card))
+			reg_val |= SDCE_MMC_CARD;
+		else
+			reg_val &= ~SDCE_MMC_CARD;
+		sdhci_writel(host, reg_val, SD_CE_ATA_1);
+	}
+}
+
 #define MAX_WAIT_COUNT 5
 static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 {
@@ -347,6 +368,7 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = pxav3_reset,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
+	.init_card = pxav3_init_card,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
-- 
1.8.3.1

