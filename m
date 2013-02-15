From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v4 03/13] mmc: provide a standard MMC device-tree binding parser centrally
Date: Fri, 15 Feb 2013 16:13:52 +0100
Message-ID: <1360941242-18153-4-git-send-email-g.liakhovetski@gmx.de>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58399 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935752Ab3BOPOt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Feb 2013 10:14:49 -0500
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Markus Pargmann <mpa@pengutronix.de>

MMC defines a number of standard DT bindings. Having each driver parse
them individually adds code redundancy and is error prone. Provide a
standard function to unify the parsing. After all drivers are converted
to using it instead of their own parsers, this function can be integrated
into mmc_alloc_host().

Cc: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v4: make the bus-width property optional to match a recent change to 
mmc.txt, use of_property_read_bool() to obtain a boolean value of a DT 
property, add comments.

 drivers/mmc/core/host.c  |  108 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ee2e16b..daa2ed1 100644
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
@@ -295,6 +298,111 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 #endif
 
 /**
+ *	mmc_of_parse() - parse host's device-tree node
+ *	@host: host, whose node should be parsed.
+ *
+ * To keep the rest of the MMC subsystem unaware of the fact, whether DT has
+ * been used to to instantiate and configure this host instance or not, we
+ * parse the properties and set respective generic mmc-host flags and
+ * parameters.
+ */
+void mmc_of_parse(struct mmc_host *host)
+{
+	struct device_node *np;
+	u32 bus_width;
+	bool explicit_inv_wp, gpio_inv_wp = false;
+	enum of_gpio_flags flags;
+	int len, ret, gpio;
+
+	if (!host->parent || !host->parent->of_node)
+		return;
+
+	np = host->parent->of_node;
+
+	/* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
+	if (of_property_read_u32_array(np, "bus-width", &bus_width, 1) < 0)
+		dev_dbg(host->parent,
+			"\"bus-width\" property is missing, assuming 1 bit.\n");
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
+	/* f_max is obtained from the optional "max-frequency" property */
+	of_property_read_u32_array(np, "max-frequency", &host->f_max, 1);
+
+	/*
+	 * Configure CD and WP pins. They are both by default active low to
+	 * match the SDHCI spec. If GPIOs are provided for CD and / or WP, the
+	 * mmc-gpio helpers are used to attach, configure and use them. If
+	 * polarity inversion is specified in DT, one of MMC_CAP2_CD_ACTIVE_HIGH
+	 * and MMC_CAP2_RO_ACTIVE_HIGH capability-2 flags is set. If the
+	 * "broken-cd" property is provided, the MMC_CAP_NEEDS_POLL capability
+	 * is set. If the "non-removable" property is found, the
+	 * MMC_CAP_NONREMOVABLE capability is set and no card-detection
+	 * configuration is performed.
+	 */
+
+	/* Parse Card Detection */
+	if (of_find_property(np, "non-removable", &len)) {
+		host->caps |= MMC_CAP_NONREMOVABLE;
+	} else {
+		bool explicit_inv_cd, gpio_inv_cd = false;
+
+		explicit_inv_cd = of_property_read_bool(np, "cd-inverted");
+
+		if (of_find_property(np, "broken-cd", &len))
+			host->caps |= MMC_CAP_NEEDS_POLL;
+
+		gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
+		if (gpio_is_valid(gpio)) {
+			if (!(flags & OF_GPIO_ACTIVE_LOW))
+				gpio_inv_cd = true;
+
+			ret = mmc_gpio_request_cd(host, gpio);
+			if (ret < 0)
+				dev_err(host->parent,
+					"Failed to request CD GPIO #%d: %d!\n",
+					gpio, ret);
+			else
+				dev_info(host->parent, "Got CD GPIO #%d.\n",
+					 gpio);
+		}
+
+		if (explicit_inv_cd ^ gpio_inv_cd)
+			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+	}
+
+	/* Parse Write Protection */
+	explicit_inv_wp = of_property_read_bool(np, "wp-inverted");
+
+	gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
+	if (gpio_is_valid(gpio)) {
+		if (!(flags & OF_GPIO_ACTIVE_LOW))
+			gpio_inv_wp = true;
+
+		ret = mmc_gpio_request_ro(host, gpio);
+		if (ret < 0)
+			dev_err(host->parent,
+				"Failed to request WP GPIO: %d!\n", ret);
+	}
+	if (explicit_inv_wp ^ gpio_inv_wp)
+		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+}
+
+EXPORT_SYMBOL(mmc_of_parse);
+
+/**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
  *	@dev: pointer to host device model structure
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

