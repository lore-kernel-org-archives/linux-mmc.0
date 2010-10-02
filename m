From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 04/11] mmc: add runtime PM handlers
Date: Sat,  2 Oct 2010 13:54:08 +0200
Message-ID: <1286020455-28946-5-git-send-email-ohad@wizery.com>
References: <1286020455-28946-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286020455-28946-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add MMC runtime PM handlers, which call mmc_power_save_host
and mmc_power_restore_host in response to runtime_suspend and
runtime_resume events.

Runtime PM is still disabled by default, so this patch alone
has no immediate effect.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/core/bus.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index da3c01b..af8dc6a 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -141,6 +142,41 @@ static int mmc_bus_resume(struct device *dev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+
+static int mmc_runtime_suspend(struct device *dev)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	return mmc_power_save_host(card->host);
+}
+
+static int mmc_runtime_resume(struct device *dev)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	return mmc_power_restore_host(card->host);
+}
+
+static int mmc_runtime_idle(struct device *dev)
+{
+	return pm_runtime_suspend(dev);
+}
+
+static const struct dev_pm_ops mmc_bus_pm_ops = {
+	.runtime_suspend	= mmc_runtime_suspend,
+	.runtime_resume		= mmc_runtime_resume,
+	.runtime_idle		= mmc_runtime_idle,
+};
+
+#define MMC_PM_OPS_PTR	(&mmc_bus_pm_ops)
+
+#else /* !CONFIG_PM_RUNTIME */
+
+#define MMC_PM_OPS_PTR	NULL
+
+#endif /* !CONFIG_PM_RUNTIME */
+
 static struct bus_type mmc_bus_type = {
 	.name		= "mmc",
 	.dev_attrs	= mmc_dev_attrs,
@@ -150,6 +186,7 @@ static struct bus_type mmc_bus_type = {
 	.remove		= mmc_bus_remove,
 	.suspend	= mmc_bus_suspend,
 	.resume		= mmc_bus_resume,
+	.pm		= MMC_PM_OPS_PTR,
 };
 
 int mmc_register_bus(void)
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
