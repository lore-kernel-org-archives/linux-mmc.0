From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH v9 02/16] clk: qcom: Move all sdcc rcgs to use clk_rcg2_floor_ops
Date: Mon, 21 Nov 2016 12:07:12 +0530
Message-ID: <1479710246-26676-3-git-send-email-riteshh@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, Ritesh Harjani <riteshh@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

The sdcc driver for msm8996/msm8916/msm8974/msm8994 and apq8084
expects a clk_set_rate() on the sdcc rcg clk to set
a floor value of supported clk rate closest to the requested
rate, by looking up the frequency table.
So move all the sdcc rcgs on all these platforms to use the
newly introduced clk_rcg2_floor_ops

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 drivers/clk/qcom/gcc-apq8084.c | 8 ++++----
 drivers/clk/qcom/gcc-msm8916.c | 4 ++--
 drivers/clk/qcom/gcc-msm8974.c | 8 ++++----
 drivers/clk/qcom/gcc-msm8994.c | 8 ++++----
 drivers/clk/qcom/gcc-msm8996.c | 8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index 070037a..486d961 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -1142,7 +1142,7 @@ enum {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1156,7 +1156,7 @@ enum {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1170,7 +1170,7 @@ enum {
 		.name = "sdcc3_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1184,7 +1184,7 @@ enum {
 		.name = "sdcc4_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index 5c4e193..628e6ca 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -1107,7 +1107,7 @@ enum {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1132,7 +1132,7 @@ enum {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8974.c b/drivers/clk/qcom/gcc-msm8974.c
index 0091520..348e30d 100644
--- a/drivers/clk/qcom/gcc-msm8974.c
+++ b/drivers/clk/qcom/gcc-msm8974.c
@@ -872,7 +872,7 @@ enum {
 	.name = "sdcc1_apps_clk_src",
 	.parent_names = gcc_xo_gpll0,
 	.num_parents = 2,
-	.ops = &clk_rcg2_ops,
+	.ops = &clk_rcg2_floor_ops,
 };
 
 static struct clk_rcg2 sdcc1_apps_clk_src = {
@@ -894,7 +894,7 @@ enum {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -908,7 +908,7 @@ enum {
 		.name = "sdcc3_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -922,7 +922,7 @@ enum {
 		.name = "sdcc4_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
index 84093c1..8afd830 100644
--- a/drivers/clk/qcom/gcc-msm8994.c
+++ b/drivers/clk/qcom/gcc-msm8994.c
@@ -912,7 +912,7 @@ enum {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -938,7 +938,7 @@ enum {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -953,7 +953,7 @@ enum {
 		.name = "sdcc3_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -968,7 +968,7 @@ enum {
 		.name = "sdcc4_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index e22bbc2..4b1fc17 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -460,7 +460,7 @@ enum {
 		.name = "sdcc1_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4_gpll0_early_div,
 		.num_parents = 4,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -505,7 +505,7 @@ enum {
 		.name = "sdcc2_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -519,7 +519,7 @@ enum {
 		.name = "sdcc3_apps_clk_src",
 		.parent_names = gcc_xo_gpll0_gpll4,
 		.num_parents = 3,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -543,7 +543,7 @@ enum {
 		.name = "sdcc4_apps_clk_src",
 		.parent_names = gcc_xo_gpll0,
 		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project.
