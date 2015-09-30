From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 1/8] clk: rockchip: Allow more precision for some mmc clock phases
Date: Wed, 30 Sep 2015 16:07:37 +0200
Message-ID: <1443622064-14362-2-git-send-email-heiko@sntech.de>
References: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:51069 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753984AbbI3OHz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Sep 2015 10:07:55 -0400
In-Reply-To: <1443622064-14362-1-git-send-email-heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org, Heiko Stuebner <heiko@sntech.de>

From: Douglas Anderson <dianders@chromium.org>

Because of the inexact nature of the extra MMC delay elements (it's
not possible to keep the phase monotonic and to also make phases (mod
90) > 70), we previously only allowed phases (mod 90) of 22.5, 45,
and 67.5.

But it's not the end of the world if the MMC clock phase goes
non-monotonic.  At most we'll be 25 degrees off.  It's way better to
test more phases to look for bad ones than to be 25 degrees off, because
in the case of MMC really the point is to find bad phases and get as far
asway from the as possible.  If we get to test extra phases by going
slightly non-monotonic then that might be fine.  Worst case we would
end up at a phases that's slight differnt than the one we wanted, but
at least we'd still be quite far away from the a bad phase.

Signed-off-by: Douglas Anderson <dianders@chromium.org>

Fold in more precise variance-values of 44-77 instead of 40-80.
Fold in the actual removal of the monotonic requirement and adapt
patch message accordingly.
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-mmc-phase.c | 45 ++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 9b61342..a797d86 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -45,8 +45,8 @@ static unsigned long rockchip_mmc_recalc(struct clk_hw *hw,
 #define PSECS_PER_SEC 1000000000000LL
 
 /*
- * Each fine delay is between 40ps-80ps. Assume each fine delay is 60ps to
- * simplify calculations. So 45degs could be anywhere between 33deg and 66deg.
+ * Each fine delay is between 44ps-77ps. Assume each fine delay is 60ps to
+ * simplify calculations. So 45degs could be anywhere between 33deg and 57.8deg.
  */
 #define ROCKCHIP_MMC_DELAY_ELEMENT_PSEC 60
 
@@ -84,22 +84,37 @@ static int rockchip_mmc_set_phase(struct clk_hw *hw, int degrees)
 	u32 raw_value;
 	u64 delay;
 
-	/* allow 22 to be 22.5 */
-	degrees++;
-	/* floor to 22.5 increment */
-	degrees -= ((degrees) * 10 % 225) / 10;
-
 	nineties = degrees / 90;
-	/* 22.5 multiples */
-	remainder = (degrees % 90) / 22;
-
+	remainder = (degrees % 90);
+
+	/*
+	 * Due to the inexact nature of the "fine" delay, we might
+	 * actually go non-monotonic.  We don't go _too_ monotonic
+	 * though, so we should be OK.  Here are options of how we may
+	 * work:
+	 *
+	 * Ideally we end up with:
+	 *   1.0, 2.0, ..., 69.0, 70.0, ...,  89.0, 90.0
+	 *
+	 * On one extreme (if delay is actually 44ps):
+	 *   .73, 1.5, ..., 50.6, 51.3, ...,  65.3, 90.0
+	 * The other (if delay is actually 77ps):
+	 *   1.3, 2.6, ..., 88.6. 89.8, ..., 114.0, 90
+	 *
+	 * It's possible we might make a delay that is up to 25
+	 * degrees off from what we think we're making.  That's OK
+	 * though because we should be REALLY far from any bad range.
+	 */
+
+	/*
+	 * Convert to delay; do a little extra work to make sure we
+	 * don't overflow 32-bit / 64-bit numbers.
+	 */
 	delay = PSECS_PER_SEC;
-	do_div(delay, rate);
-	/* / 360 / 22.5 */
-	do_div(delay, 16);
-	do_div(delay, ROCKCHIP_MMC_DELAY_ELEMENT_PSEC);
-
 	delay *= remainder;
+	do_div(delay, 10000);
+	do_div(delay, (rate / 1000) * 36 * ROCKCHIP_MMC_DELAY_ELEMENT_PSEC);
+
 	delay_num = (u8) min(delay, 255ULL);
 
 	raw_value = delay_num ? ROCKCHIP_MMC_DELAY_SEL : 0;
-- 
2.5.1

