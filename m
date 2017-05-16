From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 2/2] mmc: dw_mmc-rockchip: parse rockchip,desired-num-phases from DT
Date: Tue, 16 May 2017 14:28:54 +0800
Message-ID: <1494916134-68043-2-git-send-email-shawn.lin@rock-chips.com>
References: <1494916134-68043-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1494916134-68043-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Currently we unconditionally do tuning for each degree, which
costs 900ms for each boot and resume.

May someone argue that this is a question of accuracy VS time. But I
would say it's a trick of how we need to do decision for our boards.
If we don't care the time we spend at all, we could definitely do tuning
for each degree. But when we need to improve the user experience, for
instance, speed up resuming from S3, we should also have the right to
do that. This patch add parsing "rockchip,desired-num-phases", for folks
to specify the number of doing tuning. If not specified, 360 will be used
as before.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

Changes in v2:
- rename property to rockchip,desired-num-phases

 drivers/mmc/host/dw_mmc-rockchip.c | 48 ++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 372fb6e..a3f1c2b 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -25,6 +25,7 @@ struct dw_mci_rockchip_priv_data {
 	struct clk		*drv_clk;
 	struct clk		*sample_clk;
 	int			default_sample_phase;
+	int			num_phases;
 };
 
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
@@ -133,8 +134,8 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 }
 
-#define NUM_PHASES			360
-#define TUNING_ITERATION_TO_PHASE(i)	(DIV_ROUND_UP((i) * 360, NUM_PHASES))
+#define TUNING_ITERATION_TO_PHASE(i, num_phases) \
+		(DIV_ROUND_UP((i) * 360, num_phases))
 
 static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 {
@@ -159,13 +160,15 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		return -EIO;
 	}
 
-	ranges = kmalloc_array(NUM_PHASES / 2 + 1, sizeof(*ranges), GFP_KERNEL);
+	ranges = kmalloc_array(priv->num_phases / 2 + 1,
+			       sizeof(*ranges), GFP_KERNEL);
 	if (!ranges)
 		return -ENOMEM;
 
 	/* Try each phase and extract good ranges */
-	for (i = 0; i < NUM_PHASES; ) {
-		clk_set_phase(priv->sample_clk, TUNING_ITERATION_TO_PHASE(i));
+	for (i = 0; i < priv->num_phases; ) {
+		clk_set_phase(priv->sample_clk,
+			      TUNING_ITERATION_TO_PHASE(i, priv->num_phases));
 
 		v = !mmc_send_tuning(mmc, opcode, NULL);
 
@@ -179,7 +182,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		if (v) {
 			ranges[range_count-1].end = i;
 			i++;
-		} else if (i == NUM_PHASES - 1) {
+		} else if (i == priv->num_phases - 1) {
 			/* No extra skipping rules if we're at the end */
 			i++;
 		} else {
@@ -188,11 +191,11 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 			 * one since testing bad phases is slow.  Skip
 			 * 20 degrees.
 			 */
-			i += DIV_ROUND_UP(20 * NUM_PHASES, 360);
+			i += DIV_ROUND_UP(20 * priv->num_phases, 360);
 
 			/* Always test the last one */
-			if (i >= NUM_PHASES)
-				i = NUM_PHASES - 1;
+			if (i >= priv->num_phases)
+				i = priv->num_phases - 1;
 		}
 
 		prev_v = v;
@@ -210,7 +213,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		range_count--;
 	}
 
-	if (ranges[0].start == 0 && ranges[0].end == NUM_PHASES - 1) {
+	if (ranges[0].start == 0 && ranges[0].end == priv->num_phases - 1) {
 		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
 		dev_info(host->dev, "All phases work, using default phase %d.",
 			 priv->default_sample_phase);
@@ -222,7 +225,7 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		int len = (ranges[i].end - ranges[i].start + 1);
 
 		if (len < 0)
-			len += NUM_PHASES;
+			len += priv->num_phases;
 
 		if (longest_range_len < len) {
 			longest_range_len = len;
@@ -230,25 +233,30 @@ static int dw_mci_rk3288_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 		}
 
 		dev_dbg(host->dev, "Good phase range %d-%d (%d len)\n",
-			TUNING_ITERATION_TO_PHASE(ranges[i].start),
-			TUNING_ITERATION_TO_PHASE(ranges[i].end),
+			TUNING_ITERATION_TO_PHASE(ranges[i].start,
+						  priv->num_phases),
+			TUNING_ITERATION_TO_PHASE(ranges[i].end,
+						  priv->num_phases),
 			len
 		);
 	}
 
 	dev_dbg(host->dev, "Best phase range %d-%d (%d len)\n",
-		TUNING_ITERATION_TO_PHASE(ranges[longest_range].start),
-		TUNING_ITERATION_TO_PHASE(ranges[longest_range].end),
+		TUNING_ITERATION_TO_PHASE(ranges[longest_range].start,
+					  priv->num_phases),
+		TUNING_ITERATION_TO_PHASE(ranges[longest_range].end,
+					  priv->num_phases),
 		longest_range_len
 	);
 
 	middle_phase = ranges[longest_range].start + longest_range_len / 2;
-	middle_phase %= NUM_PHASES;
+	middle_phase %= priv->num_phases;
 	dev_info(host->dev, "Successfully tuned phase to %d\n",
-		 TUNING_ITERATION_TO_PHASE(middle_phase));
+		 TUNING_ITERATION_TO_PHASE(middle_phase, priv->num_phases));
 
 	clk_set_phase(priv->sample_clk,
-		      TUNING_ITERATION_TO_PHASE(middle_phase));
+		      TUNING_ITERATION_TO_PHASE(middle_phase,
+						priv->num_phases));
 
 free:
 	kfree(ranges);
@@ -264,6 +272,10 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 	if (!priv)
 		return -ENOMEM;
 
+	if (of_property_read_u32(np, "rockchip,desired-num-phases",
+					&priv->num_phases))
+		priv->num_phases = 360;
+
 	if (of_property_read_u32(np, "rockchip,default-sample-phase",
 					&priv->default_sample_phase))
 		priv->default_sample_phase = 0;
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
