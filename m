From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/4] mmc: slot-gpio: switch to use flags when getting GPIO
Date: Tue, 12 Aug 2014 19:25:52 +0200
Message-ID: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:57156 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbaHLR0P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 13:26:15 -0400
Received: by mail-we0-f175.google.com with SMTP id t60so10314543wes.20
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 10:26:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

When the slot GPIO driver gets the GPIO to be used for card
detect, it is now possible to specify a flag to have the line
set up as input. Get rid of the explicit setup call for input
and use the flag.

The extra argument works as there are transition varargs
macros in place in the <linux/gpio/consumer.h> header, in
the future we will make the flags argument compulsory.

Cc: Alexandre Courbot <gnurou@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/core/slot-gpio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 5f89cb83d5f0..908c2b29e79f 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -308,14 +308,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 	if (!con_id)
 		con_id = ctx->cd_label;
 
-	desc = devm_gpiod_get_index(host->parent, con_id, idx);
+	desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
-	ret = gpiod_direction_input(desc);
-	if (ret < 0)
-		return ret;
-
 	if (debounce) {
 		ret = gpiod_set_debounce(desc, debounce);
 		if (ret < 0)
-- 
1.9.3

