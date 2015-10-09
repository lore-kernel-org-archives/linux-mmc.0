From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 5/5] mmc: sdhci-pxav3: enable modifying MMC_CARD bit during card initialization
Date: Fri,  9 Oct 2015 03:03:55 +0200
Message-ID: <1444352635-21965-6-git-send-email-mw@semihalf.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com
List-Id: linux-mmc@vger.kernel.org

On Marvell Armada 38x SoC's the MMC_CARD bit in SD_CE_ATA_1 register must
be set to 0x1 when a MMC card is supposed to work in DDR mode, or when
commands CMD11, CMD14 and CMD20 are used.

This commit enables the above for all MMC cards by modifying the host
registers during card initialization. It is done by using init_card()
callback.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 352c5eb..9bdeeb1 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -57,6 +57,7 @@
 
 #define SD_SPI_MODE          0x108
 #define SD_CE_ATA_1          0x10C
+#define SDCE_MMC_CARD		BIT(28)
 
 #define SD_CE_ATA_2          0x10E
 #define SDCE_MISC_INT		(1<<2)
@@ -221,6 +222,22 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 	}
 }
 
+static void pxav3_init_card(struct sdhci_host *host, struct mmc_card *card)
+{
+	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
+	struct device_node *np = pdev->dev.of_node;
+	u32 reg_val;
+
+	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
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
@@ -338,6 +355,7 @@ static const struct sdhci_ops pxav3_sdhci_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = pxav3_reset,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
+	.init_card = pxav3_init_card,
 };
 
 static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
-- 
1.8.3.1
