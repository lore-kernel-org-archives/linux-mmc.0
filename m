From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: [PATCH v2 03/10] clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
Date: Thu, 20 Jul 2017 11:44:45 +0800
Message-ID: <20170720034452.15920-4-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170720034452.15920-1-wens-jdAy2FN1RRM@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The MMC2 clock supports a new timing mode. When the new mode is active,
the output clock rate is halved.

This patch sets the feature flag for the new timing mode, and adds
a pre-divider based on the mode bit.

Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 947f9f6e05d2..c5656e4f2a38 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -418,14 +418,13 @@ static SUNXI_CCU_PHASE(mmc1_sample_clk, "mmc1-sample", "mmc1",
 static SUNXI_CCU_PHASE(mmc1_output_clk, "mmc1-output", "mmc1",
 		       0x08c, 8, 3, 0);
 
-/* TODO Support MMC2 clock's new timing mode. */
-static SUNXI_CCU_MP_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents,
-				  0x090,
-				  0, 4,		/* M */
-				  16, 2,	/* P */
-				  24, 2,	/* mux */
-				  BIT(31),	/* gate */
-				  0);
+static SUNXI_CCU_MP_MMC_WITH_MUX_GATE(mmc2_clk, "mmc2", mod0_default_parents,
+				      0x090,
+				      0, 4,	/* M */
+				      16, 2,	/* P */
+				      24, 2,	/* mux */
+				      BIT(31),	/* gate */
+				      CLK_GET_RATE_NOCACHE);
 
 static SUNXI_CCU_PHASE(mmc2_sample_clk, "mmc2-sample", "mmc2",
 		       0x090, 20, 3, 0);
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
