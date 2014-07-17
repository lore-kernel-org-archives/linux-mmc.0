From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 14/14] clk: sunxi: Remove custom phase function
Date: Thu, 17 Jul 2014 11:08:54 +0200
Message-ID: <1405588134-2396-15-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Now that we don't have any user left for our custom phase function, we can
safely remove this hack from the code.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/clk/sunxi/clk-sunxi.c | 37 -------------------------------------
 include/linux/clk/sunxi.h     | 22 ----------------------
 2 files changed, 59 deletions(-)
 delete mode 100644 include/linux/clk/sunxi.h

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 46f21392a061..85061f76d793 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -361,43 +361,6 @@ static void sun7i_a20_get_out_factors(u32 *freq, u32 parent_rate,
 }
 
 /**
- * clk_sunxi_mmc_phase_control() - configures MMC clock phase control
- */
-
-void clk_sunxi_mmc_phase_control(struct clk *clk, u8 sample, u8 output)
-{
-	#define to_clk_composite(_hw) container_of(_hw, struct clk_composite, hw)
-	#define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
-
-	struct clk_hw *hw = __clk_get_hw(clk);
-	struct clk_composite *composite = to_clk_composite(hw);
-	struct clk_hw *rate_hw = composite->rate_hw;
-	struct clk_factors *factors = to_clk_factors(rate_hw);
-	unsigned long flags = 0;
-	u32 reg;
-
-	if (factors->lock)
-		spin_lock_irqsave(factors->lock, flags);
-
-	reg = readl(factors->reg);
-
-	/* set sample clock phase control */
-	reg &= ~(0x7 << 20);
-	reg |= ((sample & 0x7) << 20);
-
-	/* set output clock phase control */
-	reg &= ~(0x7 << 8);
-	reg |= ((output & 0x7) << 8);
-
-	writel(reg, factors->reg);
-
-	if (factors->lock)
-		spin_unlock_irqrestore(factors->lock, flags);
-}
-EXPORT_SYMBOL(clk_sunxi_mmc_phase_control);
-
-
-/**
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
 
diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
deleted file mode 100644
index aed28c4451d9..000000000000
--- a/include/linux/clk/sunxi.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright 2013 - Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#ifndef __LINUX_CLK_SUNXI_H_
-#define __LINUX_CLK_SUNXI_H_
-
-#include <linux/clk.h>
-
-void clk_sunxi_mmc_phase_control(struct clk *clk, u8 sample, u8 output);
-
-#endif
-- 
2.0.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
