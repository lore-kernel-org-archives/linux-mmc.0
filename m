From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH V3 3/4] mmc: pwrseq: Initial support for the simple MMC power sequence provider
Date: Fri, 16 Jan 2015 11:47:52 +0100
Message-ID: <1421405273-19117-4-git-send-email-ulf.hansson@linaro.org>
References: <1421405273-19117-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421405273-19117-1-git-send-email-ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

To add the core part for the MMC power sequence, let's start by adding
initial support for the simple MMC power sequence provider.

In this initial step, the MMC power sequence node are fetched and the
compatible string for the simple MMC power sequence provider are
verified.

At this point we don't parse the node for any properties, but instead
that will be handled from following patches. Since there are no
properties supported yet, let's just implement the ->alloc() and the
->free() callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Changes in v3:
	- Updated to use the new compatible string for the simple MMC power
	  sequence.

---
 drivers/mmc/core/Makefile        |  2 +-
 drivers/mmc/core/pwrseq.c        | 61 +++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/pwrseq.h        |  2 ++
 drivers/mmc/core/pwrseq_simple.c | 48 +++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mmc/core/pwrseq_simple.c

diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index ccdd35f..b39cbd2 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,5 +8,5 @@ mmc_core-y			:= core.o bus.o host.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
 				   quirks.o slot-gpio.o
-mmc_core-$(CONFIG_OF)		+= pwrseq.o
+mmc_core-$(CONFIG_OF)		+= pwrseq.o pwrseq_simple.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index bd08772..2cea00e 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -7,14 +7,73 @@
  *
  *  MMC power sequence management
  */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
 #include <linux/mmc/host.h>
 
 #include "pwrseq.h"
 
+struct mmc_pwrseq_match {
+	const char *compatible;
+	int (*alloc)(struct mmc_host *host, struct device *dev);
+};
+
+static struct mmc_pwrseq_match pwrseq_match[] = {
+	{
+		.compatible = "mmc-pwrseq-simple",
+		.alloc = mmc_pwrseq_simple_alloc,
+	},
+};
+
+static struct mmc_pwrseq_match *mmc_pwrseq_find(struct device_node *np)
+{
+	struct mmc_pwrseq_match *match = ERR_PTR(-ENODEV);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pwrseq_match); i++) {
+		if (of_device_is_compatible(np,	pwrseq_match[i].compatible)) {
+			match = &pwrseq_match[i];
+			break;
+		}
+	}
+
+	return match;
+}
 
 int mmc_pwrseq_alloc(struct mmc_host *host)
 {
-	return 0;
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct mmc_pwrseq_match *match;
+	int ret = 0;
+
+	np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
+	if (!np)
+		return 0;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	match = mmc_pwrseq_find(np);
+	if (IS_ERR(match)) {
+		ret = PTR_ERR(match);
+		goto err;
+	}
+
+	ret = match->alloc(host, &pdev->dev);
+	if (!ret)
+		dev_info(host->parent, "allocated mmc-pwrseq\n");
+
+err:
+	of_node_put(np);
+	return ret;
 }
 
 void mmc_pwrseq_pre_power_on(struct mmc_host *host)
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index 12aaf2b..bd860d8 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -27,6 +27,8 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host);
 void mmc_pwrseq_power_off(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
+int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev);
+
 #else
 
 static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
new file mode 100644
index 0000000..7f87bc1
--- /dev/null
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -0,0 +1,48 @@
+/*
+ *  Copyright (C) 2014 Linaro Ltd
+ *
+ * Author: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ *  Simple MMC power sequence management
+ */
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/err.h>
+
+#include <linux/mmc/host.h>
+
+#include "pwrseq.h"
+
+struct mmc_pwrseq_simple {
+	struct mmc_pwrseq pwrseq;
+};
+
+static void mmc_pwrseq_simple_free(struct mmc_host *host)
+{
+	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_simple, pwrseq);
+
+	kfree(&pwrseq);
+	host->pwrseq = NULL;
+}
+
+static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
+	.free = mmc_pwrseq_simple_free,
+};
+
+int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
+{
+	struct mmc_pwrseq_simple *pwrseq;
+
+	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
+	if (!pwrseq)
+		return -ENOMEM;
+
+	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
+	host->pwrseq = &pwrseq->pwrseq;
+
+	return 0;
+}
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
