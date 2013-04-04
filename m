From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH v2 2/2] mmc: dw_mmc: Use pr_info instead of printk
Date: Thu,  4 Apr 2013 11:25:11 +0530
Message-ID: <1365054911-19928-2-git-send-email-sachin.kamat@linaro.org>
References: <1365054911-19928-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41674 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756261Ab3DDGHE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 02:07:04 -0400
Received: by mail-pb0-f50.google.com with SMTP id jt11so1262101pbb.37
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2013 23:07:03 -0700 (PDT)
In-Reply-To: <1365054911-19928-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

pr_info(... is preferred to printk(KERN_INFO ...

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
---
No change since v1
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4e3ebff..84f4464 100644
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
1.7.9.5

