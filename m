From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 01/16] clk: qcom: Add rcg ops to return floor value closest to the requested rate
Date: Mon, 21 Nov 2016 12:07:11 +0530
Message-ID: <1479710246-26676-2-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

The default behaviour with clk_rcg2_ops is for the
clk_round_rate()/clk_set_rate() to return/set a ceil clock
rate closest to the requested rate by looking up the corresponding
frequency table.
However, we do have some instances (mainly sdcc on various platforms)
of clients expecting a clk_set_rate() to set a floor value instead.
Add a new clk_rcg2_floor_ops to handle this for such specific
rcg instances

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg.h  |  1 +
 drivers/clk/qcom/clk-rcg2.c | 76 +++++++++++++++++++++++++++++++++++++++------
 drivers/clk/qcom/common.c   | 16 ++++++++++
 drivers/clk/qcom/common.h   |  2 ++
 4 files changed, 86 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index b904c33..1b3e8d2 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -173,6 +173,7 @@ struct clk_rcg2 {
 #define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
 
 extern const struct clk_ops clk_rcg2_ops;
+extern const struct clk_ops clk_rcg2_floor_ops;
 extern const struct clk_ops clk_rcg2_shared_ops;
 extern const struct clk_ops clk_edp_pixel_ops;
 extern const struct clk_ops clk_byte_ops;
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index a071bba..1a0985a 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -47,6 +47,11 @@
 #define N_REG			0xc
 #define D_REG			0x10
 
+enum freq_policy {
+	FLOOR,
+	CEIL,
+};
+
 static int clk_rcg2_is_enabled(struct clk_hw *hw)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -176,15 +181,26 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 	return calc_rate(parent_rate, m, n, mode, hid_div);
 }
 
-static int _freq_tbl_determine_rate(struct clk_hw *hw,
-		const struct freq_tbl *f, struct clk_rate_request *req)
+static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
+				    struct clk_rate_request *req,
+				    enum freq_policy policy)
 {
 	unsigned long clk_flags, rate = req->rate;
 	struct clk_hw *p;
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	int index;
 
-	f = qcom_find_freq(f, rate);
+	switch (policy) {
+	case FLOOR:
+		f = qcom_find_freq_floor(f, rate);
+		break;
+	case CEIL:
+		f = qcom_find_freq(f, rate);
+		break;
+	default:
+		return -EINVAL;
+	};
+
 	if (!f)
 		return -EINVAL;
 
@@ -221,7 +237,15 @@ static int clk_rcg2_determine_rate(struct clk_hw *hw,
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 
-	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req);
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, CEIL);
+}
+
+static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
 }
 
 static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
@@ -265,12 +289,23 @@ static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 	return update_config(rcg);
 }
 
-static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate)
+static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
+			       enum freq_policy policy)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
 	const struct freq_tbl *f;
 
-	f = qcom_find_freq(rcg->freq_tbl, rate);
+	switch (policy) {
+	case FLOOR:
+		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
+		break;
+	case CEIL:
+		f = qcom_find_freq(rcg->freq_tbl, rate);
+		break;
+	default:
+		return -EINVAL;
+	};
+
 	if (!f)
 		return -EINVAL;
 
@@ -280,13 +315,25 @@ static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate)
 static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
-	return __clk_rcg2_set_rate(hw, rate);
+	return __clk_rcg2_set_rate(hw, rate, CEIL);
+}
+
+static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
 static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
 		unsigned long rate, unsigned long parent_rate, u8 index)
 {
-	return __clk_rcg2_set_rate(hw, rate);
+	return __clk_rcg2_set_rate(hw, rate, CEIL);
+}
+
+static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
 const struct clk_ops clk_rcg2_ops = {
@@ -300,6 +347,17 @@ static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_ops);
 
+const struct clk_ops clk_rcg2_floor_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_determine_floor_rate,
+	.set_rate = clk_rcg2_set_floor_rate,
+	.set_rate_and_parent = clk_rcg2_set_floor_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
+
 static int clk_rcg2_shared_force_enable(struct clk_hw *hw, unsigned long rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
@@ -323,7 +381,7 @@ static int clk_rcg2_shared_force_enable(struct clk_hw *hw, unsigned long rate)
 		pr_err("%s: RCG did not turn on\n", name);
 
 	/* set clock rate */
-	ret = __clk_rcg2_set_rate(hw, rate);
+	ret = __clk_rcg2_set_rate(hw, rate, CEIL);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 94569f4..cfab7b4 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -46,6 +46,22 @@ struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(qcom_find_freq);
 
+const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
+					    unsigned long rate)
+{
+	const struct freq_tbl *best = NULL;
+
+	for ( ; f->freq; f++) {
+		if (rate >= f->freq)
+			best = f;
+		else
+			break;
+	}
+
+	return best;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq_floor);
+
 int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map, u8 src)
 {
 	int i, num_parents = clk_hw_get_num_parents(hw);
diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9fb5b8e..23c1927 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -41,6 +41,8 @@ struct qcom_cc_desc {
 
 extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
 					     unsigned long rate);
+extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
+						   unsigned long rate);
 extern void
 qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
 extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.

