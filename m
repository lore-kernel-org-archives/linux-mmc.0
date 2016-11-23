From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH 1/5] clk: gcc: Updates for SDHCI enablement
Date: Tue, 22 Nov 2016 17:09:44 -0800
Message-ID: <1479863388-23678-2-git-send-email-jeremymc@redhat.com>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756084AbcKWBUJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 20:20:09 -0500
In-Reply-To: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, jeremymc@redhat.com

Global clock updates to enable onboard SDHCI / MMC.
Re-tabify dt-bindings to align correctly in vim.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 drivers/clk/qcom/gcc-msm8994.c               | 108 +++++++++++++++++++++------
 include/dt-bindings/clock/qcom,gcc-msm8994.h |  32 ++++----
 2 files changed, 106 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index e3d15e4..5a8ff2a 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -24,6 +24,7 @@
 
 #include "common.h"
 #include "clk-regmap.h"
+#include "clk-pll.h"
 #include "clk-alpha-pll.h"
 #include "clk-rcg.h"
 #include "clk-branch.h"
@@ -54,7 +55,7 @@ static const struct parent_map gcc_xo_gpll0_gpll4_map[] = {
 static const char * const gcc_xo_gpll0_gpll4[] = {
 	"xo",
 	"gpll0",
-	"gpll4",
+	"gpll4_vote",
 };
 
 #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
@@ -97,29 +98,65 @@ static struct clk_alpha_pll_postdiv gpll0 = {
 	},
 };
 
