From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH 06/10] mmc: sdhci: Add get_clk_div callback support
Date: Thu, 11 Aug 2016 19:22:53 +0530
Message-ID: <1470923574-411-2-git-send-email-riteshh@codeaurora.org>
References: <a48103a7-1aa2-b9e2-527c-c7237a9ea9c0@rock-chips.com>
 <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1470923574-411-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc: linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Few controllers (like MSM) may have to override div
in certain cases. Hence provide a callback to get the
div value for their driver.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci.c | 8 ++++++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cd65d47..cc3d6f2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1318,6 +1318,14 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 clock_set:
 	if (real_div)
 		*actual_clock = (host->max_clk * clk_mul) / real_div;
+	/*
+	 * Few controllers may have to override div
+	 * here. Hence provide a callback to get the
+	 * div value for them.
+	 */
+	if (host->ops->get_clk_div)
+		div = host->ops->get_clk_div(host, div);
+
 	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
 	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
 		<< SDHCI_DIVIDER_HI_SHIFT;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0411c9f..4701001 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -562,6 +562,7 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+	int	(*get_clk_div)(struct sdhci_host *host, int div);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.8.2.1
