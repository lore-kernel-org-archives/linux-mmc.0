From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 5/5] mmc: sdhci-sprd: clear the UHS-I modes read from registers
Date: Mon, 26 Aug 2019 11:18:30 +0800
Message-ID: <20190826031830.30931-6-zhang.lyra@gmail.com>
References: <20190826031830.30931-1-zhang.lyra@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826031830.30931-1-zhang.lyra@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller supports SDR50/SDR104/DDR50 though, the UHS-I
mode used by the specific card can be selected via devicetree only.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 drivers/mmc/host/sdhci-sprd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 1fecf055682c..d3c3e95676f0 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -509,7 +509,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_MISSING_CAPS,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
@@ -614,6 +615,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sdhci_enable_v4_mode(host);
 
+	/*
+	 * Supply the existing CAPS, but clear the UHS-I modes. This
+	 * will allow these modes to be specified only by device
+	 * tree properties through mmc_of_parse().
+	 */
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
+			 SDHCI_SUPPORT_DDR50);
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
-- 
2.20.1
