From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 2/2 v2] mmc: add a generic GPIO card-detect helper
Date: Sun, 25 Dec 2011 21:36:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112252129530.22951@axis700.grange>
References: <Pine.LNX.4.64.1112232346180.1911@axis700.grange>
 <Pine.LNX.4.64.1112232358100.1911@axis700.grange> <m2pqfdxthz.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58221 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1LYUgE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Dec 2011 15:36:04 -0500
In-Reply-To: <m2pqfdxthz.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

This patch adds a primitive helper to support card hotplug detection on
platforms, where a GPIO, capable of producing interrupts, is used for
detection of card-insertion and -removal events.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: switch to use snprintf()

Hi Chris

On Sat, 24 Dec 2011, Chris Ball wrote:

> > +int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio,
> > +			unsigned int irq, unsigned long flags)
> > +{
> > +	size_t len = strlen(dev_name(host->parent)) + 4;
> > +	struct mmc_cd_gpio *cd = kmalloc(sizeof(*cd) + len, GFP_KERNEL);
> > +	int ret;
> > +
> > +	if (!cd)
> > +		return -ENOMEM;
> > +
> > +	sprintf(cd->label, "%s cd", dev_name(host->parent));
> 
> Mind using snprintf() instead?  I prefer it for new uses, it leaves
> fewer uses of sprintf to audit for correctness.

I don't think it's needed here - I allocate exactly the required number of 
bytes, but, as you mention, it should help us, humans, feel more secure 
about it:-)

 drivers/mmc/core/Makefile   |    2 +-
 drivers/mmc/core/cd-gpio.c  |   74 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/cd-gpio.h |   19 +++++++++++
 3 files changed, 94 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mmc/core/cd-gpio.c
 create mode 100644 include/linux/mmc/cd-gpio.h

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 6395019..dca4428 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -7,6 +7,6 @@ mmc_core-y			:= core.o bus.o host.o \
 				   mmc.o mmc_ops.o sd.o sd_ops.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
-				   quirks.o
+				   quirks.o cd-gpio.o
 
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
new file mode 100644
index 0000000..4c79f0c
--- /dev/null
+++ b/drivers/mmc/core/cd-gpio.c
@@ -0,0 +1,74 @@
+/*
+ * Generic GPIO card-detect helper
+ *
+ * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+struct mmc_cd_gpio {
+	unsigned int gpio;
+	char label[0];
+};
+
+static irqreturn_t mmc_cd_gpio_irqt(int irq, void *dev_id)
+{
+	/* Schedule a card detection after a debounce timeout */
+	mmc_detect_change(dev_id, msecs_to_jiffies(100));
+	return IRQ_HANDLED;
+}
+
+int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio,
+			unsigned int irq, unsigned long flags)
+{
+	size_t len = strlen(dev_name(host->parent)) + 4;
+	struct mmc_cd_gpio *cd = kmalloc(sizeof(*cd) + len, GFP_KERNEL);
+	int ret;
+
+	if (!cd)
+		return -ENOMEM;
+
+	snprintf(cd->label, len, "%s cd", dev_name(host->parent));
+
+	ret = gpio_request_one(gpio, GPIOF_DIR_IN, cd->label);
+	if (ret < 0)
+		goto egpioreq;
+
+	ret = request_threaded_irq(irq, NULL, mmc_cd_gpio_irqt,
+				   flags, cd->label, host);
+	if (ret < 0)
+		goto eirqreq;
+
+	cd->gpio = gpio;
+	host->hotplug.irq = irq;
+	host->hotplug.handler_priv = cd;
+
+	return 0;
+
+eirqreq:
+	gpio_free(gpio);
+egpioreq:
+	kfree(cd);
+	return ret;
+}
+EXPORT_SYMBOL(mmc_cd_gpio_request);
+
+void mmc_cd_gpio_free(struct mmc_host *host)
+{
+	struct mmc_cd_gpio *cd = host->hotplug.handler_priv;
+
+	free_irq(host->hotplug.irq, host);
+	gpio_free(cd->gpio);
+	kfree(cd);
+}
+EXPORT_SYMBOL(mmc_cd_gpio_free);
diff --git a/include/linux/mmc/cd-gpio.h b/include/linux/mmc/cd-gpio.h
new file mode 100644
index 0000000..a8e4697
--- /dev/null
+++ b/include/linux/mmc/cd-gpio.h
@@ -0,0 +1,19 @@
+/*
+ * Generic GPIO card-detect helper header
+ *
+ * Copyright (C) 2011, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MMC_CD_GPIO_H
+#define MMC_CD_GPIO_H
+
+struct mmc_host;
+int mmc_cd_gpio_request(struct mmc_host *host, unsigned int gpio,
+			unsigned int irq, unsigned long flags);
+void mmc_cd_gpio_free(struct mmc_host *host);
+
+#endif
-- 
1.7.2.5

