From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [V2 PATCH 2/5] mmc: host: add runtime PM for host class dev
Date: Fri, 3 Apr 2015 19:25:53 +0800
Message-ID: <20150403112553.GC29880@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2499 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244AbbDCL2A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Apr 2015 07:28:00 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alex.Lemberg@sandisk.com

mmc host has a class device which is parent of the card device, also
a children of the low level host device. Right now we have runtime pm
for card device and low level host device, but nothing for this host class
device. So it is impossible to connect the card runtime pm to low level host
runtime pm together.

We implement runtime pm to mmc host class device, so that when the card device
doesn't want to be ignored by the low level host runtime pm, card device driver
can talk to class device, so class device can talk to his parent.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/host.c       |   13 +++++++++++++
 drivers/mmc/host/sdhci-acpi.c |    1 -
 drivers/mmc/host/sdhci-pci.c  |    1 -
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df7..bb7b655 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -22,6 +22,7 @@
 #include <linux/leds.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -46,9 +47,15 @@ static void mmc_host_classdev_release(struct device *dev)
 	kfree(host);
 }
 
+static const struct dev_pm_ops mmc_host_class_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend,
+			pm_generic_runtime_resume, NULL)
+};
+
 static struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
+	.pm		= &mmc_host_class_pm_ops,
 };
 
 int mmc_register_host_class(void)
@@ -547,6 +554,12 @@ int mmc_add_host(struct mmc_host *host)
 #endif
 	mmc_host_clk_sysfs_init(host);
 
+	/*
+	 * ignore the children by default
+	 */
+	pm_suspend_ignore_children(&host->class_dev, true);
+	pm_runtime_enable(&host->class_dev);
+
 	mmc_start_host(host);
 	register_pm_notifier(&host->pm_notify);
 
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 22d929f..0e40d44 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -373,7 +373,6 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	if (c->use_runtime_pm) {
 		pm_runtime_set_active(dev);
-		pm_suspend_ignore_children(dev, 1);
 		pm_runtime_set_autosuspend_delay(dev, 50);
 		pm_runtime_use_autosuspend(dev);
 		pm_runtime_enable(dev);
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 29eaff7..93e06ae9 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1568,7 +1568,6 @@ static void sdhci_pci_runtime_pm_allow(struct device *dev)
 	pm_runtime_allow(dev);
 	pm_runtime_set_autosuspend_delay(dev, 50);
 	pm_runtime_use_autosuspend(dev);
-	pm_suspend_ignore_children(dev, 1);
 }
 
 static void sdhci_pci_runtime_pm_forbid(struct device *dev)
-- 
1.7.10.4

