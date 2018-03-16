From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH 6/7] mmc: sdhci-msm: Adapt the driver to use OPPs to set clocks/performance state
Date: Fri, 16 Mar 2018 09:38:23 +0530
Message-ID: <20180316040824.21472-7-rnayak@codeaurora.org>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316040824.21472-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

SDHCI driver needs to set a performance state along with scaling its
clocks. Modify the driver to use the newly introduced powerdomain
performance state based OPPs to scale clocks as well as set an
appropriate powerdomain performance state.

The patch also adds OPPs for sdhci device on msm8996.

On platforms which don't specify an OPP table the driver falls
back to just setting the clock rates (as is done today)

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 41 +++++++++++++++++++++++++
 drivers/clk/qcom/gcc-msm8996.c        |  8 ++---
 drivers/mmc/host/sdhci-msm.c          | 57 +++++++++++++++++++++++++++++------
 3 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 43757a078146..e880a8433596 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -569,8 +569,49 @@
 			 <&gcc GCC_SDCC2_APPS_CLK>,
 			 <&xo_board>;
 			 bus-width = <4>;
+			power-domains = <&rpmpd 0>;
+			operating-points-v2 = <&sdhc_opp_table>;
 		 };
 
+		sdhc_opp_table: opp_table {
+			compatible = "operating-points-v2";
+
+			opp@144000 {
+				opp-hz = /bits/ 64 <144000>;
+				required-opp = <&rpmpd_opp1>;
+			};
+
+			opp@4000000 {
+				opp-hz = /bits/ 64 <400000>;
+				required-opp = <&rpmpd_opp1>;
+			};
+
+			opp@20000000 {
+				opp-hz = /bits/ 64 <20000000>;
+				required-opp = <&rpmpd_opp2>;
+			};
+
+			opp@25000000 {
+				opp-hz = /bits/ 64 <25000000>;
+				required-opp = <&rpmpd_opp2>;
+			};
+
+			opp@50000000 {
+				opp-hz = /bits/ 64 <50000000>;
+				required-opp = <&rpmpd_opp2>;
+			};
+
+			opp@100000000 {
+				opp-hz = /bits/ 64 <100000000>;
+				required-opp = <&rpmpd_opp3>;
+			};
+
+			opp@200000000 {
+				opp-hz = /bits/ 64 <200000000>;
+				required-opp = <&rpmpd_opp3>;
+			};
+		};
+
 		msmgpio: pinctrl@1010000 {
 			compatible = "qcom,msm8996-pinctrl";
 			reg = <0x01010000 0x300000>;
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 5d7451209206..fc90dbbdcd70 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -464,7 +464,7 @@ static struct clk_rcg2 sdcc1_apps_clk_src = {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4_gpll0_early_div,
 		.num_parents = 4,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -509,7 +509,7 @@ static struct clk_rcg2 sdcc2_apps_clk_src = {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -523,7 +523,7 @@ static struct clk_rcg2 sdcc3_apps_clk_src = {
 		.name = "sdcc3_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -547,7 +547,7 @@ static struct clk_rcg2 sdcc4_apps_clk_src = {
 		.name = "sdcc4_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index c283291db705..8e6abc0a23c7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -21,6 +21,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/iopoll.h>
+#include <linux/pm_opp.h>
 
 #include "sdhci-pltfm.h"
 
@@ -137,6 +138,7 @@ struct sdhci_msm_host {
 	struct clk *bus_clk;	/* SDHC bus voter clock */
 	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
 	struct clk_bulk_data bulk_clks[4]; /* core, iface, cal, sleep clocks */
+	struct opp_table *opp_table;
 	unsigned long clk_rate;
 	struct mmc_host *mmc;
 	bool use_14lpp_dll_reset;
@@ -150,7 +152,7 @@ struct sdhci_msm_host {
 	bool pwr_irq_flag;
 };
 
-static unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
+static long unsigned int msm_get_clock_rate_for_bus_mode(struct sdhci_host *host,
 						    unsigned int clock)
 {
 	struct mmc_ios ios = host->mmc->ios;
@@ -176,18 +178,37 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
 	struct mmc_ios curr_ios = host->mmc->ios;
 	struct clk *core_clk = msm_host->bulk_clks[0].clk;
 	int rc;
+	struct device *dev = &msm_host->pdev->dev;
+	struct dev_pm_opp *opp;
+	long unsigned int freq;
+
+	if (msm_host->opp_table) {
+		freq = msm_get_clock_rate_for_bus_mode(host, clock);
+		opp = dev_pm_opp_find_freq_floor(dev, &freq);
+		if (IS_ERR(opp)) {
+			pr_err("%s: failed to find OPP for %u at timing %d\n",
+				mmc_hostname(host->mmc), clock, curr_ios.timing);
+			return;
+		}
+		rc = dev_pm_opp_set_rate(dev, freq);
+		if (rc)
+			pr_err("%s: error in setting opp\n", __func__);
 
-	clock = msm_get_clock_rate_for_bus_mode(host, clock);
-	rc = clk_set_rate(core_clk, clock);
-	if (rc) {
-		pr_err("%s: Failed to set clock at rate %u at timing %d\n",
-		       mmc_hostname(host->mmc), clock,
-		       curr_ios.timing);
-		return;
+		msm_host->clk_rate = freq;
+	} else {
+		clock = msm_get_clock_rate_for_bus_mode(host, clock);
+		rc = clk_set_rate(core_clk, clock);
+		if (rc) {
+			pr_err("%s: Failed to set clock at rate %u at timing %d\n",
+			       mmc_hostname(host->mmc), clock,
+			       curr_ios.timing);
+			return;
+		}
+		msm_host->clk_rate = clock;
 	}
-	msm_host->clk_rate = clock;
+
 	pr_debug("%s: Setting clock at rate %lu at timing %d\n",
-		 mmc_hostname(host->mmc), clk_get_rate(core_clk),
+		 mmc_hostname(host->mmc), msm_host->clk_rate,
 		 curr_ios.timing);
 }
 
@@ -1519,6 +1540,16 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	/* Set up the OPP table if it exists */
+	msm_host->opp_table = dev_pm_opp_set_clkname(&pdev->dev, "core");
+
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret) {
+		dev_warn(&pdev->dev, "%s: No OPP table specified\n", __func__);
+		dev_pm_opp_put_clkname(msm_host->opp_table);
+		msm_host->opp_table = NULL;
+	}
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
@@ -1540,6 +1571,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	if (msm_host->opp_table)
+		dev_pm_opp_put_clkname(msm_host->opp_table);
 clk_disable:
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
@@ -1564,6 +1598,9 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
+	dev_pm_opp_of_remove_table(&pdev->dev);
+	if (msm_host->opp_table)
+		dev_pm_opp_put_clkname(msm_host->opp_table);
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(msm_host->bulk_clks),
 				   msm_host->bulk_clks);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
