From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 28/40] mmc: tegra: Enable UHS and HS200 modes for Tegra210
Date: Fri, 10 Aug 2018 21:08:30 +0300
Message-ID: <1533924522-1037-29-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Set nvquirks to enable higher speed modes.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0959102..8cfa8f4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -846,7 +846,9 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
 		    NVQUIRK_HAS_PADCALIB |
-		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
-- 
2.7.4
