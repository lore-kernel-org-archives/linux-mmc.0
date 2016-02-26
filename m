From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: tegra: Disable UHS-I modes for tegra114
Date: Fri, 26 Feb 2016 09:34:17 +0000
Message-ID: <1456479257-12147-1-git-send-email-jonathanh@nvidia.com>
References: <1455806924-14967-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455806924-14967-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

SD card support for Tegra114 started failing after commit a8e326a911d3
("mmc: tegra: implement module external clock change") was merged. This
commit was part of a series to enable UHS-I modes for Tegra. To
workaround this problem for now, disable UHS-I modes for Tegra114 by
separating the soc data structures for Tegra114 and Tegra124 so that
UHS-I is still enabled for Tegra124 but not Tegra114.

Fixes: a8e326a911d3 ("mmc: tegra: implement module external clock change")

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 83c4bf7bc16c..212d51f08939 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -147,10 +147,16 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* Advertise UHS modes as supported by host */
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
+	else
+		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
+	else
+		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
+	else
+		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
 	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
@@ -335,6 +341,10 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
+};
+
+static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
+	.pdata = &sdhci_tegra114_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_DDR50 |
 		    NVQUIRK_ENABLE_SDR104,
@@ -357,7 +367,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
+	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
-- 
2.1.4
