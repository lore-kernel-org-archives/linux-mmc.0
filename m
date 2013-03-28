From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 2/2] mmc: dw_mmc: Use pr_info instead of printk
Date: Thu, 28 Mar 2013 11:45:21 +0530
Message-ID: <1364451321-4383-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f42.google.com ([209.85.210.42]:54836 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab3C1G0r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Mar 2013 02:26:47 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so4405440dad.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2013 23:26:47 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

pr_info(... is preferred to printk(KERN_INFO ...

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ba09d0..870d311 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2509,7 +2509,7 @@ EXPORT_SYMBOL(dw_mci_resume);
 
 static int __init dw_mci_init(void)
 {
-	printk(KERN_INFO "Synopsys Designware Multimedia Card Interface Driver");
+	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
 	return 0;
 }
 
-- 
1.7.4.1

