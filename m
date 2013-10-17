From: <dinguyen@altera.com>
Subject: [PATCH 1/4] clk: socfpga: Add a clock driver for SOCFPGA's system manager
Date: Wed, 16 Oct 2013 19:32:38 -0500
Message-ID: <1381969961-12679-2-git-send-email-dinguyen@altera.com>
References: <1381969961-12679-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:54258
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760722Ab3JQAcu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 20:32:50 -0400
In-Reply-To: <1381969961-12679-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Pavel Machek <pavel@denx.de>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The system manager is an IP block on the SOCFPGA platform. The system manager
contains registers that control other IPs on the platform. One of them is
the SD/MMC IP. The system manager contains a register that controls the
clock phase of the SD/MMC CIU.

This patch adds a clock driver that the SD/MMC driver can use by calling
the common clock API in order to set the appropriate register in the
system manager.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Turquette <mturquette@linaro.org>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 drivers/clk/socfpga/Makefile     |    2 +-
 drivers/clk/socfpga/clk-sysmgr.c |   91 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
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
index 0000000..0e13290
--- /dev/null
+++ b/drivers/clk/socfpga/clk-sysmgr.c
@@ -0,0 +1,91 @@
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
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
+extern void __iomem *sys_manager_base_addr;
+
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
+struct socfpga_sysmgr {
+	struct clk_hw	hw;
+	void __iomem    *reg;
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
+	writel(hs_timing, socfpga_sysmgr->reg);
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
+	rc = of_property_read_u32(node, "reg", &reg);
+	if (WARN_ON(rc))
+		return;
+
+	socfpga_sysmgr = kzalloc(sizeof(*socfpga_sysmgr), GFP_KERNEL);
+	if (WARN_ON(!socfpga_sysmgr))
+		return;
+
+	socfpga_sysmgr->reg = sys_manager_base_addr + reg;
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


