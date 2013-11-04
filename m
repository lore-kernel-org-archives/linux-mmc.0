From: <dinguyen@altera.com>
Subject: [PATCHv2 1/4] clk: socfpga: Add a clock driver for SOCFPGA's system manager
Date: Mon, 4 Nov 2013 14:36:02 -0600
Message-ID: <1383597364-25613-2-git-send-email-dinguyen@altera.com>
References: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:42765
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659Ab3KDUg0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 15:36:26 -0500
In-Reply-To: <1383597364-25613-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

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
v2: Use the syscon driver
---
 drivers/clk/socfpga/Makefile     |    2 +-
 drivers/clk/socfpga/clk-sysmgr.c |   98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)
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
index 0000000..96f9b26
--- /dev/null
+++ b/drivers/clk/socfpga/clk-sysmgr.c
@@ -0,0 +1,98 @@
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
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
+struct socfpga_sysmgr {
+	struct clk_hw	hw;
+	struct regmap	*sysreg;
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
+	regmap_write(socfpga_sysmgr->sysreg, socfpga_sysmgr->reg, hs_timing);
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
+	socfpga_sysmgr->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
+	if (WARN_ON(IS_ERR(socfpga_sysmgr->sysreg))) {
+		pr_err("%s: No sysmgr phandle specified\n", __func__);
+		return;
+	}
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


