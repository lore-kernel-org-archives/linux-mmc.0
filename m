From: Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH] mmc: tegra: Mark 64 bit dma broken on Tegra186
Date: Fri, 8 Sep 2017 12:48:33 -0700
Message-ID: <1504900113-8983-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krishna Reddy <vdumpa@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

SDHCI controllers on Tegra186 support 40 bit addressing.
IOVA addresses are 48-bit wide on Tegra186.
SDHCI host common code sets dma mask as either 32-bit or 64-bit.
To avoid access issues when SMMU is enabled, disable 64-bit dma.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0cd6fa80db66..b877c13184c2 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -422,7 +422,15 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   /* SDHCI controllers on Tegra186 support 40-bit addressing.
+		    * IOVA addresses are 48-bit wide on Tegra186.
+		    * With 64-bit dma mask used for SDHCI, accesses can
+		    * be broken. Disable 64-bit dma, which would fall back
+		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
+		    * But it is not supported as of now.
+		    */
+		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
 	.ops  = &tegra114_sdhci_ops,
 };
 
-- 
2.1.4
