From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 1/5] mmc: sdhci-sprd: fixed incorrect clock divider
Date: Wed, 28 Aug 2019 10:17:32 +0800
Message-ID: <20190828021736.22049-2-zhang.lyra@gmail.com>
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

The register SDHCI_CLOCK_CONTROL should be cleared before config clock
divider, otherwise the frequency configured maybe lower than we
expected.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6ee340a3fb3a..d5871865a1e9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -217,10 +217,11 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	u32 div, val, mask;
 
-	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	clk |= ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
-	sdhci_enable_clk(host, clk);
+	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
+	sdhci_enable_clk(host, div);
 
 	/* enable auto gate sdhc_enable_auto_gate */
 	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-- 
2.20.1
