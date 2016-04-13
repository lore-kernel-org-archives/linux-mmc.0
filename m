From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: tegra: Disable UHS-I modes for tegra124
Date: Wed, 13 Apr 2016 15:35:56 +0100
Message-ID: <1460558156-10407-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Tegra124 has been randomly hanging during system suspend when entering
the Tegra LP1 low power state. The hang is caused by the tegra SDHCI
driver and linked to the UHS-I tuning sequence. Disabling the UHS-I
modes for Tegra124 prevents any hangs from occurring when entering
system suspend.

Unfortunately, the tuning sequence described in the public Tegra
documentation is incomplete and on inspection of the current tuning
sequence that has been implemented is also incomplete and may cause
problems. In the short-term it is safer to disable UHS-I modes for now
and fix later because it would be too large of a change to simply patch
now. Therefore, disable UHS-I modes for Tegra124.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

I previously brought up this issue in this thread [0], but there has
been no resolution and so I think that for v4.6 we need to disable this
for now. I also pointered out that there is a complete implementation
available in the v3.18 kernel used by chromeos products [1]. We do plan
to get better support for UHS-I modes for Tegra it is just a matter of
bandwidth at the moment :-(

[0] http://marc.info/?l=linux-tegra&m=145926947408663&w=2
[1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.10/drivers/mmc/host/sdhci-tegra.c

 drivers/mmc/host/sdhci-tegra.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f8c4762bb48d..bcc0de47fe7e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -382,14 +382,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
 };
 
-static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
-	.pdata = &sdhci_tegra114_pdata,
-	.nvquirks = NVQUIRK_ENABLE_SDR50 |
-		    NVQUIRK_ENABLE_DDR50 |
-		    NVQUIRK_ENABLE_SDR104 |
-		    NVQUIRK_HAS_PADCALIB,
-};
-
 static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -407,7 +399,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
+	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },
-- 
2.1.4
