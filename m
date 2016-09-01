From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Thu,  1 Sep 2016 13:46:17 +0200
Message-ID: <20160901114617.19416-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

According to the TRM, the SD/MMC controller on Tegra124 supports 34-bit
addressing, but testing shows that this doesn't work. On a device which
has more than 2 GiB of RAM and LPAE enabled, buffer allocations can use
addresses above the 32-bit boundary.

One way to work around this would be to enable IOMMU physical to virtual
address translations for the SD/MMC controllers, but that's not easy to
implement without breaking existing use-cases. It's also not obvious why
34-bit addressing doesn't work as advertised. In order to fix this for
existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.

Reported-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Acked-by: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Changes in v2:
- add comment with rationale for the quirk
- add various Acked-bys

 drivers/mmc/host/sdhci-tegra.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 1e93dc4e303e..20b6ff5b4af1 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -391,6 +391,31 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
 };
 
+static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   /*
+		    * The TRM states that the SD/MMC controller found on
+		    * Tegra124 can address 34 bits (the maximum supported by
+		    * the Tegra memory controller), but tests show that DMA
+		    * to or from above 4 GiB doesn't work. This is possibly
+		    * caused by missing programming, though it's not obvious
+		    * what sequence is required. Mark 64-bit DMA broken for
+		    * now to fix this for existing users (e.g. Nyan boards).
+		    */
+		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+	.ops  = &tegra114_sdhci_ops,
+};
+
+static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
+	.pdata = &sdhci_tegra124_pdata,
+};
+
 static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -408,7 +433,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
+	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
-- 
2.9.3
