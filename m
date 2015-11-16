From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] mmc: tegra: Add Tegra210 support
Date: Mon, 16 Nov 2015 10:27:15 +0100
Message-ID: <1447666035-10044-2-git-send-email-thierry.reding@gmail.com>
References: <1447666035-10044-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447666035-10044-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 8d49d9af6f54..368f1b74a525 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -236,7 +236,24 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 		    NVQUIRK_DISABLE_SDR104,
 };
 
+static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
+	.ops  = &tegra114_sdhci_ops,
+};
+
+static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
+	.pdata = &sdhci_tegra210_pdata,
+	.nvquirks = NVQUIRK_DISABLE_SDR50 |
+		    NVQUIRK_DISABLE_DDR50 |
+		    NVQUIRK_DISABLE_SDR104,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
 	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
-- 
2.5.0
