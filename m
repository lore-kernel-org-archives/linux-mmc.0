From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] MMC / PM: Make it possible to use PM QoS latency constraints, v2
Date: Sun, 4 Mar 2012 20:55:27 +0100
Message-ID: <201203042055.28111.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54424 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807Ab2CDTxL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 4 Mar 2012 14:53:11 -0500
In-Reply-To: <201203042053.19314.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

A runtime suspend of an MMC controller belonging to a power domain
or, in a more complicated scenario, a runtime suspend of another
device in the same power domain, may cause power to be removed from
the entire domain.  In that case, the amount of time necessary to
runtime-resume the MMC controller is often substantially greater
than the time needed to enable its clock.  That may hurt performance
in some situations, because user data may need to wait for the
controller to become operational, so we should make it possible to
prevent that from happening.

For this reason, introduce a new sysfs attribute for MMC hosts,
pm_latency_limit_ms, allowing user space to specify the upper bound
of the time necessary to bring the (runtime-suspended) host up after
the resume of it has been requested.  However, make that attribute
appear ony for the hosts whose drivers declare support for PM QoS by
populating the pm_qos member of struct mmc_host before registering
the host.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/mmc/mmc-dev-attrs.txt |   24 ++++++++++++
 drivers/mmc/core/host.c             |   67 ++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h            |    9 ++++
 3 files changed, 100 insertions(+)

Index: linux/drivers/mmc/core/host.c
===================================================================
--- linux.orig/drivers/mmc/core/host.c
+++ linux/drivers/mmc/core/host.c
@@ -293,6 +293,68 @@ static inline void mmc_host_clk_sysfs_in
 
 #endif
 
+static ssize_t pm_qos_val_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n", host->pm_qos->val);
+}
+
+static ssize_t pm_qos_val_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	s32 value;
+	int ret;
+
+	if (kstrtos32(buf, 0, &value))
+		return -EINVAL;
+
+	if (value < 0)
+		return -EINVAL;
+
+	host->pm_qos->val = value;
+	ret = dev_pm_qos_update_request(&host->pm_qos->req, value);
+	return ret < 0 ? ret : count;
+}
+
+static void mmc_host_pm_qos_init(struct mmc_host *host)
+{
+	int ret;
+
+	if (!host->pm_qos)
+		return;
+
+	ret = dev_pm_qos_add_request(host->parent, &host->pm_qos->req,
+				     host->pm_qos->val);
+	if (ret < 0) {
+		dev_err(host->parent, "Unable to use PM QoS: %d\n", ret);
+		return;
+	}
+
+	host->pm_qos->val_attr.show = pm_qos_val_show;
+	host->pm_qos->val_attr.store = pm_qos_val_store;
+	sysfs_attr_init(&host->pm_qos->val_attr.attr);
+	host->pm_qos->val_attr.attr.name = "pm_latency_limit_ms";
+	host->pm_qos->val_attr.attr.mode = S_IRUGO | S_IWUSR;
+	if (device_create_file(&host->class_dev, &host->pm_qos->val_attr)) {
+		pr_err("%s: Failed to create PM latency limit sysfs entry\n",
+				mmc_hostname(host));
+		host->pm_qos->val_attr.attr.name = NULL;
+	}
+}
+
+static void mmc_host_pm_qos_exit(struct mmc_host *host)
+{
+	if (!host->pm_qos)
+		return;
+
+	if (host->pm_qos->val_attr.attr.name)
+		device_remove_file(&host->class_dev, &host->pm_qos->val_attr);
+
+	dev_pm_qos_remove_request(&host->pm_qos->req);
+}
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
@@ -381,6 +443,8 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 	mmc_host_clk_sysfs_init(host);
 
+	mmc_host_pm_qos_init(host);
+
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
 
@@ -400,8 +464,11 @@ EXPORT_SYMBOL(mmc_add_host);
 void mmc_remove_host(struct mmc_host *host)
 {
 	unregister_pm_notifier(&host->pm_notify);
+
 	mmc_stop_host(host);
 
+	mmc_host_pm_qos_exit(host);
+
 #ifdef CONFIG_DEBUG_FS
 	mmc_remove_host_debugfs(host);
 #endif
Index: linux/include/linux/mmc/host.h
===================================================================
--- linux.orig/include/linux/mmc/host.h
+++ linux/include/linux/mmc/host.h
@@ -13,6 +13,7 @@
 #include <linux/leds.h>
 #include <linux/sched.h>
 #include <linux/fault-inject.h>
+#include <linux/pm_qos.h>
 
 #include <linux/mmc/core.h>
 #include <linux/mmc/pm.h>
@@ -177,6 +178,12 @@ struct mmc_hotplug {
 	void *handler_priv;
 };
 
+struct mmc_pm_qos {
+	struct dev_pm_qos_request req;
+	s32 val;
+	struct device_attribute val_attr;
+};
+
 struct mmc_host {
 	struct device		*parent;
 	struct device		class_dev;
@@ -191,6 +198,8 @@ struct mmc_host {
 	u32			ocr_avail_mmc;	/* MMC-specific OCR */
 	struct notifier_block	pm_notify;
 
+	struct mmc_pm_qos	*pm_qos;
+
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
 #define MMC_VDD_21_22		0x00000200	/* VDD voltage 2.1 ~ 2.2 */
Index: linux/Documentation/mmc/mmc-dev-attrs.txt
===================================================================
--- linux.orig/Documentation/mmc/mmc-dev-attrs.txt
+++ linux/Documentation/mmc/mmc-dev-attrs.txt
@@ -74,3 +74,27 @@ This attribute appears only if CONFIG_MM
 	clkgate_delay	Tune the clock gating delay with desired value in milliseconds.
 
 echo <desired delay> > /sys/class/mmc_host/mmcX/clkgate_delay
+
+MMC PM QoS Support
+==================
+
+If the MMC host driver supports PM QoS, it should populate the pm_qos member
+of struct mmc_host before registering the host.  In that case, read and write
+access if provided to the following attribute:
+
+	pm_latency_limit_ms	Specify the upper bound of the time, since a
+				resume request, necessary to bring the host up
+				after it has been runtime-suspended
+				(in milliseconds).
+
+echo <desired latency limit> > /sys/class/mmc_host/mmcX/pm_latency_limit_ms
+
+The precise meaning of this attribute is "whenever the host is runtime-suspended,
+make sure that it will be possible to bring it up within the given time from
+a resume request" (e.g. if the limit is set to 10 ms, it should always be
+possible to make the runtime-suspended host operational at most 10 ms from a
+resume request).  Note, however, that if the limit is set too small, the only
+physically possible way to respect it may be to keep the host permanently
+operational (i.e. to avoid suspending it).
+
+If 0 is written to pm_latency_limit_ms, it means that there is no limit.

