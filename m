From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: slot-gpio: Fix missing assignment to ctx->ro_gpio
Date: Sat, 08 Sep 2012 23:00:01 -0400
Message-ID: <87pq5vzyry.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39827 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2IIDAN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 8 Sep 2012 23:00:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

mmc_gpio_request_ro() doesn't store the requested gpio in ctx->ro_gpio.
As a result, subsequent calls to mmc_gpio_get_ro() will always fail
with -ENOSYS because the gpio number isn't available to that function.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/slot-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 0582429..4f9b366 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -99,6 +99,7 @@ int mmc_gpio_request_ro(struct mmc_host *host, unsigned int gpio)
 		return ret;
 
 	ctx = host->slot.handler_priv;
+	ctx->ro_gpio = gpio;
 
 	return gpio_request_one(gpio, GPIOF_DIR_IN, ctx->ro_label);
 }
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
