From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 12/12] clk: sunxi: Remove custom phase function
Date: Thu, 11 Sep 2014 22:18:26 +0200
Message-ID: <1410466706-27386-13-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49706 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756858AbaIKUW0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 16:22:26 -0400
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org, Maxime Ripard <maxime.ripard@free-electrons.com>

Now that we don't have any user left for our custom phase function, we can
safely remove this hack from the code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/clk-sunxi.c | 37 -------------------------------------
 include/linux/clk/sunxi.h     | 22 ----------------------
 2 files changed, 59 deletions(-)
 delete mode 100644 include/linux/clk/sunxi.h

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 4e189be3e23f..e46f3f2748d3 100644
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
- * Copyright 2013 - Hans de Goede <hdegoede@redhat.com>
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
2.1.0

