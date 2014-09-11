From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 01/12] clk: introduce clk_set_phase function & callback
Date: Thu, 11 Sep 2014 22:18:15 +0200
Message-ID: <1410466706-27386-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49715 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756867AbaIKUW1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Sep 2014 16:22:27 -0400
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Emilio Lopez <emilio@elopez.com.ar>, chris@printf.net, david.lanzendoerfer@o2s.ch, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, wens@csie.org, Maxime Ripard <maxime.ripard@free-electrons.com>

From: Mike Turquette <mturquette@linaro.org>

A common operation for a clock signal generator is to shift the phase of
that signal. This patch introduces a new function to the clk.h API to
dynamically adjust the phase of a clock signal. Additionally this patch
introduces support for the new function in the common clock framework
via the .set_phase call back in struct clk_ops.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/clk.c            | 85 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/clk-private.h  |  1 +
 include/linux/clk-provider.h |  5 +++
 include/linux/clk.h          | 29 +++++++++++++++
 4 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b76fa69b44cb..d87661af0c72 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -117,11 +117,11 @@ static void clk_summary_show_one(struct seq_file *s, struct clk *c, int level)
 	if (!c)
 		return;
 
-	seq_printf(s, "%*s%-*s %11d %12d %11lu %10lu\n",
+	seq_printf(s, "%*s%-*s %11d %12d %11lu %10lu %-3d\n",
 		   level * 3 + 1, "",
 		   30 - level * 3, c->name,
 		   c->enable_count, c->prepare_count, clk_get_rate(c),
-		   clk_get_accuracy(c));
+		   clk_get_accuracy(c), clk_get_phase(c));
 }
 
 static void clk_summary_show_subtree(struct seq_file *s, struct clk *c,
@@ -143,8 +143,8 @@ static int clk_summary_show(struct seq_file *s, void *data)
 	struct clk *c;
 	struct hlist_head **lists = (struct hlist_head **)s->private;
 
-	seq_puts(s, "   clock                         enable_cnt  prepare_cnt        rate   accuracy\n");
-	seq_puts(s, "--------------------------------------------------------------------------------\n");
+	seq_puts(s, "   clock                         enable_cnt  prepare_cnt        rate   accuracy   phase\n");
+	seq_puts(s, "----------------------------------------------------------------------------------------\n");
 
 	clk_prepare_lock();
 
@@ -180,6 +180,7 @@ static void clk_dump_one(struct seq_file *s, struct clk *c, int level)
 	seq_printf(s, "\"prepare_count\": %d,", c->prepare_count);
 	seq_printf(s, "\"rate\": %lu", clk_get_rate(c));
 	seq_printf(s, "\"accuracy\": %lu", clk_get_accuracy(c));
+	seq_printf(s, "\"phase\": %d", clk_get_phase(c));
 }
 
 static void clk_dump_subtree(struct seq_file *s, struct clk *c, int level)
@@ -264,6 +265,11 @@ static int clk_debug_create_one(struct clk *clk, struct dentry *pdentry)
 	if (!d)
 		goto err_out;
 
+	d = debugfs_create_u32("clk_phase", S_IRUGO, clk->dentry,
+			(u32 *)&clk->phase);
+	if (!d)
+		goto err_out;
+
 	d = debugfs_create_x32("clk_flags", S_IRUGO, clk->dentry,
 			(u32 *)&clk->flags);
 	if (!d)
