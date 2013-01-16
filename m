From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 03/11] mmc: provide a standard MMC device-tree binding parser centrally
Date: Wed, 16 Jan 2013 17:54:38 +0100
Message-ID: <1358355286-26029-4-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61253 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757929Ab3APQyt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 11:54:49 -0500
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

MMC defines a number of standard DT bindings. Having each driver parse
them individually adds code redundancy and is error prone. Provide a
standard function to unify the parsing. After all drivers are converted
to using it instead of their own parsers, this function can be integrated
into mmc_alloc_host().

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

MMC host drivers are welcome and encouraged to use this helper function:-)

 drivers/mmc/core/host.c  |   82 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ee2e16b..e4c1cbd 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -15,6 +15,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idr.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/pagemap.h>
 #include <linux/export.h>
 #include <linux/leds.h>
@@ -23,6 +25,7 @@
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "core.h"
 #include "host.h"
@@ -294,6 +297,85 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 
 #endif
 
+void mmc_of_parse(struct mmc_host *host)
+{
+	struct device_node *np;
+	u32 bus_width;
+	bool legacy_inv_cd, legacy_inv_wp;
+	enum of_gpio_flags flags;
+	int len, ret, gpio;
+
+	if (!host->parent || !host->parent->of_node)
+		return;
+
+	np = host->parent->of_node;
+
+	/* Both CD and WP pins are by default active low */
+
+	legacy_inv_cd = !!of_find_property(np, "cd-inverted", &len);
+	legacy_inv_wp = !!of_find_property(np, "wp-inverted", &len);
+
+	if (legacy_inv_cd || legacy_inv_wp)
+		dev_warn(host->parent,
+			 "\"cd-/wp-inverted\" properties are deprecated, use GPIO flags");
+
+	if (of_property_read_u32_array(np, "bus-width", &bus_width, 1) < 0) {
+		dev_err(host->parent,
+			"Compulsory \"bus-width\" property is missing!\n");
+		return;
+	}
+
+	switch (bus_width) {
+	case 8:
+		host->caps |= MMC_CAP_8_BIT_DATA;
+		/* Hosts, capable of 8-bit transfers can also do 4 bits */
+	case 4:
+		host->caps |= MMC_CAP_4_BIT_DATA;
+		break;
+	case 1:
+		break;
+	default:
+		dev_err(host->parent,
+			"Invalid \"bus-width\" value %ud!\n", bus_width);
+	}
+
+	/* Optional property: ignore errors */
+	of_property_read_u32_array(np, "max-frequency", &host->f_max, 1);
+
+	if (of_find_property(np, "non-removable", &len)) {
+		host->caps |= MMC_CAP_NONREMOVABLE;
+	} else {
+		if (of_find_property(np, "broken-cd", &len))
+			host->caps |= MMC_CAP_NEEDS_POLL;
+
+		gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
+		if (gpio_is_valid(gpio)) {
+			if (legacy_inv_cd || !(flags & OF_GPIO_ACTIVE_LOW))
+				host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+			ret = mmc_gpio_request_cd(host, gpio);
+			if (ret < 0)
+				dev_err(host->parent,
+					"Failed to request CD GPIO #%d: %d!\n",
+					gpio, ret);
+			else
+				dev_info(host->parent, "Got CD GPIO #%d.\n",
+					 gpio);
+		}
+	}
+
+	gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
+	if (gpio_is_valid(gpio)) {
+		if (legacy_inv_wp || !(flags & OF_GPIO_ACTIVE_LOW))
+			host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+		ret = mmc_gpio_request_ro(host, gpio);
+		if (ret < 0)
+			dev_err(host->parent,
+				"Failed to request WP GPIO: %d!\n", ret);
+	}
+}
+
+EXPORT_SYMBOL(mmc_of_parse);
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 61a10c1..13c0c8d 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -345,6 +345,7 @@ extern struct mmc_host *mmc_alloc_host(int extra, struct device *);
 extern int mmc_add_host(struct mmc_host *);
 extern void mmc_remove_host(struct mmc_host *);
 extern void mmc_free_host(struct mmc_host *);
+void mmc_of_parse(struct mmc_host *host);
 
 static inline void *mmc_priv(struct mmc_host *host)
 {
-- 
1.7.2.5