-static struct clk_alpha_pll gpll4_early = {
-	.offset = 0x1dc0,
-	.clkr = {
-		.enable_reg = 0x1480,
-		.enable_mask = BIT(4),
-		.hw.init = &(struct clk_init_data)
-		{
-			.name = "gpll4_early",
-			.parent_names = (const char *[]) { "xo" },
-			.num_parents = 1,
-			.ops = &clk_alpha_pll_ops,
-		},
+
+static struct clk_rcg2 config_noc_clk_src = {
+	.cmd_rcgr = 0x0150,
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_map,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "config_noc_clk_src",
+		.parent_names = gcc_xo_gpll0,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 periph_noc_clk_src = {
+	.cmd_rcgr = 0x0190,
+	.hid_width = 5,
+	.mnd_width = 8,
+	.parent_map = gcc_xo_gpll0_map,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "periph_noc_clk_src",
+		.parent_names = gcc_xo_gpll0,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 system_noc_clk_src = {
+	.cmd_rcgr = 0x0120, //TODO
+	.hid_width = 5,
+	.parent_map = gcc_xo_gpll0_map,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "system_noc_clk_src",
+		.parent_names = gcc_xo_gpll0,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
-static struct clk_alpha_pll_postdiv gpll4 = {
-	.offset = 0x1dc0,
+static struct clk_pll gpll4 = {
+	.status_reg = 0x1dc0,
+	.status_bit = 30,
 	.clkr.hw.init = &(struct clk_init_data)
 	{
 		.name = "gpll4",
-		.parent_names = (const char *[]) { "gpll4_early" },
+		.parent_names = (const char *[]) { "xo" },
 		.num_parents = 1,
-		.ops = &clk_alpha_pll_postdiv_ops,
+		.ops = &clk_pll_ops,
+	},
+};
+
+static struct clk_regmap gpll4_vote = {
+	.enable_reg = 0x1480,
+	.enable_mask = BIT(4),
+	.hw.init = &(struct clk_init_data)
+	{
+		.name = "gpll4_vote",
+		.parent_names = (const char *[]) { "gpll4" },
+		.num_parents = 1,
+		.ops = &clk_pll_vote_ops,
 	},
 };
 
@@ -896,8 +933,8 @@ static struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
 	F(25000000, P_GPLL0, 12, 1, 2),
 	F(50000000, P_GPLL0, 12, 0, 0),
 	F(100000000, P_GPLL0, 6, 0, 0),
-	F(192000000, P_GPLL4, 2, 0, 0),
-	F(384000000, P_GPLL4, 1, 0, 0),
+	F(172000000, P_GPLL4, 2, 0, 0),
+	F(344000000, P_GPLL4, 1, 0, 0),
 	{ }
 };
 
@@ -1057,6 +1094,10 @@ static struct clk_branch gcc_blsp1_ahb_clk = {
 		.hw.init = &(struct clk_init_data)
 		{
 			.name = "gcc_blsp1_ahb_clk",
+			.parent_names = (const char *[]){
+				"periph_noc_clk_src",
+			},
+			.num_parents = 1,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1872,6 +1913,7 @@ static struct clk_branch gcc_pdm2_clk = {
 
 static struct clk_branch gcc_sdcc1_apps_clk = {
 	.halt_reg = 0x04c4,
+	.halt_check = BRANCH_HALT_VOTED,
 	.clkr = {
 		.enable_reg = 0x04c4,
 		.enable_mask = BIT(0),
@@ -1888,6 +1930,26 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 	},
 };
 
+
+static struct clk_branch gcc_sdcc1_ahb_clk = {
+	.halt_reg = 0x04c8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x04c8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data)
+		{
+			.name = "gcc_sdcc1_ahb_clk",
+			.parent_names = (const char *[]){
+				"periph_noc_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+
 static struct clk_branch gcc_sdcc2_apps_clk = {
 	.halt_reg = 0x0504,
 	.clkr = {
@@ -2123,10 +2185,13 @@ static struct clk_branch gcc_usb_hs_system_clk = {
 };
 
 static struct clk_regmap *gcc_msm8994_clocks[] = {
-	[GPLL0_EARLY] = &gpll0_early.clkr,
+	[GPLL0_VOTE] = &gpll0_early.clkr,
 	[GPLL0] = &gpll0.clkr,
-	[GPLL4_EARLY] = &gpll4_early.clkr,
+	[CONFIG_NOC_CLK_SRC] = &config_noc_clk_src.clkr,
+	[PERIPH_NOC_CLK_SRC] = &periph_noc_clk_src.clkr,
+	[SYSTEM_NOC_CLK_SRC] = &system_noc_clk_src.clkr,
 	[GPLL4] = &gpll4.clkr,
+	[GPLL4_VOTE] = &gpll4_vote,
 	[UFS_AXI_CLK_SRC] = &ufs_axi_clk_src.clkr,
 	[USB30_MASTER_CLK_SRC] = &usb30_master_clk_src.clkr,
 	[BLSP1_QUP1_I2C_APPS_CLK_SRC] = &blsp1_qup1_i2c_apps_clk_src.clkr,
@@ -2231,6 +2296,7 @@ static struct clk_regmap *gcc_msm8994_clocks[] = {
 	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
 	[GCC_SDCC3_APPS_CLK] = &gcc_sdcc3_apps_clk.clkr,
 	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
+	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
 	[GCC_SYS_NOC_UFS_AXI_CLK] = &gcc_sys_noc_ufs_axi_clk.clkr,
 	[GCC_SYS_NOC_USB3_AXI_CLK] = &gcc_sys_noc_usb3_axi_clk.clkr,
 	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,
diff --git a/include/dt-bindings/clock/qcom,gcc-msm8994.h b/include/dt-bindings/clock/qcom,gcc-msm8994.h
index 0ae494b..76ef541 100644
--- a/include/dt-bindings/clock/qcom,gcc-msm8994.h
+++ b/include/dt-bindings/clock/qcom,gcc-msm8994.h
@@ -15,10 +15,10 @@
 #ifndef _DT_BINDINGS_CLK_MSM_GCC_8994_H
 #define _DT_BINDINGS_CLK_MSM_GCC_8994_H
 
-#define GPLL0_EARLY				0
 #define GPLL0					1
-#define GPLL4_EARLY				2
-#define GPLL4					3
+#define GPLL0_VOTE				0
+#define GPLL4					2
+#define GPLL4_VOTE				3
 #define UFS_AXI_CLK_SRC				4
 #define USB30_MASTER_CLK_SRC			5
 #define BLSP1_QUP1_I2C_APPS_CLK_SRC		6
@@ -123,16 +123,22 @@
 #define GCC_SDCC2_APPS_CLK			105
 #define GCC_SDCC3_APPS_CLK			106
 #define GCC_SDCC4_APPS_CLK			107
-#define GCC_SYS_NOC_UFS_AXI_CLK			108
-#define GCC_SYS_NOC_USB3_AXI_CLK		109
-#define GCC_TSIF_REF_CLK			110
-#define GCC_UFS_AXI_CLK				111
-#define GCC_UFS_RX_CFG_CLK			112
-#define GCC_UFS_TX_CFG_CLK			113
-#define GCC_USB30_MASTER_CLK			114
-#define GCC_USB30_MOCK_UTMI_CLK			115
-#define GCC_USB3_PHY_AUX_CLK			116
-#define GCC_USB_HS_SYSTEM_CLK			117
+#define GCC_SDCC1_AHB_CLK			108
+#define GCC_SDCC2_AHB_CLK			109
+
+#define GCC_SYS_NOC_UFS_AXI_CLK			110
+#define GCC_SYS_NOC_USB3_AXI_CLK		111
+#define GCC_TSIF_REF_CLK			112
+#define GCC_UFS_AXI_CLK				113
+#define GCC_UFS_RX_CFG_CLK			114
+#define GCC_UFS_TX_CFG_CLK			115
+#define GCC_USB30_MASTER_CLK			116
+#define GCC_USB30_MOCK_UTMI_CLK			117
+#define GCC_USB3_PHY_AUX_CLK			118
+#define GCC_USB_HS_SYSTEM_CLK			119
+#define SYSTEM_NOC_CLK_SRC			120
+#define PERIPH_NOC_CLK_SRC			121
+#define CONFIG_NOC_CLK_SRC			122
 
 /* Indexes for GDSCs */
 #define BIMC_GDSC				0
-- 
2.6.1

