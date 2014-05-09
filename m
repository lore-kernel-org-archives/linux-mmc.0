From: Balaji T K <balajitk@ti.com>
Subject: [PATCH] mmc: core: Add DT bindings for card detect debounce time
Date: Fri, 9 May 2014 21:07:17 +0530
Message-ID: <1399649837-27286-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34497 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaEIPhY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 9 May 2014 11:37:24 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Balaji T K <balajitk@ti.com>

Provide an option to get CD debounce time from DT

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    1 +
 drivers/mmc/core/host.c                       |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540..fae590b 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -17,6 +17,7 @@ Optional properties:
 - bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
   will be <1> if the property is absent.
 - wp-gpios: Specify GPIOs for write protection, see gpio binding
+- cd-debounce-us: debounce time in microseconds for card detect gpio.
 - cd-inverted: when present, polarity on the CD line is inverted. See the note
   below for the case, when a GPIO is used for the CD line
 - wp-inverted: when present, polarity on the WP line is inverted. See the note
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index fdea825..59cd3a0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -313,6 +313,7 @@ int mmc_of_parse(struct mmc_host *host)
 	bool explicit_inv_wp, gpio_inv_wp = false;
 	enum of_gpio_flags flags;
 	int len, ret, gpio;
+	unsigned int debounce;
 
 	if (!host->parent || !host->parent->of_node)
 		return 0;
@@ -367,6 +368,9 @@ int mmc_of_parse(struct mmc_host *host)
 		if (of_find_property(np, "broken-cd", &len))
 			host->caps |= MMC_CAP_NEEDS_POLL;
 
+		if (of_property_read_u32(np, "cd-debounce-us", &debounce) < 0)
+			debounce = 0;
+
 		gpio = of_get_named_gpio_flags(np, "cd-gpios", 0, &flags);
 		if (gpio == -EPROBE_DEFER)
 			return gpio;
@@ -374,7 +378,7 @@ int mmc_of_parse(struct mmc_host *host)
 			if (!(flags & OF_GPIO_ACTIVE_LOW))
 				gpio_inv_cd = true;
 
-			ret = mmc_gpio_request_cd(host, gpio, 0);
+			ret = mmc_gpio_request_cd(host, gpio, debounce);
 			if (ret < 0) {
 				dev_err(host->parent,
 					"Failed to request CD GPIO #%d: %d!\n",
-- 
1.7.5.4

