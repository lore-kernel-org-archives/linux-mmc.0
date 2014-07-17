From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 05/14] clk: Add a function to retrieve phase
Date: Thu, 17 Jul 2014 11:08:45 +0200
Message-ID: <1405588134-2396-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41360 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753943AbaGQJKI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jul 2014 05:10:08 -0400
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
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
index 3eae203cda47..a6471df0a3f5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1825,8 +1825,8 @@ out:
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
@@ -1836,7 +1836,18 @@ int clk_get_phase(struct clk *clk)
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
index 3a35a0647118..fa53f90456a9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -129,6 +129,10 @@ struct dentry;
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
@@ -181,6 +185,7 @@ struct clk_ops {
 				    unsigned long parent_rate, u8 index);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
+	int		(*get_phase)(struct clk_hw *hw);
 	int		(*set_phase)(struct clk_hw *hw, int degrees);
 	void		(*init)(struct clk_hw *hw);
 	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
-- 
2.0.1

