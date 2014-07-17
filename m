From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 06/14] clk: sunxi: factors: Invert the probing logic
Date: Thu, 17 Jul 2014 11:08:46 +0200
Message-ID: <1405588134-2396-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Until now, the factors clock probing was done directly by sunxi_init_clocks,
with the factors registration being called directly with the clocks data passed
as an argument.

This approch has shown its limits when we added more clocks, since we couldn't
really split code with such a logic in smaller files, and led to a huge file
having all the clocks.

Introduce an intermediate probing function, so that factor clocks will be able
to directly be called by CLK_OF_DECLARE, which will in turn ease the split into
several files.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/clk/sunxi/clk-factors.c | 101 +++++++++++++++++++++++++++++++++++++---
 drivers/clk/sunxi/clk-factors.h |  16 ++++++-
 drivers/clk/sunxi/clk-sunxi.c   |  95 ++-----------------------------------
 3 files changed, 113 insertions(+), 99 deletions(-)

diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
index f8f45a7ffcd7..f329c43e20b2 100644
--- a/drivers/clk/sunxi/clk-factors.c
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -9,18 +9,18 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
-#include <linux/io.h>
-#include <linux/err.h>
 #include <linux/string.h>
 
-#include <linux/delay.h>
-
 #include "clk-factors.h"
 
 /*
- * DOC: basic adjustable factor-based clock that cannot gate
+ * DOC: basic adjustable factor-based clock
  *
  * Traits of this clock:
  * prepare - clk_prepare only ensures that parents are prepared
@@ -32,6 +32,8 @@
 
 #define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
 
+#define FACTORS_MAX_PARENTS		5
+
 #define SETMASK(len, pos)		(((1U << (len)) - 1) << (pos))
 #define CLRMASK(len, pos)		(~(SETMASK(len, pos)))
 #define FACTOR_GET(bit, len, reg)	(((reg) & SETMASK(len, bit)) >> (bit))
@@ -174,10 +176,97 @@ static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-const struct clk_ops clk_factors_ops = {
+static const struct clk_ops clk_factors_ops = {
 	.determine_rate = clk_factors_determine_rate,
 	.prepare = clk_factors_prepare,
 	.recalc_rate = clk_factors_recalc_rate,
 	.round_rate = clk_factors_round_rate,
 	.set_rate = clk_factors_set_rate,
 };
+
+struct clk * __init sunxi_factors_register(struct device_node *node,
+					   const struct factors_data *data,
+					   spinlock_t *lock)
+{
+	struct clk *clk;
+	struct clk_factors *factors;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk_hw *gate_hw = NULL;
+	struct clk_hw *mux_hw = NULL;
+	const char *clk_name = node->name;
+	const char *parents[FACTORS_MAX_PARENTS];
+	void *reg;
+	int i = 0;
+
+	reg = of_iomap(node, 0);
+
+	/* if we have a mux, we will have >1 parents */
+	while (i < FACTORS_MAX_PARENTS &&
+	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	/*
+	 * some factor clocks, such as pll5 and pll6, may have multiple
+	 * outputs, and have their name designated in factors_data
+	 */
+	if (data->name)
+		clk_name = data->name;
+	else
+		of_property_read_string(node, "clock-output-names", &clk_name);
+
+	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
+	if (!factors)
+		return NULL;
+
+	/* set up factors properties */
+	factors->reg = reg;
+	factors->config = data->table;
+	factors->get_factors = data->getter;
+	factors->lock = lock;
+
+	/* Add a gate if this factor clock can be gated */
+	if (data->enable) {
+		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(factors);
+			return NULL;
+		}
+
+		/* set up gate properties */
+		gate->reg = reg;
+		gate->bit_idx = data->enable;
+		gate->lock = factors->lock;
+		gate_hw = &gate->hw;
+	}
+
+	/* Add a mux if this factor clock can be muxed */
+	if (data->mux) {
+		mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
+		if (!mux) {
+			kfree(factors);
+			kfree(gate);
+			return NULL;
+		}
+
+		/* set up gate properties */
+		mux->reg = reg;
+		mux->shift = data->mux;
+		mux->mask = SUNXI_FACTORS_MUX_MASK;
+		mux->lock = factors->lock;
+		mux_hw = &mux->hw;
+	}
+
+	clk = clk_register_composite(NULL, clk_name,
+			parents, i,
+			mux_hw, &clk_mux_ops,
+			&factors->hw, &clk_factors_ops,
+			gate_hw, &clk_gate_ops, 0);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
index 2b8579a24039..f875b7d7d9b6 100644
--- a/drivers/clk/sunxi/clk-factors.h
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -3,9 +3,12 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/spinlock.h>
 
 #define SUNXI_FACTORS_NOT_APPLICABLE	(0)
 
