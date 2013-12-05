From: <dinguyen@altera.com>
Subject: [PATCHv4 2/4] clk: socfpga: Add a hook for SD/MMC driver to control CIU clock settings
Date: Thu, 5 Dec 2013 11:14:35 -0600
Message-ID: <1386263677-7733-3-git-send-email-dinguyen@altera.com>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:27137
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757128Ab3LERQY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 12:16:24 -0500
In-Reply-To: <1386263677-7733-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
the correct clock-phase for the CIU clock of the SD/MMC IP.

Re-use the "rockchip,rk2928-dw-mshc" binding as it is already defined and
appropriate for the SOCFPGA platform as well.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 drivers/clk/socfpga/clk.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 60cb2f5..01baf20 100644
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
+	np = of_find_compatible_node(NULL, NULL, "rockchip,rk2928-dw-mshc");
+	if (of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2)) {
+		pr_err("SDMMC: cannot find samsung,dw-mshc-sdr-timing!\n");
+		return -ENODATA;
+	}
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[1], timing[0]);
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


