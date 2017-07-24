From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 02/10] clk: sunxi-ng: Add MP_MMC clocks that
 support MMC timing modes switching
Date: Mon, 24 Jul 2017 21:58:57 +0800
Message-ID: <20170724135905.28855-3-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBMX227FQKGQE7YWST6I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

All of our MMC clocks are of the MP clock type. A few MMC clocks on some
SoCs, such as MMC2 on the A83T, support new/old timing mode switching.

>From a clock rate point of view, when the new timing mode is active. the
output clock rate is halved.

This patch adds a special wrapper class of clocks, MP_MMC, around the
generic MP type clocks. The rate related callbacks in ccu_mp_mmc_ops
for this class look at the timing mode bit and apply the /2 post-divider
when needed, before passing it through to the generic class ops,
ccu_mp_ops.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/clk/sunxi-ng/ccu_mp.c | 80 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mp.h | 30 ++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index b917ad7a386c..688855e7dc8c 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -172,3 +172,83 @@ const struct clk_ops ccu_mp_ops = {
 	.recalc_rate	= ccu_mp_recalc_rate,
 	.set_rate	= ccu_mp_set_rate,
 };
+
+/*
+ * Support for MMC timing mode switching
+ *
+ * The MMC clocks on some SoCs support switching between old and
+ * new timing modes. A platform specific API is provided to query
+ * and set the timing mode on supported SoCs.
+ *
+ * In addition, a special class of ccu_mp_ops is provided, which
+ * takes in to account the timing mode switch. When the new timing
+ * mode is active, the clock output rate is halved. This new class
+ * is a wrapper around the generic ccu_mp_ops. When clock rates
+ * are passed through to ccu_mp_ops callbacks, they are doubled
+ * if the new timing mode bit is set, to account for the post
+ * divider. Conversely, when clock rates are passed back, they
+ * are halved if the mode bit is set.
+ */
+
+static unsigned long ccu_mp_mmc_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	unsigned long rate = ccu_mp_recalc_rate(hw, parent_rate);
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val = readl(cm->base + cm->reg);
+
+	if (val & CCU_MMC_NEW_TIMING_MODE)
+		return rate / 2;
+	return rate;
+}
+
+static int ccu_mp_mmc_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val = readl(cm->base + cm->reg);
+	int ret;
+
+	/* adjust the requested clock rate */
+	if (val & CCU_MMC_NEW_TIMING_MODE) {
+		req->rate *= 2;
+		req->min_rate *= 2;
+		req->max_rate *= 2;
+	}
+
+	ret = ccu_mp_determine_rate(hw, req);
+
+	/* re-adjust the requested clock rate back */
+	if (val & CCU_MMC_NEW_TIMING_MODE) {
+		req->rate /= 2;
+		req->min_rate /= 2;
+		req->max_rate /= 2;
+	}
+
+	return ret;
+}
+
+static int ccu_mp_mmc_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct ccu_common *cm = hw_to_ccu_common(hw);
+	u32 val = readl(cm->base + cm->reg);
+
+	if (val & CCU_MMC_NEW_TIMING_MODE)
+		rate *= 2;
+
+	return ccu_mp_set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops ccu_mp_mmc_ops = {
+	.disable	= ccu_mp_disable,
+	.enable		= ccu_mp_enable,
+	.is_enabled	= ccu_mp_is_enabled,
+
+	.get_parent	= ccu_mp_get_parent,
+	.set_parent	= ccu_mp_set_parent,
+
+	.determine_rate	= ccu_mp_mmc_determine_rate,
+	.recalc_rate	= ccu_mp_mmc_recalc_rate,
+	.set_rate	= ccu_mp_mmc_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index 915625e97d98..aaef11d747ea 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -14,6 +14,7 @@
 #ifndef _CCU_MP_H_
 #define _CCU_MP_H_
 
+#include <linux/bitops.h>
 #include <linux/clk-provider.h>
 
 #include "ccu_common.h"
@@ -74,4 +75,33 @@ static inline struct ccu_mp *hw_to_ccu_mp(struct clk_hw *hw)
 
 extern const struct clk_ops ccu_mp_ops;
 
+/*
+ * Special class of M-P clock that supports MMC timing modes
+ *
+ * Since the MMC clock registers all follow the same layout, we can
+ * simplify the macro for this particular case. In addition, as
+ * switching modes also affects the output clock rate, we need to
+ * have CLK_GET_RATE_NOCACHE for all these types of clocks.
+ */
+
+#define SUNXI_CCU_MP_MMC_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				       _flags)				\
+	struct ccu_mp _struct = {					\
+		.enable	= BIT(31),					\
+		.m	= _SUNXI_CCU_DIV(0, 4),				\
+		.p	= _SUNXI_CCU_DIV(16, 2),			\
+		.mux	= _SUNXI_CCU_MUX(24, 2),			\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_MMC_TIMING_SWITCH, \
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &ccu_mp_mmc_ops, \
+							      CLK_GET_RATE_NOCACHE | \
+							      _flags),	\
+		}							\
+	}
+
+extern const struct clk_ops ccu_mp_mmc_ops;
+
 #endif /* _CCU_MP_H_ */
-- 
2.13.3
