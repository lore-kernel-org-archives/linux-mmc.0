From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 2/8] mmc: tegra: Parse and program DQS trim value
Date: Fri, 10 Aug 2018 21:13:59 +0300
Message-ID: <1533924845-1466-3-git-send-email-avienamo@nvidia.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Parse and program the HS400 DQS trim value from DT. Program a fallback
value in case the property is missing.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d775ad..6ec92bc 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -43,6 +43,10 @@
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
 
+#define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
+#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
+#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
+
 #define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
 #define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
 #define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
@@ -112,6 +116,7 @@ struct sdhci_tegra {
 
 	u32 default_tap;
 	u32 default_trim;
+	u32 dqs_trim;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -502,7 +507,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_down_hs400 = autocal->pull_down_1v8;
 }
 
-static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *host)
+static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
@@ -517,6 +522,11 @@ static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *host)
 				       &tegra_host->default_trim);
 	if (err)
 		tegra_host->default_trim = 0;
+
+	err = device_property_read_u32(host->mmc->parent, "nvidia,dqs-trim",
+				       &tegra_host->dqs_trim);
+	if (err)
+		tegra_host->dqs_trim = 0x11;
 }
 
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -547,20 +557,33 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 	return clk_round_rate(pltfm_host->clk, UINT_MAX);
 }
 
+static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 trim)
+{
+	u32 val;
+
+	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
+	val &= ~SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK;
+	val |= trim << SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT;
+	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
+}
+
 static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 					  unsigned timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	bool set_default_tap = false;
+	bool set_dqs_trim = false;
 
 	switch (timing) {
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
-	case MMC_TIMING_MMC_HS400:
 		/* Don't set default tap on tunable modes. */
 		break;
+	case MMC_TIMING_MMC_HS400:
+		set_dqs_trim = true;
+		break;
 	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_DDR50:
 		tegra_host->ddr_signaling = true;
@@ -577,6 +600,9 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 
 	if (set_default_tap)
 		tegra_sdhci_set_tap(host, tegra_host->default_tap);
+
+	if (set_dqs_trim)
+		tegra_sdhci_set_dqs_trim(host, tegra_host->dqs_trim);
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
@@ -933,7 +959,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	tegra_sdhci_parse_pad_autocal_dt(host);
 
-	tegra_sdhci_parse_default_tap_and_trim(host);
+	tegra_sdhci_parse_tap_and_trim(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
-- 
2.7.4
