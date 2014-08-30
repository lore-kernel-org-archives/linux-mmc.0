From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 03/12] clk: Add a function to retrieve phase
Date: Sat, 30 Aug 2014 22:03:02 +0200
Message-ID: <1409428991-2442-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53621 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751802AbaH3UFJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 30 Aug 2014 16:05:09 -0400
In-Reply-To: <1409428991-2442-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

The current phase API doesn't look into the actual hardware to get the phase
value, but will rather get it from a variable only set by the set_phase
function.

This will cause issue when the client driver will never call the set_phase
function, where we can end up having a reported phase that will not match what
the hardware has been programmed to by the bootloader or what phase is
programmed out of reset.

Add a new get_phase function for the drivers to implement so that we can get
this value.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/clk.c            | 17 ++++++++++++++---
 include/linux/clk-provider.h |  5 +++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d87661af0c72..7dbceca694f1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1797,8 +1797,8 @@ out:
  * clk_get_phase - return the phase shift of a clock signal
  * @clk: clock signal source
  *
- * Returns the phase shift of a clock node in degrees, otherwise returns
- * -EERROR.
+ * Returns the phase shift of a clock node in degrees. Any negative
+ * values are errors.
  */
 int clk_get_phase(struct clk *clk)
 {
@@ -1808,7 +1808,18 @@ int clk_get_phase(struct clk *clk)
 		goto out;
 
 	clk_prepare_lock();
-	ret = clk->phase;
+
+	if (clk->phase) {
+		ret = clk->phase;
+		goto out_unlock;
+	}
+
+	if (!clk->ops->get_phase)
+		goto out_unlock;
+
+	ret = clk->ops->get_phase(clk->hw);
+
+out_unlock:
 	clk_prepare_unlock();
 
 out:
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 69b20d4c1e1a..abec961092a7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -130,6 +130,10 @@ struct dentry;
  *		set then clock accuracy will be initialized to parent accuracy
  *		or 0 (perfect clock) if clock has no parent.
  *
+ * @get_phase:	Queries the hardware to get the current phase of a clock.
+ *		Returned values are 0-359 degrees on success, negative
+ *		error codes on failure.
+ *
  * @set_phase:	Shift the phase this clock signal in degrees specified
  *		by the second argument. Valid values for degrees are
  *		0-359. Return 0 on success, otherwise -EERROR.
@@ -182,6 +186,7 @@ struct clk_ops {
 				    unsigned long parent_rate, u8 index);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
+	int		(*get_phase)(struct clk_hw *hw);
 	int		(*set_phase)(struct clk_hw *hw, int degrees);
 	void		(*init)(struct clk_hw *hw);
 	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
-- 
2.0.2

