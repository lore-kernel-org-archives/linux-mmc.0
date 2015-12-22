From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH v2 3/5] mmc: tegra: implement UHS tuning
Date: Tue, 22 Dec 2015 19:41:02 +0100
Message-ID: <1450809664-11360-4-git-send-email-dev@lynxeye.de>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:44236 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753292AbbLVSlQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Dec 2015 13:41:16 -0500
In-Reply-To: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

This implements the UHS tuning sequence in a similar way to the one
contained in the TRM. It deviates in the way how to check if the tap
value is passing, by using the common Linux MMC function, which does
not only check for data CRC errors, but also if the received block
pattern is correct.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 drivers/mmc/host/sdhci-tegra.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 20ce81b..0201549 100644
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
@@ -214,6 +220,50 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 	return clk_round_rate(pltfm_host->clk, UINT_MAX) / 2;
 }
 
+static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
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
@@ -221,6 +271,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
+	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
@@ -266,6 +317,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
+	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
@@ -350,6 +402,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
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

