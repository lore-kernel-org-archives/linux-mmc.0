From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Fri, 25 Aug 2017 11:49:52 +0200
Message-ID: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:37916 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754555AbdHYJt4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Aug 2017 05:49:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-mmc@vger.kernel.org

The reset hook was left implemented. Provide a dumb implementation so that
client drivers can depend on it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_reset.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
index 6c31d48783a7..1dc4e98ea802 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.c
+++ b/drivers/clk/sunxi-ng/ccu_reset.c
@@ -8,6 +8,7 @@
  * the License, or (at your option) any later version.
  */
 
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/reset-controller.h>
 
@@ -49,7 +50,18 @@ static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int ccu_reset_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	ccu_reset_assert(rcdev, id);
+	udelay(10);
+	ccu_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
 const struct reset_control_ops ccu_reset_ops = {
 	.assert		= ccu_reset_assert,
 	.deassert	= ccu_reset_deassert,
+	.reset		= ccu_reset_reset,
 };
-- 
2.13.5

