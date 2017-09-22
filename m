From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 2/4] mmc-host: via: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:37:24 +0530
Message-ID: <1506082046-6878-3-git-send-email-allen.lkml@gmail.com>
References: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35766 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752408AbdIVMHk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 08:07:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id j16so526899pga.2
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 05:07:40 -0700 (PDT)
In-Reply-To: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: brucechang@via.com.tw, tony.olech@elandigitalsystems.com, pierre@ossman.eu, linux-mmc@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/mmc/host/via-sdmmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index a838bf5..a8c97b6 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1036,9 +1036,7 @@ static void via_init_mmc_host(struct via_crdr_mmc_host *host)
 	u32 lenreg;
 	u32 status;
 
-	init_timer(&host->timer);
-	host->timer.data = (unsigned long)host;
-	host->timer.function = via_sdc_timeout;
+	setup_timer(&host->timer, via_sdc_timeout, (unsigned long)host);
 
 	spin_lock_init(&host->lock);
 
-- 
2.7.4

