From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] mmc: tegra: Constify SoC data
Date: Mon, 16 Nov 2015 10:27:14 +0100
Message-ID: <1447666035-10044-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The data in the SoC description structures is static and can therefore
reside in read-only memory.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ad28b49f0203..8d49d9af6f54 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -184,7 +184,7 @@ static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
 	.ops  = &tegra_sdhci_ops,
 };
 
-static struct sdhci_tegra_soc_data soc_data_tegra20 = {
+static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
@@ -200,7 +200,7 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 	.ops  = &tegra_sdhci_ops,
 };
 
-static struct sdhci_tegra_soc_data soc_data_tegra30 = {
+static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.pdata = &sdhci_tegra30_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_DISABLE_SDR50 |
@@ -229,7 +229,7 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 	.ops  = &tegra114_sdhci_ops,
 };
 
-static struct sdhci_tegra_soc_data soc_data_tegra114 = {
+static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.pdata = &sdhci_tegra114_pdata,
 	.nvquirks = NVQUIRK_DISABLE_SDR50 |
 		    NVQUIRK_DISABLE_DDR50 |
-- 
2.5.0
