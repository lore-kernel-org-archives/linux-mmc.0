From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 15/40] mmc: tegra: Power on the calibration pad
Date: Fri, 10 Aug 2018 21:08:17 +0300
Message-ID: <1533924522-1037-16-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Automatic pad drive strength calibration is performed on a separate pad
identical to the ones used for driving the actual bus. Power on the
calibration pad during the calibration procedure and power it off
afterwards to save power.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 6ddc7c2..a00e366 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -54,6 +54,7 @@
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
 
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
@@ -238,11 +239,34 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	tegra_host->ddr_signaling = false;
 }
 
+static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
+{
+	u32 val;
+
+	/*
+	 * Enable or disable the additional I/O pad used by the drive strength
+	 * calibration process.
+	 */
+	val = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+
+	if (enable)
+		val |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
+	else
+		val &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
+
+	sdhci_writel(host, val, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+
+	if (enable)
+		usleep_range(1, 2);
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
 	u32 reg;
 	int ret;
 
+	tegra_sdhci_configure_cal_pad(host, true);
+
 	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
 	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
@@ -253,6 +277,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
 				 1000, 10000);
 
+	tegra_sdhci_configure_cal_pad(host, false);
+
 	if (ret)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4
