From: behanw@converseincode.com
Subject: [PATCH v2 1/2] gpio, bcm-kona, LLVMLinux: Remove use of __initconst
Date: Tue, 23 Sep 2014 15:55:07 -0700
Message-ID: <1411512908-19237-1-git-send-email-behanw@converseincode.com>
References: <20140923212922.GG12270@beef>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:47646 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734AbaIWWzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Sep 2014 18:55:23 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so5535534pde.36
        for <linux-mmc@vger.kernel.org>; Tue, 23 Sep 2014 15:55:22 -0700 (PDT)
In-Reply-To: <20140923212922.GG12270@beef>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcm@fixthebug.org, chris@printf.net, gnurou@gmail.com, linus.walleij@linaro.org, mporter@linaro.org, ulf.hansson@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rjui@broadcom.com, Behan Webster <behanw@converseincode.com>

From: Behan Webster <behanw@converseincode.com>

The __initconst is in the wrong place, and when moved to the correct place
it uncovers an error where the variable is used by non-init data structures.

Instead merely make them const and put the const in the right spot.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Mark Charlebois <charlebm@gmail.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Matt Porter <mporter@linaro.org>
---
 drivers/gpio/gpio-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 3f6b33c..de0801e 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -496,7 +496,7 @@ static struct irq_chip bcm_gpio_irq_chip = {
 	.irq_release_resources = bcm_kona_gpio_irq_relres,
 };
 
-static struct __initconst of_device_id bcm_kona_gpio_of_match[] = {
+static struct of_device_id const bcm_kona_gpio_of_match[] = {
 	{ .compatible = "brcm,kona-gpio" },
 	{}
 };
-- 
1.9.1

