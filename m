From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: tmio: Remove redundant check of mmc->slot.cd_irq
Date: Tue, 10 Jan 2017 16:10:52 +0100
Message-ID: <1484061052-25334-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34285 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965013AbdAJPLK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:11:10 -0500
Received: by mail-lf0-f43.google.com with SMTP id v186so63171502lfa.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:11:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

To validate whether native hotplug needs to be used, the tmio driver checks
whether the mmc->slot.cd_irq has been successfully assigned.

This check is redundant at its current place in tmio_mmc_host_probe(), as
the mmc core assigns mmc->slot.cd_irq a valid value first when
mmc_gpiod_request_cd_irq() is called. Therefore, let's just remove the
check for now, as that also removes a layering violation of the tmio driver
accessing core specific data via ->slot.cd_irq.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/tmio_mmc_pio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 3ca97f3..0ef5780 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1177,8 +1177,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-				  !mmc_card_is_removable(mmc) ||
-				  mmc->slot.cd_irq >= 0);
+				  !mmc_card_is_removable(mmc));
 
 	/*
 	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
-- 
1.9.1

