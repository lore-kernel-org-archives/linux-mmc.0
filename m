From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: slot-gpio: call gpiod_to_irq() only when MMC_CAP_NEEDS_POLL is unset
Date: Wed,  8 Nov 2017 15:34:54 +0900
Message-ID: <1510122894-9296-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:64401 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdKHGgJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Nov 2017 01:36:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>

It is not efficient to call gpiod_to_irq() regardless the flag, then
ignore the returned irq if MMC_CAP_NEEDS_POLL.

Move gpiod_to_irq() after the MMC_CAP_NEEDS_POLL check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/core/slot-gpio.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 863f1db..f7c6e05 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -121,20 +121,18 @@ EXPORT_SYMBOL(mmc_gpio_request_ro);
 void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
-	int ret, irq;
+	int irq = -EINVAL;
+	int ret;
 
 	if (host->slot.cd_irq >= 0 || !ctx || !ctx->cd_gpio)
 		return;
 
-	irq = gpiod_to_irq(ctx->cd_gpio);
-
 	/*
-	 * Even if gpiod_to_irq() returns a valid IRQ number, the platform might
-	 * still prefer to poll, e.g., because that IRQ number is already used
-	 * by another unit and cannot be shared.
+	 * Do not use IRQ if the platform prefers to poll, e.g., because that
+	 * IRQ number is already used by another unit and cannot be shared.
 	 */
-	if (irq >= 0 && host->caps & MMC_CAP_NEEDS_POLL)
-		irq = -EINVAL;
+	if (!(host->caps & MMC_CAP_NEEDS_POLL))
+		irq = gpiod_to_irq(ctx->cd_gpio);
 
 	if (irq >= 0) {
 		if (!ctx->cd_gpio_isr)
-- 
2.7.4

