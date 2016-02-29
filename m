From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] mmc: tegra: implement memcomp pad calibration
Date: Mon, 29 Feb 2016 21:56:25 +0100
Message-ID: <1456779385-18996-2-git-send-email-dev@lynxeye.de>
References: <1456779385-18996-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456779385-18996-1-git-send-email-dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The Tegra30+ SDMMC module has memcomp pads that are used to
automatically find and set the correct drive strength settings to
the sdmmc pads. The calibration needs to be manually kicked off
when the card signal voltage is changed, after the card clock is
supplied again.

Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
This commit allows signal voltage changes on my Tegar30 Beaver to
succeed, making UHS-I modes work.
---
 drivers/mmc/host/sdhci-tegra.c | 47 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 46a6bd1..9971732 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -12,6 +12,7 @@
  *
  */
 
+#include "linux/delay.h"
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -42,12 +43,17 @@
 #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300	0x20
 #define SDHCI_MISC_CTRL_ENABLE_DDR50		0x200
 
+#define SDHCI_TEGRA_AUTO_CAL_CONFIG		0x1e4
+#define SDHCI_AUTO_CAL_START			BIT(31)
+#define SDHCI_AUTO_CAL_ENABLE			BIT(29)
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
 #define NVQUIRK_ENABLE_SDR50		BIT(3)
 #define NVQUIRK_ENABLE_SDR104		BIT(4)
 #define NVQUIRK_ENABLE_DDR50		BIT(5)
+#define NVQUIRK_HAS_PADCALIB		BIT(6)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -58,6 +64,7 @@ struct sdhci_tegra {
 	const struct sdhci_tegra_soc_data *soc_data;
 	struct gpio_desc *power_gpio;
 	bool ddr_signaling;
+	bool pad_calib_required;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -165,6 +172,9 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 		clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
+	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
+		tegra_host->pad_calib_required = true;
+
 	tegra_host->ddr_signaling = false;
 }
 
@@ -187,6 +197,17 @@ static void tegra_sdhci_set_bus_width(struct sdhci_host *host, int bus_width)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
+static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
+{
+	u32 val;
+
+	mdelay(1);
+
+	val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
+	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+}
+
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -200,7 +221,12 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	clk_set_rate(pltfm_host->clk, host_clk);
 	host->max_clk = clk_get_rate(pltfm_host->clk);
 
-	return sdhci_set_clock(host, clock);
+	sdhci_set_clock(host, clock);
+
+	if (tegra_host->pad_calib_required) {
+		tegra_sdhci_pad_autocalib(host);
+		tegra_host->pad_calib_required = false;
+	}
 }
 
 static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
@@ -270,6 +296,16 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return mmc_send_tuning(host->mmc, opcode, NULL);
 }
 
+static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = pltfm_host->priv;
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+
+	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
+		tegra_host->pad_calib_required = true;
+}
+
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
@@ -279,6 +315,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.voltage_switch = tegra_sdhci_voltage_switch,
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
@@ -312,7 +349,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_ENABLE_SDR50 |
-		    NVQUIRK_ENABLE_SDR104,
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_PADCALIB,
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
@@ -325,6 +363,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.voltage_switch = tegra_sdhci_voltage_switch,
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
@@ -347,7 +386,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 	.pdata = &sdhci_tegra114_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_DDR50 |
-		    NVQUIRK_ENABLE_SDR104,
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_PADCALIB,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
@@ -402,6 +442,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		goto err_alloc_tegra_host;
 	}
 	tegra_host->ddr_signaling = false;
+	tegra_host->pad_calib_required = false;
 	tegra_host->soc_data = soc_data;
 	pltfm_host->priv = tegra_host;
 
-- 
2.5.0
