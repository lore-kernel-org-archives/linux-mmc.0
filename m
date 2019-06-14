From: Yinbo Zhu <yinbo.zhu@nxp.com>
Subject: [PATCH v1] mmc: sdhci-of-esdhc: use 1/2 periperhal clock for ls1028a
Date: Fri, 14 Jun 2019 16:29:54 +0800
Message-ID: <20190614082954.39648-2-yinbo.zhu@nxp.com>
References: <20190614082954.39648-1-yinbo.zhu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614082954.39648-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yangbo.lu@nxp.com
List-Id: linux-mmc@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

LS1028A used 1/2 periperhal clock as one reference clock.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c56c7d413a09..4dd43b1adf2c 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1048,11 +1048,12 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 		/*
 		 * esdhc->peripheral_clock would be assigned with a value
 		 * which is eSDHC base clock when use periperal clock.
-		 * For ls1046a, the clock value got by common clk API is
-		 * peripheral clock while the eSDHC base clock is 1/2
-		 * peripheral clock.
+		 * For some platforms, the clock value got by common clk
+		 * API is peripheral clock while the eSDHC base clock is
+		 * 1/2 peripheral clock.
 		 */
-		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc"))
+		if (of_device_is_compatible(np, "fsl,ls1046a-esdhc") ||
+		    of_device_is_compatible(np, "fsl,ls1028a-esdhc"))
 			esdhc->peripheral_clock = clk_get_rate(clk) / 2;
 		else
 			esdhc->peripheral_clock = clk_get_rate(clk);
-- 
2.17.1
