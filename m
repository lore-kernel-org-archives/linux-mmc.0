From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] mmc: core: Initial support for MMC power sequences
Date: Fri,  2 Jan 2015 17:14:05 +0100
Message-ID: <1420215248-20650-2-git-send-email-ulf.hansson@linaro.org>
References: <1420215248-20650-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420215248-20650-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

System on chip designs may specify a specific MMC power sequence. To
successfully detect an (e)MMC/SD/SDIO card, that power sequence must
be followed while initializing the card.

To be able to handle these SOC specific power sequences, let's add a
MMC power sequence interface. It provides the following functions to
help the mmc core to deal with these power sequences.

mmc_pwrseq_alloc() - Invoked from mmc_of_parse(), to initialize data.
mmc_pwrseq_power_up()- Invoked from mmc_power_up(), to power up.
mmc_pwrseq_power_on()- Invoked from mmc_power_up(), to power on.
mmc_pwrseq_power_off()- Invoked from mmc_power_off(), to power off.
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

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
index d3bfbdf..fd13649 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -40,6 +40,7 @@
 #include "bus.h"
 #include "host.h"
 #include "sdio_bus.h"
+#include "pwrseq.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
@@ -1583,6 +1584,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 
 	mmc_host_clk_hold(host);
 
+	mmc_pwrseq_power_up(host);
+
 	host->ios.vdd = fls(ocr) - 1;
 	host->ios.power_mode = MMC_POWER_UP;
 	/* Set initial state and call mmc_set_ios */
@@ -1602,6 +1605,8 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 */
 	mmc_delay(10);
 
+	mmc_pwrseq_power_on(host);
+
 	host->ios.clock = host->f_init;
 
 	host->ios.power_mode = MMC_POWER_ON;
@@ -1623,6 +1628,8 @@ void mmc_power_off(struct mmc_host *host)
 
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
index 0000000..24f2370
--- /dev/null
+++ b/drivers/mmc/core/pwrseq.c
@@ -0,0 +1,50 @@
+/*
+ *  Copyright (C) 2014 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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
+void mmc_pwrseq_power_up(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops && pwrseq->ops->power_up)
+		pwrseq->ops->power_up(host);
+}
+
+void mmc_pwrseq_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops && pwrseq->ops->power_on)
+		pwrseq->ops->power_on(host);
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
index 0000000..430874d
--- /dev/null
+++ b/drivers/mmc/core/pwrseq.h
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+#ifndef _MMC_CORE_PWRSEQ_H
+#define _MMC_CORE_PWRSEQ_H
+
+struct mmc_pwrseq_ops {
+	void (*power_up)(struct mmc_host *host);
+	void (*power_on)(struct mmc_host *host);
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
+void mmc_pwrseq_power_up(struct mmc_host *host);
+void mmc_pwrseq_power_on(struct mmc_host *host);
+void mmc_pwrseq_power_off(struct mmc_host *host);
+void mmc_pwrseq_free(struct mmc_host *host);
+
+#else
+
+static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
+static inline void mmc_pwrseq_power_up(struct mmc_host *host) {}
+static inline void mmc_pwrseq_power_on(struct mmc_host *host) {}
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
