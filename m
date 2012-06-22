From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/9 v4] mmc: use a more generic name for slot function types and fields
Date: Fri, 22 Jun 2012 15:23:15 +0200
Message-ID: <1340371402-4801-3-git-send-email-g.liakhovetski@gmx.de>
References: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50802 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762100Ab2FVNXn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 09:23:43 -0400
In-Reply-To: <1340371402-4801-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

struct mmc_host::hotplug is becoming a generic hook for slot functions.
Rename it accordingly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/core/host.c      |    2 ++
 drivers/mmc/core/slot-gpio.c |    8 ++++----
 include/linux/mmc/host.h     |   17 ++++++++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 91c84c7..b8c5290 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -327,6 +327,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	mmc_host_clk_init(host);
 
+	host->slot.cd_irq = -EINVAL;
+
 	spin_lock_init(&host->lock);
 	init_waitqueue_head(&host->wq);
 	INIT_DELAYED_WORK(&host->detect, mmc_rescan);
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 9796710..468e5a0 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -56,8 +56,8 @@ int mmc_gpio_request_cd(struct mmc_host *host, unsigned int gpio)
 		goto eirqreq;
 
 	ctx->cd_gpio = gpio;
-	host->hotplug.irq = irq;
-	host->hotplug.handler_priv = ctx;
+	host->slot.cd_irq = irq;
+	host->slot.handler_priv = ctx;
 
 	return 0;
 
@@ -71,12 +71,12 @@ EXPORT_SYMBOL(mmc_gpio_request_cd);
 
 void mmc_gpio_free_cd(struct mmc_host *host)
 {
-	struct mmc_gpio *ctx = host->hotplug.handler_priv;
+	struct mmc_gpio *ctx = host->slot.handler_priv;
 
 	if (!ctx)
 		return;
 
-	free_irq(host->hotplug.irq, host);
+	free_irq(host->slot.cd_irq, host);
 	gpio_free(ctx->cd_gpio);
 	kfree(ctx);
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9deb725..90b6a38 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -150,8 +150,19 @@ struct mmc_async_req {
 	int (*err_check) (struct mmc_card *, struct mmc_async_req *);
 };
 
-struct mmc_hotplug {
-	unsigned int irq;
+/**
+ * struct mmc_slot - MMC slot functions
+ *
+ * @cd_irq:		MMC/SD-card slot hotplug detection IRQ or -EINVAL
+ * @handler_priv:	MMC/SD-card slot context
+ *
+ * Some MMC/SD host controllers implement slot-functions like card and
+ * write-protect detection natively. However, a large number of controllers
+ * leave these functions to the CPU. This struct provides a hook to attach
+ * such slot-function drivers.
+ */
+struct mmc_slot {
+	int cd_irq;
 	void *handler_priv;
 };
 
@@ -297,7 +308,7 @@ struct mmc_host {
 
 	struct delayed_work	detect;
 	int			detect_change;	/* card detect flag */
-	struct mmc_hotplug	hotplug;
+	struct mmc_slot		slot;
 
 	const struct mmc_bus_ops *bus_ops;	/* current bus driver */
 	unsigned int		bus_refs;	/* reference counter */
-- 
1.7.2.5

