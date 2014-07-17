From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 10/14] clk: sunxi: Move mbus to mod0 file
Date: Thu, 17 Jul 2014 11:08:50 +0200
Message-ID: <1405588134-2396-11-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Move the MBUS clock to the module clocks file. It's pretty trivial, but still
requires to enable the clocks to make sure it won't get disabled.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/clk/sunxi/clk-mod0.c  | 12 +++++++++
 drivers/clk/sunxi/clk-sunxi.c | 57 -------------------------------------------
 2 files changed, 12 insertions(+), 57 deletions(-)

diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index bce09a84ab4f..a179299ec79d 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -80,3 +80,15 @@ static void __init sun4i_a10_mod0_setup(struct device_node *node)
 	sunxi_factors_register(node, &sun4i_a10_mod0_data, &sun4i_a10_mod0_lock);
 }
 CLK_OF_DECLARE(sun4i_a10_mod0, "allwinner,sun4i-a10-mod0-clk", sun4i_a10_mod0_setup);
+
+static DEFINE_SPINLOCK(sun4i_a10_mbus_lock);
+
+static void __init sun4i_a10_mbus_setup(struct device_node *node)
+{
+	struct clk *mbus = sunxi_factors_register(node, &sun4i_a10_mod0_data, &sun4i_a10_mbus_lock);
+
+	/* The MBUS clocks needs to be always enabled */
+	__clk_get(mbus);
+	clk_prepare_enable(mbus);
+}
+CLK_OF_DECLARE(sun4i_a10_mbus, "allwinner,sun4i-a10-mbus-clk", sun4i_a10_mbus_setup);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4c0c35804c1b..46f21392a061 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -320,46 +320,6 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
 
 
 
-/**
- * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
- * MOD0 rate is calculated as follows
- * rate = (parent_rate >> p) / (m + 1);
- */
-
-static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
-				   u8 *n, u8 *k, u8 *m, u8 *p)
-{
-	u8 div, calcm, calcp;
-
-	/* These clocks can only divide, so we will never be able to achieve
-	 * frequencies higher than the parent frequency */
-	if (*freq > parent_rate)
-		*freq = parent_rate;
-
-	div = DIV_ROUND_UP(parent_rate, *freq);
-
-	if (div < 16)
-		calcp = 0;
-	else if (div / 2 < 16)
-		calcp = 1;
-	else if (div / 4 < 16)
-		calcp = 2;
-	else
-		calcp = 3;
-
-	calcm = DIV_ROUND_UP(div, 1 << calcp);
-
-	*freq = (parent_rate >> calcp) / calcm;
-
-	/* we were called to round the frequency, we can now return */
-	if (n == NULL)
-		return;
-
-	*m = calcm - 1;
-	*p = calcp;
-}
-
-
 
 /**
  * sun7i_a20_get_out_factors() - calculates m, p factors for CLK_OUT_A/B
@@ -495,14 +455,6 @@ static struct clk_factors_config sun4i_apb1_config = {
 };
 
 /* user manual says "n" but it's really "p" */
-static struct clk_factors_config sun4i_mod0_config = {
-	.mshift = 0,
-	.mwidth = 4,
-	.pshift = 16,
-	.pwidth = 2,
-};
-
-/* user manual says "n" but it's really "p" */
 static struct clk_factors_config sun7i_a20_out_config = {
 	.mshift = 8,
 	.mwidth = 5,
@@ -559,13 +511,6 @@ static const struct factors_data sun4i_apb1_data __initconst = {
 	.getter = sun4i_get_apb1_factors,
 };
 
-static const struct factors_data sun4i_mod0_data __initconst = {
-	.enable = 31,
-	.mux = 24,
-	.table = &sun4i_mod0_config,
-	.getter = sun4i_get_mod0_factors,
-};
-
 static const struct factors_data sun7i_a20_out_data __initconst = {
 	.enable = 31,
 	.mux = 24,
@@ -1110,7 +1055,6 @@ static const struct of_device_id clk_factors_match[] __initconst = {
 	{.compatible = "allwinner,sun7i-a20-pll4-clk", .data = &sun7i_a20_pll4_data,},
 	{.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_data,},
 	{.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
-	{.compatible = "allwinner,sun4i-a10-mbus-clk", .data = &sun4i_mod0_data,},
 	{.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
 	{}
 };
@@ -1222,7 +1166,6 @@ static void __init sun4i_a10_init_clocks(struct device_node *node)
 CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sun4i_a10_init_clocks);
 
 static const char *sun5i_critical_clocks[] __initdata = {
-	"mbus",
 	"pll5_ddr",
 	"ahb_sdram",
 };
-- 
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
