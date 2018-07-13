From: Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH RFC 7/7] mmc: core: Add a debugfs entry to set max clock rate
Date: Fri, 13 Jul 2018 15:23:03 +0530
Message-ID: <1531475583-7050-8-git-send-email-sayalil@codeaurora.org>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, sayalil@codeaurora.org, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

Limiting the max frequency supported by host controller
to a certain value can be useful for testing power consumption
at various frequencies that are supported by the host.
Note: If the card supports less than desired value then the
frequency of operation would be limited to that frequency.
Usage:
mount -t debugfs none /sys/kernel/debug
echo <desired_frequency> > /sys/kernel/debug/mmcX/max_clock
cat /sys/kernel/debug/mmcX/max_clock

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 drivers/mmc/core/debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 630ca8e..26499f7 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -262,6 +262,46 @@ static int mmc_scale_set(void *data, u64 val)
 DEFINE_SIMPLE_ATTRIBUTE(mmc_scale_fops, mmc_scale_get, mmc_scale_set,
 	"%llu\n");
 
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
@@ -290,6 +330,10 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 			&mmc_clock_fops))
 		goto err_node;
 
+	if (!debugfs_create_file("max_clock", 0600, root, host,
+		&mmc_max_clock_fops))
+		goto err_node;
+
 	if (!debugfs_create_file("scale", 0600, root, host,
 		&mmc_scale_fops))
 		goto err_node;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
