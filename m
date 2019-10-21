From: Ram Prakash Gupta <rampraka@codeaurora.org>
Subject: [RFC 1/6] mmc: core: Parse clk scaling dt entries
Date: Mon, 21 Oct 2019 19:59:32 +0530
Message-ID: <1571668177-3766-2-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Talel Shenhar <tatias@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "Bao D. Nguyen" <nguyenb@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Add support to parse clk scaling dt entries in mmc
driver.

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Co-Developed-by: Ram Prakash Gupta <rampraka@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
---
 drivers/mmc/core/host.c  | 63 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  7 +++++
 include/linux/mmc/host.h | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 105b7a7..672f2d6 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -161,6 +161,44 @@ static void mmc_retune_timer(struct timer_list *t)
 	mmc_retune_needed(host);
 }
 
+static int mmc_dt_get_array(struct device *dev, const char *prop_name,
+				u32 **out, int *len, u32 size)
+{
+	int ret = 0;
+	struct device_node *np = dev->of_node;
+	size_t sz;
+	u32 *arr = NULL;
+
+	if (!of_get_property(np, prop_name, len)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	sz = *len = *len / sizeof(*arr);
+	if (sz <= 0 || (size > 0 && (sz > size))) {
+		dev_err(dev, "%s invalid size\n", prop_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	arr = devm_kcalloc(dev, sz, sizeof(*arr), GFP_KERNEL);
+	if (!arr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = of_property_read_u32_array(np, prop_name, arr, sz);
+	if (ret < 0) {
+		dev_err(dev, "%s failed reading array %d\n", prop_name, ret);
+		goto out;
+	}
+	*out = arr;
+out:
+	if (ret)
+		*len = 0;
+	return ret;
+
+}
+
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
@@ -173,10 +211,12 @@ static void mmc_retune_timer(struct timer_list *t)
 int mmc_of_parse(struct mmc_host *host)
 {
 	struct device *dev = host->parent;
+	struct device_node *np = dev->of_node;
 	u32 bus_width, drv_type, cd_debounce_delay_ms;
 	int ret;
 	bool cd_cap_invert, cd_gpio_invert = false;
 	bool ro_cap_invert, ro_gpio_invert = false;
+	const char *lower_bus_speed = NULL;
 
 	if (!dev || !dev_fwnode(dev))
 		return 0;
@@ -340,6 +380,29 @@ int mmc_of_parse(struct mmc_host *host)
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &host->ios.power_delay_ms);
 
+	if (mmc_dt_get_array(dev, "devfreq,freq-table",
+				&host->clk_scaling.pltfm_freq_table,
+				&host->clk_scaling.pltfm_freq_table_sz, 0))
+		pr_debug("%s: no clock scaling frequencies were supplied\n",
+				dev_name(dev));
+	else if (!host->clk_scaling.pltfm_freq_table ||
+			host->clk_scaling.pltfm_freq_table_sz)
+		dev_info(dev, "bad dts clock scaling frequencies\n");
+
+	/*
+	 * Few hosts can support DDR52 mode at the same lower
+	 * system voltage corner as high-speed mode. In such
+	 * cases, it is always better to put it in DDR
+	 * mode which will improve the performance
+	 * without any power impact.
+	 */
+	if (!of_property_read_string(np, "scaling-lower-bus-speed-mode",
+			&lower_bus_speed)) {
+		if (!strncmp(lower_bus_speed, "DDR52", strlen(lower_bus_speed)))
+			host->clk_scaling.lower_bus_speed_mode |=
+				MMC_SCALING_LOWER_DDR52_MODE;
+	}
+
 	return mmc_pwrseq_alloc(host);
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9b6336a..8b577a1 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -244,6 +244,12 @@ struct mmc_card {
 	struct mmc_host		*host;		/* the host this device belongs to */
 	struct device		dev;		/* the device */
 	u32			ocr;		/* the current OCR setting */
+	unsigned long		clk_scaling_lowest;	/* lowest scaleable
+							 * frequency
+							 */
+	unsigned long		clk_scaling_highest;	/* highest scaleable
+							 * frequency
+							 */
 	unsigned int		rca;		/* relative card address of device */
 	unsigned int		type;		/* card type */
 #define MMC_TYPE_MMC		0		/* MMC card */
@@ -306,6 +312,7 @@ struct mmc_card {
 	struct dentry		*debugfs_root;
 	struct mmc_part	part[MMC_NUM_PHY_PARTITION]; /* physical partitions */
 	unsigned int    nr_parts;
+	unsigned int            part_curr;
 
 	unsigned int		bouncesz;	/* Bounce buffer size */
 	struct workqueue_struct *complete_wq;	/* Private workqueue */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba70338..bfb47d6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/device.h>
+#include <linux/devfreq.h>
 #include <linux/fault-inject.h>
 
 #include <linux/mmc/core.h>
@@ -268,9 +269,72 @@ struct mmc_ctx {
 	struct task_struct *task;
 };
 
+enum dev_state {
+	DEV_SUSPENDING = 1,
+	DEV_SUSPENDED,
+	DEV_RESUMED,
+};
+
+enum mmc_load {
+	MMC_LOAD_HIGH,
+	MMC_LOAD_LOW,
+};
+
+/**
+ * struct mmc_devfeq_clk_scaling - main context for MMC clock scaling logic
+ *
+ * @lock: spinlock to protect statistics
+ * @devfreq: struct that represent mmc-host as a client for devfreq
+ * @devfreq_profile: MMC device profile, mostly polling interval and callbacks
+ * @ondemand_gov_data: struct supplied to ondemmand governor (thresholds)
+ * @state: load state, can be HIGH or LOW. used to notify mmc_host_ops callback
+ * @start_busy: timestamped armed once a data request is started
+ * @measure_interval_start: timestamped armed once a measure interval started
+ * @devfreq_abort: flag to sync between different contexts relevant to devfreq
+ * @skip_clk_scale_freq_update: flag that enable/disable frequency change
+ * @freq_table_sz: table size of frequencies supplied to devfreq
+ * @freq_table: frequencies table supplied to devfreq
+ * @curr_freq: current frequency
+ * @polling_delay_ms: polling interval for status collection used by devfreq
+ * @upthreshold: up-threshold supplied to ondemand governor
+ * @downthreshold: down-threshold supplied to ondemand governor
+ * @need_freq_change: flag indicating if a frequency change is required
+ * @is_busy_started: flag indicating if a request is handled by the HW
+ * @enable: flag indicating if the clock scaling logic is enabled for this host
+ * @is_suspended: to make devfreq request queued when mmc is suspened
+ */
+struct mmc_devfeq_clk_scaling {
+	spinlock_t	lock;
+	struct		devfreq *devfreq;
+	struct		devfreq_dev_profile devfreq_profile;
+	struct		devfreq_simple_ondemand_data ondemand_gov_data;
+	enum mmc_load	state;
+	ktime_t		start_busy;
+	ktime_t		measure_interval_start;
+	atomic_t	devfreq_abort;
+	bool		skip_clk_scale_freq_update;
+	int		freq_table_sz;
+	int		pltfm_freq_table_sz;
+	u32		*freq_table;
+	u32		*pltfm_freq_table;
+	unsigned long	total_busy_time_us;
+	unsigned long	target_freq;
+	unsigned long	curr_freq;
+	unsigned long	polling_delay_ms;
+	unsigned int	upthreshold;
+	unsigned int	downthreshold;
+	unsigned int	lower_bus_speed_mode;
+#define MMC_SCALING_LOWER_DDR52_MODE	1
+	bool		need_freq_change;
+	bool		is_busy_started;
+	bool		enable;
+	bool		is_suspended;
+};
+
 struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
+	struct mmc_devfeq_clk_scaling	clk_scaling;
 	int			index;
 	const struct mmc_host_ops *ops;
 	struct mmc_pwrseq	*pwrseq;
@@ -369,6 +433,7 @@ struct mmc_host {
 #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
 #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
 #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
+#define MMC_CAP2_CLK_SCALE      (1 << 27)       /* Allow dynamic clk scaling */
 
 	int			fixed_drv_type;	/* fixed driver type for non-removable media */
 
@@ -462,6 +527,7 @@ struct mmc_host {
 	bool			cqe_enabled;
 	bool			cqe_on;
 
+	atomic_t active_reqs;
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.9.1
