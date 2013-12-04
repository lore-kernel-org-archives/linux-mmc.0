From: <dinguyen@altera.com>
Subject: [PATCHv3 1/4] clk: socfpga: Add a clock driver for SOCFPGA's system manager
Date: Wed, 4 Dec 2013 16:52:53 -0600
Message-ID: <1386197576-3825-2-git-send-email-dinguyen@altera.com>
References: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:26300 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756111Ab3LDWyy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Dec 2013 17:54:54 -0500
In-Reply-To: <1386197576-3825-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com, arnd@arndb.de, mturquette@linaro.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dinh Nguyen <dinguyen@altera.com>

From: Dinh Nguyen <dinguyen@altera.com>

The system manager is an IP block on the SOCFPGA platform. The system manager
contains registers that control other IPs on the platform. One of the IPs that
the system manager has control over is the SD/MMC, by way of controlling the
clock phase on the SD/MMC Card Interface Unit.

This patch adds a clock driver that the SD/MMC driver can use by calling
the common clock API in order to set the appropriate register in the
system manager by way of a syscon driver.

This clock driver can also be re-used for other IPs that need to poke the system
manager.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
v3: Not use the syscon driver because as of 3.13-rc1, the syscon driver
is loaded after the clock driver.

v2: Use the syscon driver
---
 drivers/clk/socfpga/Makefile     |    2 +-
 drivers/clk/socfpga/clk-sysmgr.c |   88 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/socfpga/clk-sysmgr.c

diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index 0303c0b..cfceabc 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -1 +1 @@
-obj-y += clk.o
+obj-y += clk.o clk-sysmgr.o
diff --git a/drivers/clk/socfpga/clk-sysmgr.c b/drivers/clk/socfpga/clk-sysmgr.c
new file mode 100644
index 0000000..7538b22
--- /dev/null
+++ b/drivers/clk/socfpga/clk-sysmgr.c
@@ -0,0 +1,88 @@
+/*
+ * Copyright 2013 Altera Corporation <www.altera.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
+extern void __iomem *sys_manager_base_addr;
+
+struct socfpga_sysmgr {
+	struct clk_hw	hw;
+	u32     reg;
+};
+#define to_sysmgr_clk(p) container_of(p, struct socfpga_sysmgr, hw)
+
+static int sysmgr_set_dwmmc_drvsel_smpsel(struct clk_hw *hwclk)
+{
+	struct device_node *np;
+	struct socfpga_sysmgr *socfpga_sysmgr = to_sysmgr_clk(hwclk);
+	u32 timing[2];
+	u32 hs_timing;
+
+	np = of_find_compatible_node(NULL, NULL, "altr,socfpga-dw-mshc");
+	of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2);
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[1], timing[0]);
+	writel(hs_timing, sys_manager_base_addr + socfpga_sysmgr->reg);
+	return 0;
+}
+
+static const struct clk_ops clk_sysmgr_sdmmc_ops = {
+	.enable = sysmgr_set_dwmmc_drvsel_smpsel,
+};
+
+static void __init socfpga_sysmgr_init(struct device_node *node, const struct clk_ops *ops)
+{
+	u32 reg;
+	struct clk *clk;
+	struct socfpga_sysmgr *socfpga_sysmgr;
+	const char *clk_name = node->name;
+	struct clk_init_data init;
+	int rc;
+
+	socfpga_sysmgr = kzalloc(sizeof(*socfpga_sysmgr), GFP_KERNEL);
+	if (WARN_ON(!socfpga_sysmgr))
+		return;
+
+	rc = of_property_read_u32(node, "reg", &reg);
+	if (WARN_ON(rc))
+		return;
+
+	socfpga_sysmgr->reg = reg;
+
+	init.name = clk_name;
+	init.ops = ops;
+	init.flags = 0;
+	init.num_parents = 0;
+
+	socfpga_sysmgr->hw.init = &init;
+	clk = clk_register(NULL, &socfpga_sysmgr->hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(socfpga_sysmgr);
+		return;
+	}
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (WARN_ON(rc))
+		return;
+}
+
+static void __init sysmgr_init(struct device_node *node)
+{
+	socfpga_sysmgr_init(node, &clk_sysmgr_sdmmc_ops);
+}
+CLK_OF_DECLARE(sysmgr, "altr,sysmgr-sdmmc-sdr", sysmgr_init);
-- 
1.7.9.5


