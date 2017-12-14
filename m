From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/12] mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
Date: Thu, 14 Dec 2017 18:39:32 +0530
Message-ID: <20171214130941.26666-4-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:50702 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752277AbdLNNLO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Dec 2017 08:11:14 -0500
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com

UHS-1 DDR50 and MMC DDR52 mode require DDR bit to be
set in the configuration register (MMCHS_CON). Add
sdhci-omap specific set_uhs_signaling ops to set
this bit. Also while setting the UHSMS bit, clock should be
disabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index defe4eac020d..8f7239e2edc2 100644
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
@@ -93,6 +94,9 @@ struct sdhci_omap_host {
 	u8			power_mode;
 };
 
+static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
+static void sdhci_omap_stop_clock(struct sdhci_omap_host *omap_host);
+
 static inline u32 sdhci_omap_readl(struct sdhci_omap_host *host,
 				   unsigned int offset)
 {
@@ -471,6 +475,26 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
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
@@ -480,7 +504,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.set_bus_width = sdhci_omap_set_bus_width,
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
 	.reset = sdhci_reset,
-	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.11.0