@@ -1739,6 +1745,77 @@ out:
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
 /**
+ * clk_set_phase - adjust the phase shift of a clock signal
+ * @clk: clock signal source
+ * @degrees: number of degrees the signal is shifted
+ *
+ * Shifts the phase of a clock signal by the specified
+ * degrees. Returns 0 on success, -EERROR otherwise.
+ *
+ * This function makes no distinction about the input or reference
+ * signal that we adjust the clock signal phase against. For example
+ * phase locked-loop clock signal generators we may shift phase with
+ * respect to feedback clock signal input, but for other cases the
+ * clock phase may be shifted with respect to some other, unspecified
+ * signal.
+ *
+ * Additionally the concept of phase shift does not propagate through
+ * the clock tree hierarchy, which sets it apart from clock rates and
+ * clock accuracy. A parent clock phase attribute does not have an
+ * impact on the phase attribute of a child clock.
+ */
+int clk_set_phase(struct clk *clk, int degrees)
+{
+	int ret = 0;
+
+	if (!clk)
+		goto out;
+
+	/* sanity check degrees */
+	degrees %= 360;
+	if (degrees < 0)
+		degrees += 360;
+
+	clk_prepare_lock();
+
+	if (!clk->ops->set_phase)
+		goto out_unlock;
+
+	ret = clk->ops->set_phase(clk->hw, degrees);
+
+	if (!ret)
+		clk->phase = degrees;
+
+out_unlock:
+	clk_prepare_unlock();
+
+out:
+	return ret;
+}
+
+/**
+ * clk_get_phase - return the phase shift of a clock signal
+ * @clk: clock signal source
+ *
+ * Returns the phase shift of a clock node in degrees, otherwise returns
+ * -EERROR.
+ */
+int clk_get_phase(struct clk *clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		goto out;
+
+	clk_prepare_lock();
+	ret = clk->phase;
+	clk_prepare_unlock();
+
+out:
+	return ret;
+}
+
+/**
  * __clk_init - initialize the data structures in a struct clk
  * @dev:	device initializing this clk, placeholder for now
  * @clk:	clk being initialized
diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index efbf70b9fd84..845be30be50f 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -46,6 +46,7 @@ struct clk {
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned long		accuracy;
+	int			phase;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	unsigned int		notifier_count;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 411dd7eb2653..201a6195a3eb 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -129,6 +129,10 @@ struct dentry;
  *		set then clock accuracy will be initialized to parent accuracy
  *		or 0 (perfect clock) if clock has no parent.
  *
+ * @set_phase:	Shift the phase this clock signal in degrees specified
+ *		by the second argument. Valid values for degrees are
+ *		0-359. Return 0 on success, otherwise -EERROR.
+ *
  * @init:	Perform platform-specific initialization magic.
  *		This is not not used by any of the basic clock types.
  *		Please consider other ways of solving initialization problems
@@ -177,6 +181,7 @@ struct clk_ops {
 				    unsigned long parent_rate, u8 index);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
+	int		(*set_phase)(struct clk_hw *hw, int degrees);
 	void		(*init)(struct clk_hw *hw);
 	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
 };
diff --git a/include/linux/clk.h b/include/linux/clk.h
index fb5e097d8f72..38bdedd3e389 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -106,6 +106,25 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
  */
 long clk_get_accuracy(struct clk *clk);
 
+/**
+ * clk_set_phase - adjust the phase shift of a clock signal
+ * @clk: clock signal source
+ * @degrees: number of degrees the signal is shifted
+ *
+ * Shifts the phase of a clock signal by the specified degrees. Returns 0 on
+ * success, -EERROR otherwise.
+ */
+int clk_set_phase(struct clk *clk, int degrees);
+
+/**
+ * clk_get_phase - return the phase shift of a clock signal
+ * @clk: clock signal source
+ *
+ * Returns the phase shift of a clock node in degrees, otherwise returns
+ * -EERROR.
+ */
+int clk_get_phase(struct clk *clk);
+
 #else
 
 static inline long clk_get_accuracy(struct clk *clk)
@@ -113,6 +132,16 @@ static inline long clk_get_accuracy(struct clk *clk)
 	return -ENOTSUPP;
 }
 
+static inline long clk_set_phase(struct clk *clk, int phase)
+{
+	return -ENOTSUPP;
+}
+
+static inline long clk_get_phase(struct clk *clk)
+{
+	return -ENOTSUPP;
+}
+
 #endif
 
 /**
-- 
2.1.0

