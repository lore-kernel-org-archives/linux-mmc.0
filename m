From: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Subject: [PATCH 3/5] mmc: tegra: implement UHS tuning
Date: Sat, 19 Dec 2015 20:16:02 +0100
Message-ID: <1450552564-32697-4-git-send-email-dev@lynxeye.de>
References: <1450552564-32697-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450552564-32697-1-git-send-email-dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

This implements the UHS tuning sequence in a similar way to the one
contained in the TRM. It deviates in the way how to check if the tap
value is passing, by using the common Linux MMC function, which does
not only check for data CRC errors, but also if the received block
pattern is correct.

Signed-off-by: Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 29c4753..fd0529c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
 
@@ -29,6 +30,9 @@
 
 /* Tegra SDHOST controller vendor register definitions */
 #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
+#define SDHCI_CLOCK_CTRL_TAP_MASK			0x00ff0000
+#define SDHCI_CLOCK_CTRL_TAP_SHIFT			16
+#define SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE		BIT(5)
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
 
@@ -151,6 +155,8 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
+	if (!(soc_data->nvquirks & NVQUIRK_DISABLE_SDR50))
+		clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
 	tegra_host->ddr_signaling = false;
@@ -213,6 +219,48 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
 }
 
+static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
+{
+	u32 reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+	reg &= ~SDHCI_CLOCK_CTRL_TAP_MASK;
+	reg |= tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
+	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+}
+
+static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	unsigned int min, max;
+
+	/*
+	 * Start search for minimum tap value at 10, as smaller values are
+	 * may wrongly be reported as working but fail at higher speeds,
+	 * according to the TRM.
+	 */
+	min = 10;
+	while (min < 255) {
+		tegra_sdhci_set_tap(host, min);
+		if (!mmc_send_tuning(host->mmc, opcode, NULL))
+			break;
+		min++;
+	}
+
+	/* Find the maximum tap value that still passes. */
+	max = min + 1;
+	while (max < 255) {
+		tegra_sdhci_set_tap(host, max);
+		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+			max--;
+			break;
+		}
+		max++;
+	}
+
+	/* The TRM states the ideal tap value is at 75% in the passing range. */
+	tegra_sdhci_set_tap(host, min + ((max - min) * 3 / 4));
+
+	return mmc_send_tuning(host->mmc, opcode, NULL);
+}
+
 static const struct sdhci_ops tegra_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
@@ -220,6 +268,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
+	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
@@ -265,6 +314,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
+	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
@@ -330,6 +380,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_parse_dt;
 
+	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_DISABLE_DDR50))
+		host->mmc->caps |= MMC_CAP_1_8V_DDR;
+
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
 	if (IS_ERR(tegra_host->power_gpio)) {
-- 
2.5.0
