From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Mon, 19 Jan 2015 10:13:01 +0100
Message-ID: <1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55830 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbbASJQO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jan 2015 04:16:14 -0500
Received: by mail-lb0-f173.google.com with SMTP id p9so3760588lbv.4
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jan 2015 01:16:12 -0800 (PST)
In-Reply-To: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>

System on chip designs may specify a specific MMC power sequence. To
successfully detect an (e)MMC/SD/SDIO card, that power sequence must
be followed while initializing the card.

To be able to handle these SOC specific power sequences, let's add a
MMC power sequence interface. It provides the following functions to
help the mmc core to deal with these power sequences.

mmc_pwrseq_alloc() - Invoked from mmc_of_parse(), to initialize data.
mmc_pwrseq_pre_power_on()- Invoked in the beginning of mmc_power_up().
mmc_pwrseq_post_power_on()- Invoked at the end in mmc_power_up().
mmc_pwrseq_power_off()- Invoked from mmc_power_off().
mmc_pwrseq_free() - Invoked from mmc_free_host(), to free data.

Each MMC power sequence provider will be responsible to implement a set
of callbacks. These callbacks mirrors the functions above.

This patch adds the skeleton, following patches will extend the core of
the MMC power sequence and add support for a specific simple MMC power
sequence.

Do note, since the mmc_pwrseq_alloc() is invoked from mmc_of_parse(),
host drivers needs to make use of this API to enable the support for
MMC power sequences. Moreover the MMC power sequence support depends on
CONFIG_OF.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- None.

---
 drivers/mmc/core/Makefile |  2 +-
 drivers/mmc/core/core.c   |  7 +++++++
 drivers/mmc/core/host.c   |  4 +++-
 drivers/mmc/core/pwrseq.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/pwrseq.h | 40 +++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h  |  2 ++
 6 files changed, 103 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/core/pwrseq.c
 create mode 100644 drivers/mmc/core/pwrseq.h

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index 38ed210..ccdd35f 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,5 +8,5 @@ mmc_core-y			:= core.o bus.o host.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
 				   quirks.o slot-gpio.o
-
+mmc_core-$(CONFIG_OF)		+= pwrseq.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d5c176e..1be7055 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -40,6 +40,7 @@
 #include "bus.h"
 #include "host.h"
 #include "sdio_bus.h"
+#include "pwrseq.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -1615,6 +1616,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 
 	mmc_host_clk_hold(host);
 
+	mmc_pwrseq_pre_power_on(host);
+
 	host->ios.vdd = fls(ocr) - 1;
 	host->ios.power_mode = MMC_POWER_UP;
 	/* Set initial state and call mmc_set_ios */
@@ -1645,6 +1648,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 */
 	mmc_delay(10);
 
+	mmc_pwrseq_post_power_on(host);
+
 	mmc_host_clk_release(host);
 }
 
@@ -1655,6 +1660,8 @@ void mmc_power_off(struct mmc_host *host)
 
 	mmc_host_clk_hold(host);
 
+	mmc_pwrseq_power_off(host);
+
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0763644..8be0df7 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -30,6 +30,7 @@
 #include "core.h"
 #include "host.h"
 #include "slot-gpio.h"
+#include "pwrseq.h"
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
@@ -448,7 +449,7 @@ int mmc_of_parse(struct mmc_host *host)
 		host->dsr_req = 0;
 	}
 
-	return 0;
+	return mmc_pwrseq_alloc(host);
 }
 
 EXPORT_SYMBOL(mmc_of_parse);
@@ -588,6 +589,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
 
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
new file mode 100644
index 0000000..bd08772
--- /dev/null
+++ b/drivers/mmc/core/pwrseq.c
@@ -0,0 +1,50 @@
+/*
+ *  Copyright (C) 2014 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ *  MMC power sequence management
+ */
+#include <linux/mmc/host.h>
+
+#include "pwrseq.h"
+
+
+int mmc_pwrseq_alloc(struct mmc_host *host)
+{
+	return 0;
+}
+
+void mmc_pwrseq_pre_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops && pwrseq->ops->pre_power_on)
+		pwrseq->ops->pre_power_on(host);
+}
+
+void mmc_pwrseq_post_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops && pwrseq->ops->post_power_on)
+		pwrseq->ops->post_power_on(host);
+}
+
+void mmc_pwrseq_power_off(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops && pwrseq->ops->power_off)
+		pwrseq->ops->power_off(host);
+}
+
+void mmc_pwrseq_free(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops && pwrseq->ops->free)
+		pwrseq->ops->free(host);
+}
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
new file mode 100644
index 0000000..12aaf2b
--- /dev/null
+++ b/drivers/mmc/core/pwrseq.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef _MMC_CORE_PWRSEQ_H
+#define _MMC_CORE_PWRSEQ_H
+
+struct mmc_pwrseq_ops {
+	void (*pre_power_on)(struct mmc_host *host);
+	void (*post_power_on)(struct mmc_host *host);
+	void (*power_off)(struct mmc_host *host);
+	void (*free)(struct mmc_host *host);
+};
+
+struct mmc_pwrseq {
+	struct mmc_pwrseq_ops *ops;
+};
+
+#ifdef CONFIG_OF
+
+int mmc_pwrseq_alloc(struct mmc_host *host);
+void mmc_pwrseq_pre_power_on(struct mmc_host *host);
+void mmc_pwrseq_post_power_on(struct mmc_host *host);
+void mmc_pwrseq_power_off(struct mmc_host *host);
+void mmc_pwrseq_free(struct mmc_host *host);
+
+#else
+
+static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
+static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
+static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
+static inline void mmc_pwrseq_power_off(struct mmc_host *host) {}
+static inline void mmc_pwrseq_free(struct mmc_host *host) {}
+
+#endif
+
+#endif
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index b6bf718..0c8cbe5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -195,6 +195,7 @@ struct mmc_context_info {
 };
 
 struct regulator;
+struct mmc_pwrseq;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
@@ -206,6 +207,7 @@ struct mmc_host {
 	struct device		class_dev;
 	int			index;
 	const struct mmc_host_ops *ops;
+	struct mmc_pwrseq	*pwrseq;
 	unsigned int		f_min;
 	unsigned int		f_max;
 	unsigned int		f_init;
-- 
1.9.1

