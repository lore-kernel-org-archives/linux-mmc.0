From: Ram Prakash Gupta <rampraka@codeaurora.org>
Subject: [RFC 4/6] mmc: core: Add debugfs entries for scaling support
Date: Mon, 21 Oct 2019 19:59:35 +0530
Message-ID: <1571668177-3766-5-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: asutoshd@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, rampraka@codeaurora.org, vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, Talel Shenhar <tatias@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "Bao D. Nguyen" <nguyenb@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Add debugfs entries for scaling support.

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
 drivers/mmc/core/debugfs.c |  90 ++++++++++++++++++++++++++
 drivers/mmc/core/host.c    | 153 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 243 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 09e0c76..a9f1e3f 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -222,6 +222,81 @@ static int mmc_clock_opt_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(mmc_clock_fops, mmc_clock_opt_get, mmc_clock_opt_set,
 	"%llu\n");
 
+static int mmc_scale_get(void *data, u64 *val)
+{
+	struct mmc_host *host = data;
+
+	*val = host->clk_scaling.curr_freq;
+
+	return 0;
+}
+
+static int mmc_scale_set(void *data, u64 val)
+{
+	int err = 0;
+	struct mmc_host *host = data;
+
+	mmc_claim_host(host);
+
+	/* change frequency from sysfs manually */
+	err = mmc_clk_update_freq(host, val, host->clk_scaling.state);
+	if (err == -EAGAIN)
+		err = 0;
+	else if (err)
+		pr_err("%s: clock scale to %llu failed with error %d\n",
+			mmc_hostname(host), val, err);
+	else
+		pr_debug("%s: clock change to %llu finished successfully (%s)\n",
+			mmc_hostname(host), val, current->comm);
+
+	mmc_release_host(host);
+
+	return err;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(mmc_scale_fops, mmc_scale_get, mmc_scale_set,
+	"%llu\n");
+
+static int mmc_max_clock_get(void *data, u64 *val)
+{
+	struct mmc_host *host = data;
+
+	if (!host)
+		return -EINVAL;
+
+	*val = host->f_max;
+
+	return 0;
+}
+
+static int mmc_max_clock_set(void *data, u64 val)
+{
+	struct mmc_host *host = data;
+	int err = -EINVAL;
+	unsigned long freq = val;
+	unsigned int old_freq;
+
+	if (!host || (val < host->f_min))
+		goto out;
+
+	mmc_claim_host(host);
+	if (host->bus_ops && host->bus_ops->change_bus_speed) {
+		old_freq = host->f_max;
+		host->f_max = freq;
+
+		err = host->bus_ops->change_bus_speed(host, &freq);
+
+		if (err)
+			host->f_max = old_freq;
+	}
+	mmc_release_host(host);
+out:
+	return err;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(mmc_max_clock_fops, mmc_max_clock_get,
+		mmc_max_clock_set, "%llu\n");
+
 void mmc_add_host_debugfs(struct mmc_host *host)
 {
 	struct dentry *root;
@@ -235,6 +310,19 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
 			    &mmc_clock_fops);
 
+	if (!debugfs_create_file("max_clock", 0600, root, host,
+		&mmc_max_clock_fops))
+		goto err_node;
+
+	if (!debugfs_create_file("scale", 0600, root, host,
+		&mmc_scale_fops))
+		goto err_node;
+
+	if (!debugfs_create_bool("skip_clk_scale_freq_update",
+		0600, root,
+		&host->clk_scaling.skip_clk_scale_freq_update))
+		goto err_node;
+
 #ifdef CONFIG_FAIL_MMC_REQUEST
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
@@ -242,6 +330,8 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	fault_create_debugfs_attr("fail_mmc_request", root,
 				  &host->fail_mmc_request);
 #endif
+err_node:
+	return;
 }
 
 void mmc_remove_host_debugfs(struct mmc_host *host)
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 9138041..c5b904b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -522,6 +522,154 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static ssize_t enable_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", mmc_can_scale_clk(host));
+}
+
+static ssize_t enable_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || !host->card || kstrtoul(buf, 0, &value))
+		return -EINVAL;
+
+	mmc_get_card(host->card, NULL);
+
+	if (!value) {
+		/* Suspend the clock scaling and mask host capability */
+		if (host->clk_scaling.enable)
+			mmc_suspend_clk_scaling(host);
+		host->clk_scaling.enable = false;
+		host->caps2 &= ~MMC_CAP2_CLK_SCALE;
+		host->clk_scaling.state = MMC_LOAD_HIGH;
+		/* Set to max. frequency when disabling */
+		mmc_clk_update_freq(host, host->card->clk_scaling_highest,
+					host->clk_scaling.state);
+	} else if (value) {
+		/* Unmask host capability and resume scaling */
+		host->caps2 |= MMC_CAP2_CLK_SCALE;
+		if (!host->clk_scaling.enable) {
+			host->clk_scaling.enable = true;
+			mmc_resume_clk_scaling(host);
+		}
+	}
+
+	mmc_put_card(host->card, NULL);
+
+	return count;
+}
+
+static ssize_t up_threshold_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", host->clk_scaling.upthreshold);
+}
+
+#define MAX_PERCENTAGE	100
+static ssize_t up_threshold_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || kstrtoul(buf, 0, &value) || (value > MAX_PERCENTAGE))
+		return -EINVAL;
+
+	host->clk_scaling.upthreshold = value;
+
+	pr_debug("%s: clkscale_up_thresh set to %lu\n",
+			mmc_hostname(host), value);
+	return count;
+}
+
+static ssize_t down_threshold_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			host->clk_scaling.downthreshold);
+}
+
+static ssize_t down_threshold_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || kstrtoul(buf, 0, &value) || (value > MAX_PERCENTAGE))
+		return -EINVAL;
+
+	host->clk_scaling.downthreshold = value;
+
+	pr_debug("%s: clkscale_down_thresh set to %lu\n",
+			mmc_hostname(host), value);
+	return count;
+}
+
+static ssize_t polling_interval_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+
+	if (!host)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%lu milliseconds\n",
+			host->clk_scaling.polling_delay_ms);
+}
+
+static ssize_t polling_interval_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	unsigned long value;
+
+	if (!host || kstrtoul(buf, 0, &value))
+		return -EINVAL;
+
+	host->clk_scaling.polling_delay_ms = value;
+
+	pr_debug("%s: clkscale_polling_delay_ms set to %lu\n",
+			mmc_hostname(host), value);
+	return count;
+}
+
+DEVICE_ATTR_RW(enable);
+DEVICE_ATTR_RW(polling_interval);
+DEVICE_ATTR_RW(up_threshold);
+DEVICE_ATTR_RW(down_threshold);
+
+static struct attribute *clk_scaling_attrs[] = {
+	&dev_attr_enable.attr,
+	&dev_attr_up_threshold.attr,
+	&dev_attr_down_threshold.attr,
+	&dev_attr_polling_interval.attr,
+	NULL,
+};
+
+static struct attribute_group clk_scaling_attr_grp = {
+	.name = "clk_scaling",
+	.attrs = clk_scaling_attrs,
+};
+
 /**
  *	mmc_add_host - initialise host hardware
  *	@host: mmc host
@@ -551,6 +699,10 @@ int mmc_add_host(struct mmc_host *host)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
 #endif
+	err = sysfs_create_group(&host->class_dev.kobj, &clk_scaling_attr_grp);
+	if (err)
+		pr_err("%s: failed to create clk scale sysfs group with err %d\n",
+				__func__, err);
 
 	mmc_start_host(host);
 	mmc_register_pm_notifier(host);
@@ -577,6 +729,7 @@ void mmc_remove_host(struct mmc_host *host)
 	mmc_remove_host_debugfs(host);
 #endif
 
+	sysfs_remove_group(&host->class_dev.kobj, &clk_scaling_attr_grp);
 	device_del(&host->class_dev);
 
 	led_trigger_unregister_simple(host->led);
-- 
1.9.1
