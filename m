From: <dinguyen@altera.com>
Subject: [PATCHv5 2/4] clk: socfpga: Add a hook for SD/MMC driver to control CIU clock settings
Date: Mon, 9 Dec 2013 07:57:40 -0600
Message-ID: <1386597462-29471-3-git-send-email-dinguyen@altera.com>
References: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:58275
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933535Ab3LIN7f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2013 08:59:35 -0500
In-Reply-To: <1386597462-29471-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
the correct clock-phase for the CIU clock of the SD/MMC IP.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v5: Use the "snps,dw-mshc" binding
v4: none
v3: none
v2: none
---
 drivers/clk/socfpga/clk.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 60cb2f5..fe2670e 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -55,7 +55,13 @@
 #define div_mask(width)	((1 << (width)) - 1)
 #define streq(a, b) (strcmp((a), (b)) == 0)
 
+#define SYSMGR_SDMMCGRP_CTRL_OFFSET	0x108
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
 extern void __iomem *clk_mgr_base_addr;
+extern void __iomem *sys_manager_base_addr;
 
 struct socfpga_clk {
 	struct clk_gate hw;
@@ -68,6 +74,22 @@ struct socfpga_clk {
 };
 #define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw.hw)
 
+static int sdmmc_ciuclk_prepare(struct clk_hw *hwclk)
+{
+	struct device_node *np;
+	u32 timing[2];
+	u32 hs_timing;
+
+	np = of_find_compatible_node(NULL, NULL, "snps,dw-mshc");
+	if (of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2)) {
+		pr_err("SDMMC: cannot find samsung,dw-mshc-sdr-timing!\n");
+		return -ENODATA;
+	}
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
+	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
+	return 0;
+}
+
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
@@ -274,6 +296,9 @@ static void __init socfpga_gate_clk_init(struct device_node *node,
 		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
 		socfpga_clk->hw.bit_idx = clk_gate[1];
 
+		if (streq(clk_name, "sdmmc_clk"))
+			gateclk_ops.prepare = sdmmc_ciuclk_prepare;
+
 		gateclk_ops.enable = clk_gate_ops.enable;
 		gateclk_ops.disable = clk_gate_ops.disable;
 	}
-- 
1.7.9.5


