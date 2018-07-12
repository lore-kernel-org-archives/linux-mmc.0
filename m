From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/3] mmc: tegra: fix eMMC DDR52 mode
Date: Thu, 12 Jul 2018 09:39:03 +0200
Message-ID: <20180712073904.4705-2-stefan@agner.ch>
References: <20180712073904.4705-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712073904.4705-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

Make sure the clock is doubled when using eMMC DDR52 mode.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 137df06b9b6e..888a1ad511db 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -228,7 +228,8 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 
-	if (timing == MMC_TIMING_UHS_DDR50)
+	if (timing == MMC_TIMING_UHS_DDR50 ||
+	    timing == MMC_TIMING_MMC_DDR52)
 		tegra_host->ddr_signaling = true;
 
 	sdhci_set_uhs_signaling(host, timing);
-- 
2.18.0
