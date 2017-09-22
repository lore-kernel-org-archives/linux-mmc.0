From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 1/4] mmc-host: wbsd: use setup_timer() helper.
Date: Fri, 22 Sep 2017 17:37:23 +0530
Message-ID: <1506082046-6878-2-git-send-email-allen.lkml@gmail.com>
References: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34471 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbdIVMHh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 08:07:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id g65so388464pfe.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2017 05:07:37 -0700 (PDT)
In-Reply-To: <1506082046-6878-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: brucechang@via.com.tw, tony.olech@elandigitalsystems.com, pierre@ossman.eu, linux-mmc@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>

   Use setup_timer function instead of initializing timer with the
   function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/mmc/host/wbsd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 546aaf8..499852d 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -1224,9 +1224,8 @@ static int wbsd_alloc_mmc(struct device *dev)
 	/*
 	 * Set up timers
 	 */
-	init_timer(&host->ignore_timer);
-	host->ignore_timer.data = (unsigned long)host;
-	host->ignore_timer.function = wbsd_reset_ignore;
+	setup_timer(&host->ignore_timer, wbsd_reset_ignore,
+		    (unsigned long)host);
 
 	/*
 	 * Maximum number of segments. Worst case is one sector per segment
-- 
2.7.4

