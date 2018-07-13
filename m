From: Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH RFC 1/7] devfreq: Add new flag to do simple clock scaling
Date: Fri, 13 Jul 2018 15:22:57 +0530
Message-ID: <1531475583-7050-2-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, sayalil@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

Add new flag "simple_scaling" to on demand governor so that
the clocks can be scaled up only when the load is more than
up threshold and can be scaled down only when the load is less
than down differential data as provided within
struct devfreq_simple_ondemand_data.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/devfreq/governor_simpleondemand.c | 25 +++++++++++++++++++------
 include/linux/devfreq.h                   |  4 ++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 28e0f2d..532801b 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -28,6 +28,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
 	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
+	unsigned long min = (df->min_freq) ? df->min_freq : 0;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -45,18 +46,30 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	    dfso_upthreshold < dfso_downdifferential)
 		return -EINVAL;
 
-	/* Assume MAX if it is going to be divided by zero */
-	if (stat->total_time == 0) {
-		*freq = max;
-		return 0;
-	}
-
 	/* Prevent overflow */
 	if (stat->busy_time >= (1 << 24) || stat->total_time >= (1 << 24)) {
 		stat->busy_time >>= 7;
 		stat->total_time >>= 7;
 	}
 
+	if (data && data->simple_scaling) {
+		if (stat->busy_time * 100 >
+		    stat->total_time * dfso_upthreshold)
+			*freq = max;
+		else if (stat->busy_time * 100 <
+		    stat->total_time * dfso_downdifferential)
+			*freq = min;
+		else
+			*freq = df->previous_freq;
+		return 0;
+	}
+
+	/* Assume MAX if it is going to be divided by zero */
+	if (stat->total_time == 0) {
+		*freq = max;
+		return 0;
+	}
+
 	/* Set MAX if it's busy enough */
 	if (stat->busy_time * 100 >
 	    stat->total_time * dfso_upthreshold) {
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 3aae5b3..2957fd8 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -236,6 +236,9 @@ extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
  *			the governor may consider slowing the frequency down.
  *			Specify 0 to use the default. Valid value = 0 to 100.
  *			downdifferential < upthreshold must hold.
+ * @simple_scaling:	Setting this flag will scale the clocks up only if the
+ *			load is above @upthreshold and will scale the clocks
+ *			down only if the load is below @downdifferential.
  *
  * If the fed devfreq_simple_ondemand_data pointer is NULL to the governor,
  * the governor uses the default values.
@@ -243,6 +246,7 @@ extern struct devfreq *devfreq_get_devfreq_by_phandle(struct device *dev,
 struct devfreq_simple_ondemand_data {
 	unsigned int upthreshold;
 	unsigned int downdifferential;
+	unsigned int simple_scaling;
 };
 #endif
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
