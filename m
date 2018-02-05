From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 03/16] mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
Date: Mon, 5 Feb 2018 18:20:16 +0530
Message-ID: <20180205125029.21570-4-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

UHS-1 DDR50 and MMC DDR52 mode require DDR bit to be
set in the configuration register (MMCHS_CON). Add
sdhci-omap specific set_uhs_signaling ops to set
this bit. Also while setting the UHSMS bit, clock should be
disabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index df927f3faaf6..86b6cc0a5380 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -31,6 +31,7 @@
 #define SDHCI_OMAP_CON		0x12c
 #define CON_DW8			BIT(5)
 #define CON_DMA_MASTER		BIT(20)
+#define CON_DDR			BIT(19)
 #define CON_CLKEXTFREE		BIT(16)
 #define CON_PADEN		BIT(15)
 #define CON_INIT		BIT(1)
@@ -461,6 +462,26 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 	enable_irq(host->irq);
 }
 
+static void sdhci_omap_set_uhs_signaling(struct sdhci_host *host,
+					 unsigned int timing)
+{
+	u32 reg;
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_omap_stop_clock(omap_host);
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
+	if (timing == MMC_TIMING_UHS_DDR50 || timing == MMC_TIMING_MMC_DDR52)
+		reg |= CON_DDR;
+	else
+		reg &= ~CON_DDR;
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
+
+	sdhci_set_uhs_signaling(host, timing);
+	sdhci_omap_start_clock(omap_host);
+}
+
 static struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
@@ -470,7 +491,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.set_bus_width = sdhci_omap_set_bus_width,
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
 	.reset = sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.11.0