+#define SUNXI_FACTORS_MUX_MASK 0x3
+
 struct clk_factors_config {
 	u8 nshift;
 	u8 nwidth;
@@ -18,6 +21,14 @@ struct clk_factors_config {
 	u8 n_start;
 };
 
+struct factors_data {
+	int enable;
+	int mux;
+	struct clk_factors_config *table;
+	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
+	const char *name;
+};
+
 struct clk_factors {
 	struct clk_hw hw;
 	void __iomem *reg;
@@ -28,5 +39,8 @@ struct clk_factors {
 	unsigned long min_rate;
 };
 
-extern const struct clk_ops clk_factors_ops;
+struct clk * __init sunxi_factors_register(struct device_node *node,
+					   const struct factors_data *data,
+					   spinlock_t *lock);
+
 #endif
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 8975972f6da5..130e0d1ae510 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
+#include <linux/spinlock.h>
 
 #include "clk-factors.h"
 
@@ -440,16 +441,6 @@ EXPORT_SYMBOL(clk_sunxi_mmc_phase_control);
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
 
-#define SUNXI_FACTORS_MUX_MASK 0x3
-
-struct factors_data {
-	int enable;
-	int mux;
-	struct clk_factors_config *table;
-	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
-	const char *name;
-};
-
 static struct clk_factors_config sun4i_pll1_config = {
 	.nshift = 8,
 	.nwidth = 5,
@@ -583,89 +574,9 @@ static const struct factors_data sun7i_a20_out_data __initconst = {
 };
 
 static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
-						const struct factors_data *data)
+						   const struct factors_data *data)
 {
-	struct clk *clk;
-	struct clk_factors *factors;
-	struct clk_gate *gate = NULL;
-	struct clk_mux *mux = NULL;
-	struct clk_hw *gate_hw = NULL;
-	struct clk_hw *mux_hw = NULL;
-	const char *clk_name = node->name;
-	const char *parents[SUNXI_MAX_PARENTS];
-	void *reg;
-	int i = 0;
-
-	reg = of_iomap(node, 0);
-
-	/* if we have a mux, we will have >1 parents */
-	while (i < SUNXI_MAX_PARENTS &&
-	       (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
-		i++;
-
-	/*
-	 * some factor clocks, such as pll5 and pll6, may have multiple
-	 * outputs, and have their name designated in factors_data
-	 */
-	if (data->name)
-		clk_name = data->name;
-	else
-		of_property_read_string(node, "clock-output-names", &clk_name);
-
-	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
-	if (!factors)
-		return NULL;
-
-	/* Add a gate if this factor clock can be gated */
-	if (data->enable) {
-		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
-		if (!gate) {
-			kfree(factors);
-			return NULL;
-		}
-
-		/* set up gate properties */
-		gate->reg = reg;
-		gate->bit_idx = data->enable;
-		gate->lock = &clk_lock;
-		gate_hw = &gate->hw;
-	}
-
-	/* Add a mux if this factor clock can be muxed */
-	if (data->mux) {
-		mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
-		if (!mux) {
-			kfree(factors);
-			kfree(gate);
-			return NULL;
-		}
-
-		/* set up gate properties */
-		mux->reg = reg;
-		mux->shift = data->mux;
-		mux->mask = SUNXI_FACTORS_MUX_MASK;
-		mux->lock = &clk_lock;
-		mux_hw = &mux->hw;
-	}
-
-	/* set up factors properties */
-	factors->reg = reg;
-	factors->config = data->table;
-	factors->get_factors = data->getter;
-	factors->lock = &clk_lock;
-
-	clk = clk_register_composite(NULL, clk_name,
-			parents, i,
-			mux_hw, &clk_mux_ops,
-			&factors->hw, &clk_factors_ops,
-			gate_hw, &clk_gate_ops, 0);
-
-	if (!IS_ERR(clk)) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		clk_register_clkdev(clk, clk_name, NULL);
-	}
-
-	return clk;
+	return sunxi_factors_register(node, data, &clk_lock);
 }
 
 
-- 
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
