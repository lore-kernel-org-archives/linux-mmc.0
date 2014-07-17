From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 12/14] clk: sunxi: mod0: Introduce MMC proper phase handling
Date: Thu, 17 Jul 2014 11:08:52 +0200
Message-ID: <1405588134-2396-13-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41397 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754585AbaGQJKT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 05:10:19 -0400
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

The MMC clock we thought we had until now are actually not one but three
different clocks.

The main one is unchanged, and will have three outputs:
  - The clock fed into the MMC
  - a sample and output clocks, to deal with when should we output/sample data
    to/from the MMC bus

The phase control we had are actually controlling the two latter clocks, but
the main MMC one is unchanged.

We can adjust the phase with a 3 bits value, from 0 to 7, 0 meaning a 180 phase
shift, and the other values being the number of periods from the MMC parent
clock to outphase the clock of.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
 drivers/clk/sunxi/clk-mod0.c                      | 189 ++++++++++++++++++++++
 2 files changed, 191 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
index 112d8525b6e0..d3786ab9b7a7 100644
--- a/Documentation/devicetree/bindings/clock/sunxi.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -47,6 +47,8 @@ Required properties:
 	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
 	"allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
 	"allwinner,sun4i-a10-mbus-clk" - for the MBUS clock on A10
+	"allwinner,sun4i-a10-mmc-output-clk" - for the MMC output clock on A10
+	"allwinner,sun4i-a10-mmc-sample-clk" - for the MMC sample clock on A10
 	"allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
 	"allwinner,sun7i-a20-out-clk" - for the external output clocks
 	"allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index a179299ec79d..d72cb7ff1356 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/of_address.h>
 
 #include "clk-factors.h"
 
@@ -92,3 +93,191 @@ static void __init sun4i_a10_mbus_setup(struct device_node *node)
 	clk_prepare_enable(mbus);
 }
 CLK_OF_DECLARE(sun4i_a10_mbus, "allwinner,sun4i-a10-mbus-clk", sun4i_a10_mbus_setup);
