From: <gregkh@linuxfoundation.org>
Subject: patch "MMC: convert bus code to use dev_groups" added to driver-core tree
Date: Wed, 16 Oct 2013 18:39:17 -0700
Message-ID: <13819739571466@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38655 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887Ab3JQBjV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 21:39:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@linuxfoundation.org, cjb@laptop.org, kdorfman@codeaurora.org, linux-mmc@vger.kernel.org, tgih.jun@samsung.com, ulf.hansson@linaro.org


This is a note to let you know that I've just added the patch titled

    MMC: convert bus code to use dev_groups

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From f24fc57b24444fe31fbddb5716195bb8bbc70b58 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 6 Oct 2013 23:55:43 -0700
Subject: MMC: convert bus code to use dev_groups

The dev_attrs field of struct bus_type is going away soon, dev_groups
should be used instead.  This converts the MMC bus code to use the
correct field.

Cc: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/bus.c      | 12 +++++++-----
 drivers/mmc/core/sdio_bus.c | 21 ++++++++++++---------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 704bf66f..3e227bd9 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -27,7 +27,7 @@
 
 #define to_mmc_driver(d)	container_of(d, struct mmc_driver, drv)
 
-static ssize_t mmc_type_show(struct device *dev,
+static ssize_t type_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
@@ -45,11 +45,13 @@ static ssize_t mmc_type_show(struct device *dev,
 		return -EFAULT;
 	}
 }
+static DEVICE_ATTR_RO(type);
 
-static struct device_attribute mmc_dev_attrs[] = {
-	__ATTR(type, S_IRUGO, mmc_type_show, NULL),
-	__ATTR_NULL,
+static struct attribute *mmc_dev_attrs[] = {
+	&dev_attr_type.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(mmc_dev);
 
 /*
  * This currently matches any MMC driver to any MMC card - drivers
@@ -218,7 +220,7 @@ static const struct dev_pm_ops mmc_bus_pm_ops = {
 
 static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
-	.dev_attrs	= mmc_dev_attrs,
+	.dev_groups	= mmc_dev_groups,
 	.match		= mmc_bus_match,
 	.uevent		= mmc_bus_uevent,
 	.probe		= mmc_bus_probe,
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 6d67492a..ef895656 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -34,7 +34,8 @@ field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
 									\
 	func = dev_to_sdio_func (dev);					\
 	return sprintf (buf, format_string, func->field);		\
-}
+}									\
+static DEVICE_ATTR_RO(field)
 
 sdio_config_attr(class, "0x%02x\n");
 sdio_config_attr(vendor, "0x%04x\n");
@@ -47,14 +48,16 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "sdio:c%02Xv%04Xd%04X\n",
 			func->class, func->vendor, func->device);
 }
-
-static struct device_attribute sdio_dev_attrs[] = {
-	__ATTR_RO(class),
-	__ATTR_RO(vendor),
-	__ATTR_RO(device),
-	__ATTR_RO(modalias),
-	__ATTR_NULL,
+static DEVICE_ATTR_RO(modalias);
+
+static struct attribute *sdio_dev_attrs[] = {
+	&dev_attr_class.attr,
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
+	&dev_attr_modalias.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(sdio_dev);
 
 static const struct sdio_device_id *sdio_match_one(struct sdio_func *func,
 	const struct sdio_device_id *id)
@@ -225,7 +228,7 @@ static const struct dev_pm_ops sdio_bus_pm_ops = {
 
 static struct bus_type sdio_bus_type = {
 	.name		= "sdio",
-	.dev_attrs	= sdio_dev_attrs,
+	.dev_groups	= sdio_dev_groups,
 	.match		= sdio_bus_match,
 	.uevent		= sdio_bus_uevent,
 	.probe		= sdio_bus_probe,
-- 
1.8.4.3.gca3854a


