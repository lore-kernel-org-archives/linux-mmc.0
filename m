From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 03/13] mmc: provide a standard MMC device-tree binding parser centrally
Date: Wed,  6 Feb 2013 20:46:50 +0100
Message-ID: <1360180020-18555-4-git-send-email-g.liakhovetski@gmx.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

MMC defines a number of standard DT bindings. Having each driver parse
them individually adds code redundancy and is error prone. Provide a
standard function to unify the parsing. After all drivers are converted
to using it instead of their own parsers, this function can be integrated
into mmc_alloc_host().

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: updated to match v3 of mmc.txt disambiguation in patch 02/13.

 drivers/mmc/core/host.c  |   90 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    1 +
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ee2e16b..c412612 100644
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
@@ -294,6 +297,93 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 
 #endif
 
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
+	/* Both CD and WP pins are by default active low */
+
+	/* Parse Card Detection */
+	if (of_find_property(np, "non-removable", &len)) {
+		host->caps |= MMC_CAP_NONREMOVABLE;
+	} else {
+		bool explicit_inv_cd, gpio_inv_cd = false;
+
+		explicit_inv_cd = !!of_find_property(np, "cd-inverted", &len);
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
+	explicit_inv_wp = !!of_find_property(np, "wp-inverted", &len);
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

