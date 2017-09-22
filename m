From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 4/4] mmc-host: mxcmmc: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:37:26 +0530
Message-ID: <1506082046-6878-5-git-send-email-allen.lkml@gmail.com>
References: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38690 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdIVMHr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 08:07:47 -0400
Received: by mail-pg0-f67.google.com with SMTP id m30so521030pgn.5
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 05:07:47 -0700 (PDT)
In-Reply-To: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: brucechang@via.com.tw, tony.olech@elandigitalsystems.com, pierre@ossman.eu, linux-mmc@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/mmc/host/mxcmmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 1d5418e..328484b 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1165,9 +1165,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 			goto out_free_dma;
 	}
 
-	init_timer(&host->watchdog);
-	host->watchdog.function = &mxcmci_watchdog;
-	host->watchdog.data = (unsigned long)mmc;
+	setup_timer(&host->watchdog, &mxcmci_watchdog, (unsigned long)mmc);
 
 	mmc_add_host(mmc);
 
-- 
2.7.4

