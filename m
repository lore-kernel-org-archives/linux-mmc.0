From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 15/38] mmc: tegra: Disable card clock during pad calibration
Date: Thu, 30 Aug 2018 18:06:16 +0300
Message-ID: <20180830150639.21048-16-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Disable the card clock during automatic pad drive strength calibration
and re-enable it afterwards.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e63cd6b2fc9f..ec07a3ce0247 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -260,11 +260,35 @@ static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
 		usleep_range(1, 2);
 }
 
+static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
+{
+	bool status;
+	u32 reg;
+
+	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	status = !!(reg & SDHCI_CLOCK_CARD_EN);
+
+	if (status == enable)
+		return status;
+
+	if (enable)
+		reg |= SDHCI_CLOCK_CARD_EN;
+	else
+		reg &= ~SDHCI_CLOCK_CARD_EN;
+
+	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
+
+	return status;
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
+	bool card_clk_enabled;
 	u32 reg;
 	int ret;
 
+	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
+
 	tegra_sdhci_configure_cal_pad(host, true);
 
 	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
@@ -279,6 +303,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 
 	tegra_sdhci_configure_cal_pad(host, false);
 
+	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
+
 	if (ret)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.18.0
