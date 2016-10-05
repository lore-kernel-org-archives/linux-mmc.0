From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v5 07/12] mmc: sdhci-msm: Implement set_clock callback for sdhci-msm
Date: Wed,  5 Oct 2016 20:10:35 +0530
Message-ID: <1475678440-3525-8-git-send-email-riteshh@codeaurora.org>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

sdhci-msm controller may have different clk-rates for each
bus speed mode. Thus implement set_clock callback for
sdhci-msm driver.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 110 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 542ddad..9d18cf0 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -84,6 +84,7 @@ struct sdhci_msm_host {
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	u32 *clk_table;
 	int clk_table_sz;
+	u32 clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
 };
@@ -588,6 +589,113 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
 	}
 }
 
+static unsigned int sdhci_msm_get_msm_clk_rate(struct sdhci_host *host,
+					u32 req_clk)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	int count;
+	unsigned int sel_clk = -1;
+
+	if (!msm_host->clk_table)
+		return clk_round_rate(msm_host->clk, ULONG_MAX);
+
+	count = msm_host->clk_table_sz;
+
+	while (count--) {
+		sel_clk = msm_host->clk_table[count];
+		if (req_clk >= sel_clk)
+			return sel_clk;
+	}
+
+	return sel_clk;
+}
+
+/**
+ * __sdhci_msm_set_clock - sdhci_msm clock control.
+ *
+ * Description:
+ * Implement MSM version of sdhci_set_clock.
+ * This is required since MSM controller does not
+ * use internal divider and instead directly control
+ * the GCC clock as per HW recommendation.
+ **/
+void __sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+	unsigned long timeout;
+
+	/*
+	 * Keep actual_clock as zero -
+	 * - since there is no divider used so no need of having actual_clock.
+	 * - MSM controller uses SDCLK for data timeout calculation. If
+	 *   actual_clock is zero, host->clock is taken for calculation.
+	 */
+	host->mmc->actual_clock = 0;
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		return;
+
+	/*
+	 * MSM controller do not use clock divider.
+	 * Thus read SDHCI_CLOCK_CONTROL and only enable
+	 * clock with no divider value programmed.
+	 */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
+		& SDHCI_CLOCK_INT_STABLE)) {
+		if (timeout == 0) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+}
+
+static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
+	u32 msm_clock;
+	int rc;
+
+	if (!clock)
+		goto out;
+
+	spin_unlock_irq(&host->lock);
+	if ((clock != msm_host->clk_rate) && msm_host->clk_table) {
+		msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
+		rc = clk_set_rate(msm_host->clk, msm_clock);
+		if (rc) {
+			pr_err("%s: failed to set clock at rate %u, requested clock rate %u\n",
+				mmc_hostname(host->mmc), msm_clock, clock);
+			goto out;
+		}
+		msm_host->clk_rate = clock;
+		pr_debug("%s: setting clock at rate %lu\n",
+			mmc_hostname(host->mmc), clk_get_rate(msm_host->clk));
+	}
+
+	spin_lock_irq(&host->lock);
+out:
+	if (!msm_host->clk_table)
+		return sdhci_set_clock(host, clock);
+	__sdhci_msm_set_clock(host, clock);
+}
+
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{ .compatible = "qcom,sdhci-msm-v4" },
 	{},
@@ -598,7 +706,7 @@ MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
 static const struct sdhci_ops sdhci_msm_ops = {
 	.platform_execute_tuning = sdhci_msm_execute_tuning,
 	.reset = sdhci_reset,
-	.set_clock = sdhci_set_clock,
+	.set_clock = sdhci_msm_set_clock,
 	.get_min_clock = sdhci_msm_get_min_clock,
 	.get_max_clock = sdhci_msm_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
