From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1] mmc: sdhci-of-esdhc: set the sd clock divisor value above 3
Date: Fri, 14 Jun 2019 16:29:53 +0800
Message-ID: <20190614082954.39648-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yangbo.lu@nxp.com
List-Id: linux-mmc@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

This patch is to set the sd clock divisor value above 3 in tuning mode

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d4ec0a959a75..c4af026c3fba 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -824,9 +824,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	bool hs400_tuning;
+	unsigned int clk;
 	u32 val;
 	int ret;
 
+	/* For tuning mode, the sd clock divisor value
+	 * must be larger than 3 according to reference manual.
+	 */
+	clk = esdhc->peripheral_clock / 3;
+	if (host->clock > clk)
+		esdhc_of_set_clock(host, clk);
+
 	if (esdhc->quirk_limited_clk_division &&
 	    host->flags & SDHCI_HS400_TUNING)
 		esdhc_of_set_clock(host, host->clock);
-- 
2.17.1
