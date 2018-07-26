From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 04/10] mmc: tegra: Disable card clock during pad calibration
Date: Thu, 26 Jul 2018 15:26:50 +0300
Message-ID: <1532608016-14319-5-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Disable the card clock during automatic pad drive strength calibration
and re-enable it afterwards.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 363490e..79ecdd0 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -259,11 +259,35 @@ static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
 	udelay(1);
 }
 
+static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
+{
+	bool orig_enabled;
+	u32 reg;
+
+	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	orig_enabled = !!(reg & SDHCI_CLOCK_CARD_EN);
+
+	if (orig_enabled == enable)
+		return orig_enabled;
+
+	if (enable)
+		reg |= SDHCI_CLOCK_CARD_EN;
+	else
+		reg &= ~SDHCI_CLOCK_CARD_EN;
+
+	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
+
+	return orig_enabled;
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
@@ -277,6 +301,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 
 	tegra_sdhci_configure_cal_pad(host, false);
 
+	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
+
 	if (ret)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4
