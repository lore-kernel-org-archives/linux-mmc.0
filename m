From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] PM / QoS: Make it possible to expose PM QoS latency constraints
Date: Thu, 8 Mar 2012 00:28:12 +0100
Message-ID: <201203080028.12547.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl> <201203080027.27435.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32873 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab2CGX0h (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Mar 2012 18:26:37 -0500
In-Reply-To: <201203080027.27435.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

A runtime suspend of a device (e.g. an MMC controller) belonging to
a power domain or, in a more complicated scenario, a runtime suspend
of another device in the same power domain, may cause power to be
removed from the entire domain.  In that case, the amount of time
necessary to runtime-resume the given device (e.g. the MMC
controller) is often substantially greater than the time needed to
run its driver's runtime resume callback.  That may hurt performance
in some situations, because user data may need to wait for the
device to become operational, so we should make it possible to
prevent that from happening.

For this reason, introduce a new sysfs attribute for devices,
power/pm_qos_latency_us, allowing user space to specify the upper
bound of the time necessary to bring the (runtime-suspended) device
up after the resume of it has been requested.  However, make that
attribute appear ony for the devices whose drivers declare support
for by calling the (new) dev_pm_qos_expose_latency_limit() helper
function with the appropriate initial value of the attribute.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/ABI/testing/sysfs-devices-power |   15 +++++++
 drivers/base/power/power.h                    |    4 +
 drivers/base/power/qos.c                      |   53 ++++++++++++++++++++++++++
 drivers/base/power/sysfs.c                    |   46 ++++++++++++++++++++++
 include/linux/pm.h                            |    1 
 include/linux/pm_qos.h                        |    5 ++
 6 files changed, 124 insertions(+)

Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h
+++ linux/include/linux/pm.h
@@ -549,6 +549,7 @@ struct dev_pm_info {
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	struct pm_qos_constraints *constraints;
+	struct dev_pm_qos_request *pq_req;
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
Index: linux/drivers/base/power/sysfs.c
===================================================================
--- linux.orig/drivers/base/power/sysfs.c
+++ linux/drivers/base/power/sysfs.c
@@ -5,6 +5,7 @@
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/export.h>
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/atomic.h>
 #include <linux/jiffies.h>
@@ -455,6 +456,32 @@ static ssize_t async_store(struct device
 static DEVICE_ATTR(async, 0644, async_show, async_store);
 #endif /* CONFIG_PM_ADVANCED_DEBUG */
 
+static ssize_t pm_qos_latency_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", dev->power.pq_req->node.prio);
+}
+
+static ssize_t pm_qos_latency_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t n)
+{
+	s32 value;
+	int ret;
+
+	if (kstrtos32(buf, 0, &value))
+		return -EINVAL;
+
+	if (value < 0)
+		return -EINVAL;
+
+	ret = dev_pm_qos_update_request(dev->power.pq_req, value);
+	return ret < 0 ? ret : n;
+}
+
+static DEVICE_ATTR(pm_qos_latency_us, 0644,
+		   pm_qos_latency_show, pm_qos_latency_store);
+
 static struct attribute *power_attrs[] = {
 #ifdef CONFIG_PM_ADVANCED_DEBUG
 #ifdef CONFIG_PM_SLEEP
@@ -510,6 +537,15 @@ static struct attribute_group pm_runtime
 	.attrs	= runtime_attrs,
 };
 
+static struct attribute *pm_qos_attrs[] = {
+	&dev_attr_pm_qos_latency_us.attr,
+	NULL,
+};
+static struct attribute_group pm_qos_attr_group = {
+	.name	= power_group_name,
+	.attrs	= pm_qos_attrs,
+};
+
 int dpm_sysfs_add(struct device *dev)
 {
 	int rc;
@@ -550,6 +586,16 @@ void wakeup_sysfs_remove(struct device *
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
 }
 
+int pm_qos_sysfs_add(struct device *dev)
+{
+	return sysfs_merge_group(&dev->kobj, &pm_qos_attr_group);
+}
+
+void pm_qos_sysfs_remove(struct device *dev)
+{
+	sysfs_unmerge_group(&dev->kobj, &pm_qos_attr_group);
+}
+
 void rpm_sysfs_remove(struct device *dev)
 {
 	sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
Index: linux/drivers/base/power/power.h
===================================================================
--- linux.orig/drivers/base/power/power.h
+++ linux/drivers/base/power/power.h
@@ -71,6 +71,8 @@ extern void dpm_sysfs_remove(struct devi
 extern void rpm_sysfs_remove(struct device *dev);
 extern int wakeup_sysfs_add(struct device *dev);
 extern void wakeup_sysfs_remove(struct device *dev);
+extern int pm_qos_sysfs_add(struct device *dev);
+extern void pm_qos_sysfs_remove(struct device *dev);
 
 #else /* CONFIG_PM */
 
@@ -79,5 +81,7 @@ static inline void dpm_sysfs_remove(stru
 static inline void rpm_sysfs_remove(struct device *dev) {}
 static inline int wakeup_sysfs_add(struct device *dev) { return 0; }
 static inline void wakeup_sysfs_remove(struct device *dev) {}
+static inline int pm_qos_sysfs_add(struct device *dev) { return 0; }
+static inline void pm_qos_sysfs_remove(struct device *dev) {}
 
 #endif
Index: linux/drivers/base/power/qos.c
===================================================================
--- linux.orig/drivers/base/power/qos.c
+++ linux/drivers/base/power/qos.c
@@ -41,6 +41,7 @@
 #include <linux/mutex.h>
 #include <linux/export.h>
 
+#include "power.h"
 
 static DEFINE_MUTEX(dev_pm_qos_mtx);
 
@@ -445,3 +446,55 @@ int dev_pm_qos_add_ancestor_request(stru
 	return error;
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_add_ancestor_request);
+
+static void __dev_pm_qos_drop_user_request(struct device *dev)
+{
+	dev_pm_qos_remove_request(dev->power.pq_req);
+	dev->power.pq_req = 0;
+}
+
+/**
+ * dev_pm_qos_expose_latency_limit - Expose PM QoS latency limit to user space.
+ * @dev: Device whose PM QoS latency limit is to be exposed to user space.
+ * @value: Initial value of the latency limit.
+ */
+int dev_pm_qos_expose_latency_limit(struct device *dev, s32 value)
+{
+	struct dev_pm_qos_request *req;
+	int ret;
+
+	if (!device_is_registered(dev) || value < 0)
+		return -EINVAL;
+
+	if (dev->power.pq_req)
+		return -EEXIST;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	ret = dev_pm_qos_add_request(dev, req, value);
+	if (ret < 0)
+		return ret;
+
+	dev->power.pq_req = req;
+	ret = pm_qos_sysfs_add(dev);
+	if (ret)
+		__dev_pm_qos_drop_user_request(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_expose_latency_limit);
+
+/**
+ * dev_pm_qos_hide_latency_limit - Hide PM QoS latency limit from user space.
+ * @dev: Device whose PM QoS latency limit is to be hidden from user space.
+ */
+void dev_pm_qos_hide_latency_limit(struct device *dev)
+{
+	if (dev->power.pq_req) {
+		pm_qos_sysfs_remove(dev);
+		__dev_pm_qos_drop_user_request(dev);
+	}
+}
+EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_limit);
Index: linux/include/linux/pm_qos.h
===================================================================
--- linux.orig/include/linux/pm_qos.h
+++ linux/include/linux/pm_qos.h
@@ -98,6 +98,8 @@ void dev_pm_qos_constraints_init(struct
 void dev_pm_qos_constraints_destroy(struct device *dev);
 int dev_pm_qos_add_ancestor_request(struct device *dev,
 				    struct dev_pm_qos_request *req, s32 value);
+int dev_pm_qos_expose_latency_limit(struct device *dev, s32 value);
+void dev_pm_qos_hide_latency_limit(struct device *dev);
 #else
 static inline s32 __dev_pm_qos_read_value(struct device *dev)
 			{ return 0; }
@@ -135,6 +137,9 @@ static inline void dev_pm_qos_constraint
 static inline int dev_pm_qos_add_ancestor_request(struct device *dev,
 				    struct dev_pm_qos_request *req, s32 value)
 			{ return 0; }
+int dev_pm_qos_expose_latency_limit(struct device *dev, s32 value)
+			{ return 0; }
+void dev_pm_qos_hide_latency_limit(struct device *dev) {}
 #endif
 
 #endif
Index: linux/Documentation/ABI/testing/sysfs-devices-power
===================================================================
--- linux.orig/Documentation/ABI/testing/sysfs-devices-power
+++ linux/Documentation/ABI/testing/sysfs-devices-power
@@ -175,3 +175,18 @@ Description:
 
 		Not all drivers support this attribute.  If it isn't supported,
 		attempts to read or write it will yield I/O errors.
+
+What:		/sys/devices/.../power/pm_qos_latency_us
+Date:		March 2012
+Contact:	Rafael J. Wysocki <rjw@sisk.pl>
+Description:
+		The /sys/devices/.../power/pm_qos_latency_us attribute contains
+		the PM QoS resume latency limit for the given device, which is
+		the maximum allowed time it can take to resume the device, after
+		it has been suspended at run time, from a resume request to the
+		moment the device will be ready to process I/O, in microseconds.
+		If it is equal to 0, however, this means that the PM QoS resume
+		latency may be arbitrary.
+
+		Not all drivers support this attribute.  If it isn't supported,
+		it is not present.

