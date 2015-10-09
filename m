From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 2/5] mmc: sdhci-pxav3: enable usage of DAT3 pin as HW card detect
Date: Fri,  9 Oct 2015 03:03:52 +0200
Message-ID: <1444352635-21965-3-git-send-email-mw@semihalf.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com
List-Id: linux-mmc@vger.kernel.org

Marvell Armada 38x SDHCI controller enable using DAT3 pin as a hardware
card detection. According to the SD sdandard this signal can be used for
this purpose combined with a pull-up resistor, implying inverted (active
low) polarization of a card detect. MMC standard does not support this
feature and does not operate with such connectivity of DAT3.

When using DAT3-based detection Armada 38x SDIO IP expects its internal
clock to be always on, which had to be ensured twofold:
- Each time controller is reset by updating appropriate registers. On the
  occasion of adding new register @0x104, register @0x100 name is modified
  in order to the be aligned with Armada 38x documentation.
- Leaving the clock enabled despite power-down. For this purpose a new
  quirk had to be added to SDHCI subsystem - SDHCI_QUIRK2_KEEP_INT_CLK_ON.

In addition to the changes above this commit adds a new property to Armada
38x SDHCI node ('dat3-cd') with an according binding documentation update.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 .../devicetree/bindings/mmc/sdhci-pxa.txt          |  5 +++
 drivers/mmc/host/sdhci-pxav3.c                     | 38 ++++++++++++++++++++--
 drivers/mmc/host/sdhci.c                           |  5 ++-
 drivers/mmc/host/sdhci.h                           |  3 ++
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
index 3d1b449..ffd6b14 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -23,6 +23,11 @@ Required properties:
 
 Optional properties:
 - mrvl,clk-delay-cycles: Specify a number of cycles to delay for tuning.
+- dat3-cd: use DAT3 pin as hardware card detect - option available for
+  "marvell,armada-380-sdhci" only. The detection is supposed to work with
+  active high polarity, which implies usage of "cd-inverted" property.
+  Note that according to the specifications DAT3-based card detection can be
+  used with SD cards only. MMC standard doesn't support this feature.
 
 Example:
 
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 76b9a70..352c5eb 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -46,10 +46,14 @@
 #define SDCLK_DELAY_SHIFT	9
 #define SDCLK_DELAY_MASK	0x1f
 
-#define SD_CFG_FIFO_PARAM       0x100
+#define SD_EXTRA_PARAM_REG	0x100
 #define SDCFG_GEN_PAD_CLK_ON	(1<<6)
 #define SDCFG_GEN_PAD_CLK_CNT_MASK	0xFF
 #define SDCFG_GEN_PAD_CLK_CNT_SHIFT	24
+#define SD_FIFO_PARAM_REG	0x104
+#define SD_USE_DAT3		BIT(7)
+#define SD_OVRRD_CLK_OEN	BIT(11)
+#define SD_FORCE_CLK_ON		BIT(12)
 
 #define SD_SPI_MODE          0x108
 #define SD_CE_ATA_1          0x10C
@@ -163,6 +167,15 @@ static int armada_38x_quirks(struct platform_device *pdev,
 	}
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_USE_SDR50_TUNING);
 
+	/*
+	 * The interface clock enable is also used as control
+	 * for the A38x SDIO IP, so it can't be powered down
+	 * when using HW-based card detection.
+	 */
+	if (of_property_read_bool(np, "dat3-cd") &&
+	    !of_property_read_bool(np, "broken-cd"))
+		host->quirks2 |= SDHCI_QUIRK2_KEEP_INT_CLK_ON;
+
 	return 0;
 }
 
@@ -170,6 +183,8 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
+	u32 reg_val;
 
 	sdhci_reset(host, mask);
 
@@ -187,6 +202,22 @@ static void pxav3_reset(struct sdhci_host *host, u8 mask)
 			tmp |= SDCLK_SEL;
 			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
 		}
+
+		if (of_device_is_compatible(np, "marvell,armada-380-sdhci") &&
+		    host->quirks2 & SDHCI_QUIRK2_KEEP_INT_CLK_ON) {
+			reg_val = sdhci_readl(host, SD_FIFO_PARAM_REG);
+			reg_val |= SD_USE_DAT3 | SD_OVRRD_CLK_OEN |
+				   SD_FORCE_CLK_ON;
+			sdhci_writel(host, reg_val, SD_FIFO_PARAM_REG);
+
+			/*
+			 * For HW detection based on DAT3 pin keep internal
+			 * clk switched on after controller reset.
+			 */
+			reg_val = sdhci_readl(host, SDHCI_CLOCK_CONTROL);
+			reg_val |= SDHCI_CLOCK_INT_EN;
+			sdhci_writel(host, reg_val, SDHCI_CLOCK_CONTROL);
+		}
 	}
 }
 
@@ -214,9 +245,9 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 		writew(tmp, host->ioaddr + SD_CE_ATA_2);
 
 		/* start sending the 74 clocks */
-		tmp = readw(host->ioaddr + SD_CFG_FIFO_PARAM);
+		tmp = readw(host->ioaddr + SD_EXTRA_PARAM_REG);
 		tmp |= SDCFG_GEN_PAD_CLK_ON;
-		writew(tmp, host->ioaddr + SD_CFG_FIFO_PARAM);
+		writew(tmp, host->ioaddr + SD_EXTRA_PARAM_REG);
 
 		/* slowest speed is about 100KHz or 10usec per clock */
 		udelay(740);
@@ -410,6 +441,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
 		pdev->dev.platform_data = pdata;
+
 	} else if (pdata) {
 		/* on-chip device */
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT)
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64b7fdb..cfed695 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1159,7 +1159,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	/* Some controllers need to keep internal clk always enabled */
+	if (host->quirks2 & SDHCI_QUIRK2_KEEP_INT_CLK_ON)
+		clk = SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	if (clock == 0)
 		return;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7c02ff4..c751b78 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -412,6 +412,9 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Do not disable internal clk on power-off */
+#define SDHCI_QUIRK2_KEEP_INT_CLK_ON			(1<<16)
+
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.8.3.1
