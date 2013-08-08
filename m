From: "Christian Daudt" <csd@broadcom.com>
Subject: [PATCH] mmc: change mmc_gpio_get_cd to call non-sleep gpio
Date: Thu, 8 Aug 2013 13:47:34 -0700
Message-ID: <1375994855-12472-1-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:1482 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966546Ab3HHUrt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Aug 2013 16:47:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Christian Daudt <csd@broadcom.com>
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Given that mmc_gpio_get_cd can be called in softirq
context (by sdhci_tasklet_card -> sdhci_card_event ->
sdhci_do_get_cd -> mmc_gpio_get_cd ), it is necessary
for it to use gpio_get_value instead of
gpio_get_value_cansleep
Note that at present sdhci_card_event gets called both
from mmc_gpio_cd_irqt and sdhci_tasklet_card, and from
both it gets called immediately while the actual cd
processing is debounced to 200ms later. I think that
the better solution might be to move the sdhci_card_event
callback into mmc_rescan and remove it from its 2
present locations. That way the cd related callbacks
are aligned with the actual cd detection code. I can
submit a follow-up patch with these mods if that sounds
like a better way to solve this.

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 3242351..897b298 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -87,7 +87,7 @@ int mmc_gpio_get_cd(struct mmc_host *host)
 	if (!ctx || !gpio_is_valid(ctx->cd_gpio))
 		return -ENOSYS;
 
-	return !gpio_get_value_cansleep(ctx->cd_gpio) ^
+	return !gpio_get_value(ctx->cd_gpio) ^
 		!!(host->caps2 & MMC_CAP2_CD_ACTIVE_HIGH);
 }
 EXPORT_SYMBOL(mmc_gpio_get_cd);
-- 
1.7.10.4


