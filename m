From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [RFC/PATCH 3/6] mmc: add general runtime PM support
Date: Wed, 11 Aug 2010 16:19:27 +0300
Message-ID: <1281532770-27545-4-git-send-email-ohad@wizery.com>
References: <1281532770-27545-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281532770-27545-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Gao Yunpeng <yunpeng.gao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add Runtime PM handlers to mmc, which calls mmc_power_save_host
and mmc_power_restore_host in respond to runtime_suspend and
runtime_resume events.

Runtime PM is still disabled by default, so this patch alone
has no immediate effect.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/core/bus.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 49d9dca..27902b4 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -137,6 +138,39 @@ static int mmc_bus_resume(struct device *dev)
 	return ret;
 }
 
+static int mmc_runtime_suspend(struct device *dev)
+{
+	int status = 0;
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	mmc_power_save_host(card->host);
+
+	return status;
+}
+
+static int mmc_runtime_resume(struct device *dev)
+{
+	int status = 0;
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	mmc_power_restore_host(card->host);
+
+	return status;
+}
+
+static int mmc_runtime_idle(struct device *dev)
+{
+	struct mmc_card *card = dev_to_mmc_card(dev);
+
+	return pm_runtime_suspend(dev);
+}
+
+static const struct dev_pm_ops mmc_bus_pm_ops = {
+	.runtime_suspend	= mmc_runtime_suspend,
+	.runtime_resume		= mmc_runtime_resume,
+	.runtime_idle		= mmc_runtime_idle,
+};
+
 static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_attrs	= mmc_dev_attrs,
@@ -146,6 +180,7 @@ static struct bus_type mmc_bus_type = {
 	.remove		= mmc_bus_remove,
 	.suspend	= mmc_bus_suspend,
 	.resume		= mmc_bus_resume,
+	.pm		= &mmc_bus_pm_ops,
 };
 
 int mmc_register_bus(void)
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
