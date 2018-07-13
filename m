From: Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH RFC 3/7] mmc: core: Add sysfs entries for dynamic control of clock scaling
Date: Fri, 13 Jul 2018 15:22:59 +0530
Message-ID: <1531475583-7050-4-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, sayalil@codeaurora.org, Sujit Reddy Thumma <sthumma@codeaurora.org>, Subhash Jadavani <subhashj@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Add sysfs attributes to allow dynamic control of clock scaling
parameters. These attributes are used to enable/disable clock
scaling at runtime and change the up_threshold, down_threshold,
and polling_interval values. Complete documentation for these
sysfs entries are provided at "Documentation/mmc/mmc-dev-attrs.txt".

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 Documentation/mmc/mmc-dev-attrs.txt |  38 +++++++++
 drivers/mmc/core/host.c             | 151 +++++++++++++++++++++++++++++++++++-
 2 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 4ad0bb1..b02b2b4 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -75,3 +75,41 @@ Note on raw_rpmb_size_mult:
 	"raw_rpmb_size_mult" is a multiple of 128kB block.
 	RPMB size in byte is calculated by using the following equation:
 	RPMB partition size = 128kB x raw_rpmb_size_mult
+
+SD/MMC Clock Scaling Attributes
+====================================
+
+Read and write accesses are provided to following attributes.
+
+	polling_interval	Measured in milliseconds, this attribute
+				defines how often we need to check the card
+				usage and make decisions on frequency scaling.
+
+	up_threshold		This attribute defines what should be the
+				average card usage between the polling
+				interval for the mmc core to make a decision
+				on whether it should increase the frequency.
+				For example when it is set to '35' it means
+				that between the checking intervals the card
+				needs to be on average more than 35% in use to
+				scale up the frequency. The value should be
+				between 0 - 100 so that it can be compared
+				against load percentage.
+
+	down_threshold		Similar to up_threshold, but on lowering the
+				frequency. For example, when it is set to '2'
+				it means that between the checking intervals
+				the card needs to be on average less than 2%
+				in use to scale down the clocks to minimum
+				frequency. The value should be between 0 - 100
+				so that it can be compared against load
+				percentage.
+
+	enable			Enable clock scaling for hosts (and cards)
+				that support ultrahigh speed modes
+				(SDR104, DDR50, HS200).
+
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/polling_interval
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/up_threshold
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/down_threshold
+echo <desired value> > /sys/class/mmc_host/mmcX/clk_scaling/enable
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1e46aa4..0504610 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -419,6 +419,151 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 EXPORT_SYMBOL(mmc_alloc_host);
 
+static ssize_t show_enable(struct device *dev,
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
+static ssize_t store_enable(struct device *dev,
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
+		/* mask host capability */
+		host->caps2 &= ~MMC_CAP2_CLK_SCALE;
+		host->clk_scaling.state = MMC_LOAD_HIGH;
+		/* Set to max. frequency when disabling */
+		mmc_clk_update_freq(host, host->card->clk_scaling_highest,
+					host->clk_scaling.state);
+	} else if (value) {
+		/* Unmask host capability*/
+		host->caps2 |= MMC_CAP2_CLK_SCALE;
+	}
+
+	mmc_put_card(host->card, NULL);
+
+	return count;
+}
+
+static ssize_t show_up_threshold(struct device *dev,
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
+static ssize_t store_up_threshold(struct device *dev,
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
+static ssize_t show_down_threshold(struct device *dev,
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
+static ssize_t store_down_threshold(struct device *dev,
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
+static ssize_t show_polling(struct device *dev,
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
+static ssize_t store_polling(struct device *dev,
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
+DEVICE_ATTR(enable, 0644,
+		show_enable, store_enable);
+DEVICE_ATTR(polling_interval, 0644,
+		show_polling, store_polling);
+DEVICE_ATTR(up_threshold, 0644,
+		show_up_threshold, store_up_threshold);
+DEVICE_ATTR(down_threshold, 0644,
+		show_down_threshold, store_down_threshold);
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
@@ -447,6 +592,10 @@ int mmc_add_host(struct mmc_host *host)
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_host_debugfs(host);
 #endif
+	err = sysfs_create_group(&host->class_dev.kobj, &clk_scaling_attr_grp);
+	if (err)
+		pr_err("%s: failed to create clk scale sysfs group with err %d\n",
+				__func__, err);
 
 	mmc_start_host(host);
 	mmc_register_pm_notifier(host);
@@ -472,7 +621,7 @@ void mmc_remove_host(struct mmc_host *host)
 #ifdef CONFIG_DEBUG_FS
 	mmc_remove_host_debugfs(host);
 #endif
-
+	sysfs_remove_group(&host->class_dev.kobj, &clk_scaling_attr_grp);
 	device_del(&host->class_dev);
 
 	led_trigger_unregister_simple(host->led);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
