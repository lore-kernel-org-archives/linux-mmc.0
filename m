From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4] mmc: host: switch OF parser to use gpio descriptors
Date: Tue, 12 Aug 2014 19:25:54 +0200
Message-ID: <1407864355-21545-3-git-send-email-linus.walleij@linaro.org>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This switches the central MMC OF parser to use gpio descriptors
instead of grabbing GPIOs explicitly from the device tree.
This strips out an unecessary use of the integer-based GPIO
API that we want to get rid of, cuts down on code as the
gpio descriptor code will handle active low flags.

As it is in no way a bug not to supply CD/WP GPIOs the messages
about them not being specified have been depromoted from
dev_err() to dev_dbg().

Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/host.c | 68 +++++++++++++++----------------------------------
 1 file changed, 21 insertions(+), 47 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 95cceae96944..048c6d687cc9 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -310,9 +310,7 @@ int mmc_of_parse(struct mmc_host *host)
 {
 	struct device_node *np;
 	u32 bus_width;
-	bool explicit_inv_wp, gpio_inv_wp = false;
-	enum of_gpio_flags flags;
-	int len, ret, gpio;
+	int len, ret;
 
 	if (!host->parent || !host->parent->of_node)
 		return 0;
@@ -360,60 +358,36 @@ int mmc_of_parse(struct mmc_host *host)
 	if (of_find_property(np, "non-removable", &len)) {
 		host->caps |= MMC_CAP_NONREMOVABLE;
 	} else {
-		bool explicit_inv_cd, gpio_inv_cd = false;
-
-		explicit_inv_cd = of_property_read_bool(np, "cd-inverted");
+		if (of_property_read_bool(np, "cd-inverted"))
+			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
 
 		if (of_find_property(np, "broken-cd", &len))
 			host->caps |= MMC_CAP_NEEDS_POLL;
 
-		gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
-		if (gpio == -EPROBE_DEFER)
-			return gpio;
-		if (gpio_is_valid(gpio)) {
-			if (!(flags & OF_GPIO_ACTIVE_LOW))
-				gpio_inv_cd = true;
-
-			ret = mmc_gpio_request_cd(host, gpio, 0);
-			if (ret < 0) {
-				dev_err(host->parent,
-					"Failed to request CD GPIO #%d: %d!\n",
-					gpio, ret);
+		ret = mmc_gpiod_request_cd(host, "cd", 0, false, 0);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
 				return ret;
-			} else {
-				dev_info(host->parent, "Got CD GPIO #%d.\n",
-					 gpio);
-			}
-		}
-
-		if (explicit_inv_cd ^ gpio_inv_cd)
-			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+			dev_dbg(host->parent,
+				"Failed to request CD GPIO: %d\n",
+				ret);
+		} else
+			dev_info(host->parent, "Got CD GPIO\n");
 	}
 
 	/* Parse Write Protection */
-	explicit_inv_wp = of_property_read_bool(np, "wp-inverted");
+	if (of_property_read_bool(np, "wp-inverted"))
+		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
-	gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-	if (gpio == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out;
-	}
-	if (gpio_is_valid(gpio)) {
-		if (!(flags & OF_GPIO_ACTIVE_LOW))
-			gpio_inv_wp = true;
-
-		ret = mmc_gpio_request_ro(host, gpio);
-		if (ret < 0) {
-			dev_err(host->parent,
-				"Failed to request WP GPIO: %d!\n", ret);
+	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
 			goto out;
-		} else {
-				dev_info(host->parent, "Got WP GPIO #%d.\n",
-					 gpio);
-		}
-	}
-	if (explicit_inv_wp ^ gpio_inv_wp)
-		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+		dev_dbg(host->parent,
+			"Failed to request WP GPIO: %d\n",
+			ret);
+	} else
+		dev_info(host->parent, "Got WP GPIO\n");
 
 	if (of_find_property(np, "cap-sd-highspeed", &len))
 		host->caps |= MMC_CAP_SD_HIGHSPEED;
-- 
1.9.3

