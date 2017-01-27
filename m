From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V4 1/6] clk: qcom: SDHCI enablement on Nexus 5X / 6P
Date: Fri, 27 Jan 2017 01:10:00 -0800
Message-ID: <1485508205-1904-2-git-send-email-jeremymc@redhat.com>
References: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754766AbdA0JKT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Jan 2017 04:10:19 -0500
In-Reply-To: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com

Add missing clock branch to enable onboard storage
for msm899(2/4).

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 drivers/clk/qcom/gcc-msm8994.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 8afd830..7983288 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -1888,6 +1888,23 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 	},
 };
 
+static struct clk_branch gcc_sdcc1_ahb_clk = {
+	.halt_reg = 0x04c8,
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
 static struct clk_branch gcc_sdcc2_apps_clk = {
 	.halt_reg = 0x0504,
 	.clkr = {
@@ -2231,6 +2248,7 @@ static struct clk_regmap *gcc_msm8994_clocks[] = {
 	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
 	[GCC_SDCC3_APPS_CLK] = &gcc_sdcc3_apps_clk.clkr,
 	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
+	[GCC_SDCC1_AHB_CLK] = &gcc_sdcc1_ahb_clk.clkr,
 	[GCC_SYS_NOC_UFS_AXI_CLK] = &gcc_sys_noc_ufs_axi_clk.clkr,
 	[GCC_SYS_NOC_USB3_AXI_CLK] = &gcc_sys_noc_usb3_axi_clk.clkr,
 	[GCC_TSIF_REF_CLK] = &gcc_tsif_ref_clk.clkr,
-- 
2.6.1

