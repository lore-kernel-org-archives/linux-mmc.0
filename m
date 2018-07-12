From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] mmc: tegra: prevent HS200 on Tegra 3
Date: Thu, 12 Jul 2018 09:39:02 +0200
Message-ID: <20180712073904.4705-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: linux-mmc@vger.kernel.org

The stack assumes that SDHC controller which support SD3.0 (SDR104) do
support HS200. This is not the case for Tegra 3, which does support SD
3.0
but only supports eMMC spec 4.41.

Use SDHCI_QUIRK2_BROKEN_HS200 to indicate that the controller does not
support HS200.

Note that commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") added
the tie between SD3.0 (SDR104) and HS200. I don't think that this is
necessarly true. It is fully legitimate to support SD3.0 and not support
HS200. The quirk naming suggests something is broken in the controller,
but this is not the case: The controller simply does not support HS200.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 970d38f68939..137df06b9b6e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -334,7 +334,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_BROKEN_HS200,
 	.ops  = &tegra_sdhci_ops,
 };
 
-- 
2.18.0