+
+struct mmc_phase_data {
+	u8	offset;
+};
+
+struct mmc_phase {
+	struct clk_hw		hw;
+	void __iomem		*reg;
+	struct mmc_phase_data	*data;
+	spinlock_t		*lock;
+};
+
+#define to_mmc_phase(_hw) container_of(_hw, struct mmc_phase, hw)
+
+static int mmc_get_phase(struct clk_hw *hw)
+{
+	struct clk *mmc, *mmc_parent, *clk = hw->clk;
+	struct mmc_phase *phase = to_mmc_phase(hw);
+	unsigned int mmc_rate, mmc_parent_rate;
+	u16 step, mmc_div;
+	u32 value;
+	u8 delay;
+
+	value = readl(phase->reg);
+	delay = (value >> phase->data->offset) & 0x3;
+
+	if (!delay)
+		return 180;
+
+	/* Get the main MMC clock */
+	mmc = clk_get_parent(clk);
+	if (!mmc)
+		return -EINVAL;
+
+	/* And its rate */
+	mmc_rate = clk_get_rate(mmc);
+	if (!mmc_rate)
+		return -EINVAL;
+
+	/* Now, get the MMC parent (most likely some PLL) */
+	mmc_parent = clk_get_parent(mmc);
+	if (!mmc_parent)
+		return -EINVAL;
+
+	/* And its rate */
+	mmc_parent_rate = clk_get_rate(mmc_parent);
+	if (!mmc_parent_rate)
+		return -EINVAL;
+
+	/* Get MMC clock divider */
+	mmc_div = mmc_parent_rate / mmc_rate;
+
+	step = DIV_ROUND_CLOSEST(360, mmc_div);
+	return delay * step;
+}
+
+static int mmc_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk *mmc, *mmc_parent, *clk = hw->clk;
+	struct mmc_phase *phase = to_mmc_phase(hw);
+	unsigned int mmc_rate, mmc_parent_rate;
+	unsigned long flags;
+	u32 value;
+	u8 delay;
+
+	/* Get the main MMC clock */
+	mmc = clk_get_parent(clk);
+	if (!mmc)
+		return -EINVAL;
+
+	/* And its rate */
+	mmc_rate = clk_get_rate(mmc);
+	if (!mmc_rate)
+		return -EINVAL;
+
+	/* Now, get the MMC parent (most likely some PLL) */
+	mmc_parent = clk_get_parent(mmc);
+	if (!mmc_parent)
+		return -EINVAL;
+
+	/* And its rate */
+	mmc_parent_rate = clk_get_rate(mmc_parent);
+	if (!mmc_parent_rate)
+		return -EINVAL;
+
+	if (degrees != 180) {
+		u16 step, mmc_div;
+
+		/* Get MMC clock divider */
+		mmc_div = mmc_parent_rate / mmc_rate;
+
+		/*
+		 * We can only outphase the clocks by multiple of the
+		 * PLL's period.
+		 *
+		 * Since the MMC clock in only a divider, and the
+		 * formula to get the outphasing in degrees is deg =
+		 * 360 * delta / period
+		 *
+		 * If we simplify this formula, we can see that the
+		 * only thing that we're concerned about is the number
+		 * of period we want to outphase our clock from, and
+		 * the divider set by the MMC clock.
+		 */
+		step = DIV_ROUND_CLOSEST(360, mmc_div);
+		delay = DIV_ROUND_CLOSEST(degrees, step);
+	} else {
+		delay = 0;
+	}
+
+	spin_lock_irqsave(phase->lock, flags);
+	value = readl(phase->reg);
+	value &= ~GENMASK(phase->data->offset + 3, phase->data->offset);
+	value |= delay << phase->data->offset;
+	writel(value, phase->reg);
+	spin_unlock_irqrestore(phase->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops mmc_clk_ops = {
+	.get_phase	= mmc_get_phase,
+	.set_phase	= mmc_set_phase,
+};
+
+static void __init sun4i_a10_mmc_phase_setup(struct device_node *node,
+					     struct mmc_phase_data *data)
+{
+	const char *parent_names[1] = { of_clk_get_parent_name(node, 0) };
+	struct clk_init_data init = {
+		.num_parents	= 1,
+		.parent_names	= parent_names,
+		.ops		= &mmc_clk_ops,
+	};
+
+	struct mmc_phase *phase;
+	struct clk *clk;
+
+	phase = kmalloc(sizeof(*phase), GFP_KERNEL);
+	if (!phase)
+		return;
+
+	phase->hw.init = &init;
+
+	phase->reg = of_iomap(node, 0);
+	if (!phase->reg)
+		goto err_free;
+
+	phase->data = data;
+	phase->lock = &sun4i_a10_mod0_lock;
+
+	if (of_property_read_string(node, "clock-output-names", &init.name))
+		init.name = node->name;
+
+	clk = clk_register(NULL, &phase->hw);
+	if (IS_ERR(clk))
+		goto err_unmap;
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	return;
+
+err_unmap:
+	iounmap(phase->reg);
+err_free:
+	kfree(phase);
+}
+
+
+static struct mmc_phase_data mmc_output_clk = {
+	.offset	= 8,
+};
+
+static struct mmc_phase_data mmc_sample_clk = {
+	.offset	= 20,
+};
+
+static void __init sun4i_a10_mmc_output_setup(struct device_node *node)
+{
+	sun4i_a10_mmc_phase_setup(node, &mmc_output_clk);
+}
+CLK_OF_DECLARE(sun4i_a10_mmc_output, "allwinner,sun4i-a10-mmc-output-clk", sun4i_a10_mmc_output_setup);
+
+static void __init sun4i_a10_mmc_sample_setup(struct device_node *node)
+{
+	sun4i_a10_mmc_phase_setup(node, &mmc_sample_clk);
+}
+CLK_OF_DECLARE(sun4i_a10_mmc_sample, "allwinner,sun4i-a10-mmc-sample-clk", sun4i_a10_mmc_sample_setup);
-- 
2.0.1

