From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] mmc: dw_mmc: Use pr_info instead of printk
Date: Thu, 28 Mar 2013 09:55:47 +0530
Message-ID: <1364444747-16777-2-git-send-email-sachin.kamat@linaro.org>
References: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:58771 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab3C1EhQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Mar 2013 00:37:16 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so5622542pbc.11
        for <linux-mmc@vger.kernel.org>; Wed, 27 Mar 2013 21:37:16 -0700 (PDT)
In-Reply-To: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: tgih.jun@samsung.com, jh80.chung@samsung.com, cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

pr_info(... is preferred to printk(KERN_INFO ...

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ba09d0..b8582d0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2509,7 +2509,7 @@ EXPORT_SYMBOL(dw_mci_resume);
 
 static int __init dw_mci_init(void)
 {
-	printk(KERN_INFO "Synopsys Designware Multimedia Card Interface Driver");
+	pr_info("Synopsys Designware Multimedia Card Interface Driver");
 	return 0;
 }
 
-- 
1.7.4.1

