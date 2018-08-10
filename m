From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 26/40] mmc: tegra: Enable workaround for tuning transfer mode bug
Date: Fri, 10 Aug 2018 21:08:28 +0300
Message-ID: <1533924522-1037-27-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Set SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG on Tegra210 and Tegra186.
This prevents the controller from hanging during tuning. This bug does
not seem to be documented but it's handled in a similar way in the
downstream kernel.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bac2034..3a53593 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -836,7 +836,8 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG,
 	.ops  = &tegra210_sdhci_ops,
 };
 
@@ -862,7 +863,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		    * to 32-bit dma mask. Ideally 40-bit dma mask would work,
 		    * But it is not supported as of now.
 		    */
-		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
+		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
+		   SDHCI_QUIRK2_TUNE_SKIP_XFERMODE_REG_PROG,
 	.ops  = &tegra210_sdhci_ops,
 };
 
-- 
2.7.4
