From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 01/10] clk: sunxi-ng: Add interface to query
 or configure MMC timing modes.
Date: Mon, 24 Jul 2017 21:58:56 +0800
Message-ID: <20170724135905.28855-2-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBM7227FQKGQEBHEFCOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170724135905.28855-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Starting with the A83T SoC, Allwinner introduced a new timing mode for
its MMC clocks. The new mode changes how the MMC controller sample and
output clocks are delayed to match chip and board specifics. There are
two controls for this, one on the CCU side controlling how the clocks
behave, and one in the MMC controller controlling what inputs to take
and how to route them.

In the old mode, the MMC clock had 2 child clocks providing the output
and sample clocks, which could be delayed by a number of clock cycles
measured from the MMC clock's parent.

With the new mode, the 2 delay clocks are no longer active. Instead,
the delays and associated controls are moved into the MMC controller.
The output of the MMC clock is also halved.

The difference in how things are wired between the modes means that the
clock controls and the MMC controls must match. To achieve this in a
clear, explicit way, we introduce two functions for the MMC driver to
use: one queries the hardware for the current mode set, and the other
allows the MMC driver to request a mode.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/clk/sunxi-ng/Makefile         |  1 +
 drivers/clk/sunxi-ng/ccu_common.h     |  4 ++
 drivers/clk/sunxi-ng/ccu_mmc_timing.c | 70 +++++++++++++++++++++++++++++++++++
 include/linux/clk/sunxi-ng.h          | 35 ++++++++++++++++++
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_mmc_timing.c
 create mode 100644 include/linux/clk/sunxi-ng.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 0c45fa50283d..45a5910379a5 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,5 +1,6 @@
 # Common objects
 lib-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_mmc_timing.o
 lib-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
 
 # Base clock types
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index d6fdd7a789aa..cadd1a9f93b6 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -23,6 +23,10 @@
 #define CCU_FEATURE_FIXED_POSTDIV	BIT(3)
 #define CCU_FEATURE_ALL_PREDIV		BIT(4)
 #define CCU_FEATURE_LOCK_REG		BIT(5)
+#define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
+
+/* MMC timing mode switch bit */
+#define CCU_MMC_NEW_TIMING_MODE		BIT(30)
 
 struct device_node;
 
diff --git a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
new file mode 100644
index 000000000000..f9869f7353c0
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
@@ -0,0 +1,70 @@
+/*
+ * Copyright (c) 2017 Chen-Yu Tsai. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/sunxi-ng.h>
+
+#include "ccu_common.h"
+
+/**
+ * sunxi_ccu_set_mmc_timing_mode: Configure the MMC clock timing mode
+ * @clk: clock to be configured
+ * @new_mode: true for new timing mode introduced in A83T and later
+ *
+ * Returns 0 on success, -ENOTSUPP if the clock does not support
+ * switching modes.
+ */
+int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	unsigned long flags;
+	u32 val;
+
+	if (!(cm->features & CCU_FEATURE_MMC_TIMING_SWITCH))
+		return -ENOTSUPP;
+
+	spin_lock_irqsave(cm->lock, flags);
+
+	val = readl(cm->base + cm->reg);
+	if (new_mode)
+		val |= CCU_MMC_NEW_TIMING_MODE;
+	else
+		val &= ~CCU_MMC_NEW_TIMING_MODE;
+	writel(val, cm->base + cm->reg);
+
+	spin_unlock_irqrestore(cm->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sunxi_ccu_set_mmc_timing_mode);
+
+/**
+ * sunxi_ccu_set_mmc_timing_mode: Get the current MMC clock timing mode
+ * @clk: clock to query
+ *
+ * Returns 0 if the clock is in old timing mode, > 0 if it is in
+ * new timing mode, and -ENOTSUPP if the clock does not support
+ * this function.
+ */
+int sunxi_ccu_get_mmc_timing_mode(struct clk *clk)
+{
+	struct clk_hw *hw = __clk_get_hw(clk);
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+
+	if (!(cm->features & CCU_FEATURE_MMC_TIMING_SWITCH))
+		return -ENOTSUPP;
+
+	return !!(readl(cm->base + cm->reg) & CCU_MMC_NEW_TIMING_MODE);
+}
+EXPORT_SYMBOL_GPL(sunxi_ccu_get_mmc_timing_mode);
diff --git a/include/linux/clk/sunxi-ng.h b/include/linux/clk/sunxi-ng.h
new file mode 100644
index 000000000000..990f760f70e5
--- /dev/null
+++ b/include/linux/clk/sunxi-ng.h
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2017 Chen-Yu Tsai. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_CLK_SUNXI_NG_H_
+#define _LINUX_CLK_SUNXI_NG_H_
+
+#include <linux/errno.h>
+
+#ifdef CONFIG_SUNXI_CCU
+int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode);
+int sunxi_ccu_get_mmc_timing_mode(struct clk *clk);
+#else
+static inline int sunxi_ccu_set_mmc_timing_mode(struct clk *clk,
+						bool new_mode)
+{
+	return -ENOTSUPP;
+}
+
+static inline int sunxi_ccu_get_mmc_timing_mode(struct clk *clk)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+#endif
-- 
2.13.3
