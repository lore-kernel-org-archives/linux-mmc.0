From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: tmio: Use mmc_can_gpio_cd() when validating for native hotplug
Date: Fri, 30 Dec 2016 12:39:45 +0100
Message-ID: <1483097985-22446-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36708 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbcL3Lj7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 06:39:59 -0500
Received: by mail-lf0-f47.google.com with SMTP id t196so235990441lff.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 03:39:58 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

To validate whether native hotplug is intended to be used, the tmio driver
checks whether the GPIO isr has been successfully assigned. This isn't
entirely correct, as GPIO could still be used for card detect, but in a
polling mode.

Therefore, let's convert to use the correct mmc interface,
mmc_can_gpio_cd() as it tells exactly what we need for the native hotplug
validation.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 3ca97f3..580ca9c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1178,7 +1178,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc) ||
-				  mmc->slot.cd_irq >= 0);
+				  mmc_can_gpio_cd(mmc));
 
 	/*
 	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
-- 
1.9.1

