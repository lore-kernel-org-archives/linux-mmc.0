From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 14/40] mmc: tegra: Set calibration pad voltage reference
Date: Fri, 10 Aug 2018 21:08:16 +0300
Message-ID: <1533924522-1037-15-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Configure the voltage reference used by the automatic pad drive strength
calibration procedure. The value is a magic number from the TRM.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 56 +++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a62a3fc..6ddc7c2 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -41,27 +41,31 @@
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
 
-#define SDHCI_TEGRA_VENDOR_MISC_CTRL		0x120
-#define SDHCI_MISC_CTRL_ENABLE_SDR104		0x8
-#define SDHCI_MISC_CTRL_ENABLE_SDR50		0x10
-#define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300	0x20
-#define SDHCI_MISC_CTRL_ENABLE_DDR50		0x200
-
-#define SDHCI_TEGRA_AUTO_CAL_CONFIG		0x1e4
-#define SDHCI_AUTO_CAL_START			BIT(31)
-#define SDHCI_AUTO_CAL_ENABLE			BIT(29)
-
-#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
-#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
-
-#define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
-#define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
-#define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
-#define NVQUIRK_ENABLE_SDR50		BIT(3)
-#define NVQUIRK_ENABLE_SDR104		BIT(4)
-#define NVQUIRK_ENABLE_DDR50		BIT(5)
-#define NVQUIRK_HAS_PADCALIB		BIT(6)
-#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
+#define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
+#define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
+#define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
+#define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
+#define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
+
+#define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
+#define SDHCI_AUTO_CAL_START				BIT(31)
+#define SDHCI_AUTO_CAL_ENABLE				BIT(29)
+
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
+
+#define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
+#define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
+
+#define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
+#define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
+#define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
+#define NVQUIRK_ENABLE_SDR50				BIT(3)
+#define NVQUIRK_ENABLE_SDR104				BIT(4)
+#define NVQUIRK_ENABLE_DDR50				BIT(5)
+#define NVQUIRK_HAS_PADCALIB				BIT(6)
+#define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -187,7 +191,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
-	u32 misc_ctrl, clk_ctrl;
+	u32 misc_ctrl, clk_ctrl, pad_ctrl;
 
 	sdhci_reset(host, mask);
 
@@ -222,8 +226,14 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
-	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
+	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB) {
+		pad_ctrl = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+		pad_ctrl &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK;
+		pad_ctrl |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL;
+		sdhci_writel(host, pad_ctrl, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+
 		tegra_host->pad_calib_required = true;
+	}
 
 	tegra_host->ddr_signaling = false;
 }
-- 
2.7.4
