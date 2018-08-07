From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 3/8] mmc: tegra: Implement HS400 enhanced strobe
Date: Tue, 7 Aug 2018 16:59:59 +0300
Message-ID: <1533650404-18125-4-git-send-email-avienamo@nvidia.com>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Implement HS400 enhanced strobe.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 426f7ea..d81143b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -43,6 +43,9 @@
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
 
+#define SDHCI_TEGRA_VENDOR_SYS_SW_CTRL			0x104
+#define SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE		BIT(31)
+
 #define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
 #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
 #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
@@ -271,6 +274,22 @@ static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 	}
 }
 
+static void tegra_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
+					      struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
+	pr_err("enhanced strobe: %d\n", ios->enhanced_strobe);
+	if (ios->enhanced_strobe)
+		reg |= SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
+	else
+		reg &= ~SDHCI_TEGRA_SYS_SW_CTRL_ENHANCED_STROBE;
+	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_SYS_SW_CTRL);
+
+}
+
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -947,6 +966,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 				sdhci_tegra_start_signal_voltage_switch;
 	}
 
+	host->mmc_host_ops.hs400_enhanced_strobe =
+			tegra_sdhci_hs400_enhanced_strobe;
+
 	rc = mmc_of_parse(host->mmc);
 	if (rc)
 		goto err_parse_dt;
-- 
2.7.4
