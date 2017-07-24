From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v3 06/10] mmc: sunxi: Add support for A83T eMMC (MMC2)
Date: Mon, 24 Jul 2017 21:59:01 +0800
Message-ID: <20170724135905.28855-7-wens@csie.org>
References: <20170724135905.28855-1-wens@csie.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBNH227FQKGQEKE2VWSQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

The third MMC controller (MMC2) on the Allwinner A83T SoC is slightly
different. It supports a wider 8-bit bus, has a dedicated controllable
reset pin for eMMC, and a "new timing mode" which is supposed to deliver
better signals and thus better performance.

Add a compatible for this one to use the new timing mode not found in the
other controllers.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt | 1 +
 drivers/mmc/host/sunxi-mmc.c                        | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 7d53a799f140..63b57e2a10fb 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -12,6 +12,7 @@ Required properties:
    * "allwinner,sun4i-a10-mmc"
    * "allwinner,sun5i-a13-mmc"
    * "allwinner,sun7i-a20-mmc"
+   * "allwinner,sun8i-a83t-emmc"
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-emmc"
    * "allwinner,sun50i-a64-mmc"
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 11587a69a1fd..de187ed77040 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1117,6 +1117,13 @@ static const struct sunxi_mmc_cfg sun7i_a20_cfg = {
 	.can_calibrate = false,
 };
 
+static const struct sunxi_mmc_cfg sun8i_a83t_emmc_cfg = {
+	.idma_des_size_bits = 16,
+	.clk_delays = sunxi_mmc_clk_delays,
+	.can_calibrate = false,
+	.has_timings_switch = true,
+};
+
 static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
 	.idma_des_size_bits = 16,
 	.clk_delays = sun9i_mmc_clk_delays,
@@ -1141,6 +1148,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
 	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
+	{ .compatible = "allwinner,sun8i-a83t-emmc", .data = &sun8i_a83t_emmc_cfg },
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
-- 
2.13.3
