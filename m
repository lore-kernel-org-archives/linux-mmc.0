From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] mmc: tegra: Add Tegra186 support
Date: Thu, 17 Nov 2016 18:18:55 +0100
Message-ID: <20161117171855.20843-2-thierry.reding@gmail.com>
References: <20161117171855.20843-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161117171855.20843-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index eac57bb161d3..0e7143557fe4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -434,7 +434,23 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
 };
 
+static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.ops  = &tegra114_sdhci_ops,
+};
+
+static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
+	.pdata = &sdhci_tegra186_pdata,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
 	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
-- 
2.10.2
