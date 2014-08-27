From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/4 v2] mmc: host: switch OF parser to use gpio descriptors
Date: Wed, 27 Aug 2014 13:00:52 +0200
Message-ID: <1409137253-25189-3-git-send-email-linus.walleij@linaro.org>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58516 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973AbaH0LBJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Aug 2014 07:01:09 -0400
Received: by mail-wi0-f169.google.com with SMTP id n3so6467441wiv.4
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2014 04:01:06 -0700 (PDT)
In-Reply-To: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

This switches the central MMC OF parser to use gpio descriptors
instead of grabbing GPIOs explicitly from the device tree.
This strips out an unecessary use of the integer-based GPIO
API that we want to get rid of, cuts down on code as the
gpio descriptor code will handle active low flags.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Restore error reporting as done in previous stand-alone
  patch.
---
 drivers/mmc/core/host.c | 68 +++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 95cceae96944..6f7ed9c50346 100644
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
@@ -360,60 +358,40 @@ int mmc_of_parse(struct mmc_host *host)
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
+			if (ret != -ENOENT) {
+				dev_err(host->parent,
+					"Failed to request CD GPIO: %d\n",
+					ret);
 			}
-		}
-
-		if (explicit_inv_cd ^ gpio_inv_cd)
-			host->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+		} else
+			dev_info(host->parent, "Got CD GPIO\n");
 	}
 
 	/* Parse Write Protection */
-	explicit_inv_wp = of_property_read_bool(np, "wp-inverted");
-
-	gpio = of_get_named_gpio_flags(np, "wp-gpios", 0, &flags);
-	if (gpio == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out;
-	}
-	if (gpio_is_valid(gpio)) {
-		if (!(flags & OF_GPIO_ACTIVE_LOW))
-			gpio_inv_wp = true;
+	if (of_property_read_bool(np, "wp-inverted"))
+		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
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
+		if (ret != -ENOENT) {
+			dev_err(host->parent,
+				"Failed to request WP GPIO: %d\n",
+				ret);
 		}
-	}
-	if (explicit_inv_wp ^ gpio_inv_wp)
-		host->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
+	} else
+		dev_info(host->parent, "Got WP GPIO\n");
 
 	if (of_find_property(np, "cap-sd-highspeed", &len))
 		host->caps |= MMC_CAP_SD_HIGHSPEED;
-- 
1.9.3

