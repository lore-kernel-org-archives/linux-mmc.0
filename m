From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] mmc: Remove redundant null check before kfree in sdio_bus.c
Date: Tue, 20 Nov 2012 14:43:16 +0530
Message-ID: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58140 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2KTJT1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 04:19:27 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1160372dak.19
        for <linux-mmc@vger.kernel.org>; Tue, 20 Nov 2012 01:19:27 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

kfree on a null pointer is a no-op.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/core/sdio_bus.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 6bf6879..fdcf9e3 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -258,8 +258,7 @@ static void sdio_release_func(struct device *dev)
 
 	sdio_free_func_cis(func);
 
-	if (func->info)
-		kfree(func->info);
+	kfree(func->info);
 
 	kfree(func);
 }
-- 
1.7.4.1

