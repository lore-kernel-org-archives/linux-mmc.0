From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 4/5] mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 28 Aug 2019 10:17:35 +0800
Message-ID: <20190828021736.22049-5-zhang.lyra@gmail.com>
References: <20190828021736.22049-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190828021736.22049-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller doesn't support detection to
card insert or remove.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 27d0b57f3f89..1fecf055682c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -508,7 +508,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 }
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-- 
2.20.1
