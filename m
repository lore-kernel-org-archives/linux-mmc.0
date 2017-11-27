From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add sdhci_arasan_set_power
Date: Tue, 28 Nov 2017 00:51:57 +0100
Message-ID: <1511826717-8777-1-git-send-email-milan.o.stevanovic@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: michal.simek@xilinx.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, milan.o.stevanovic@gmail.com
List-Id: linux-mmc@vger.kernel.org

The power register needs to have a valid voltage set
even when the power supply is managed by  an external regulator.

Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0720ea7..fb57206 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -262,6 +262,17 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
+static void sdhci_arasan_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd)
+{
+	if (!IS_ERR(host->mmc->supply.vmmc)) {
+		struct mmc_host *mmc = host->mmc;
+
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+	}
+	sdhci_set_power_noreg(host, mode, vdd);
+}
+
 static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -269,6 +280,7 @@ static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_arasan_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_power = sdhci_arasan_set_power,
 };
 
 static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
-- 
2.7.4
