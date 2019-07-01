From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: [PATCH] mmc: sdhci-msm: fix mutex while in spinlock
Date: Mon,  1 Jul 2019 12:53:16 +0200
Message-ID: <20190701105316.19419-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jorge.ramirez-ortiz@linaro.org, adrian.hunter@intel.com, agross@kernel.org, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org, vinod.koul@linaro.org
List-Id: linux-mmc@vger.kernel.org

mutexes can sleep and therefore should not be taken while holding a
spinlock. move clk_get_rate (can sleep) outside the spinlock protected
region.

This regression was introduced with commit
     Date:   Mon Nov 21 12:07:16 2016 +0530
     mmc: sdhci-msm: Update DLL reset sequence

     SDCC core with minor version >= 0x42 introduced new 14lpp
     DLL. This has additional requirements in the reset sequence
     for DLL tuning. Make necessary changes as needed.

Fixes: 83736352e0ca ("mmc: sdhci-msm: Update DLL reset sequence")
Cc: stable@vger.kernel.org
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 5fc76a1993d0..9cf14b359c14 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -575,11 +575,14 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int wait_cnt = 50;
-	unsigned long flags;
+	unsigned long flags, xo_clk = 0;
 	u32 config;
 	const struct sdhci_msm_offset *msm_offset =
 					msm_host->offset;
 
+	if (msm_host->use_14lpp_dll_reset && !IS_ERR_OR_NULL(msm_host->xo_clk))
+		xo_clk = clk_get_rate(msm_host->xo_clk);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	/*
@@ -627,10 +630,10 @@ static int msm_init_cm_dll(struct sdhci_host *host)
 		config &= CORE_FLL_CYCLE_CNT;
 		if (config)
 			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 8),
-					clk_get_rate(msm_host->xo_clk));
+					xo_clk);
 		else
 			mclk_freq = DIV_ROUND_CLOSEST_ULL((host->clock * 4),
-					clk_get_rate(msm_host->xo_clk));
+					xo_clk);
 
 		config = readl_relaxed(host->ioaddr +
 				msm_offset->core_dll_config_2);
-- 
2.21.0
