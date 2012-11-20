From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/2] mmc: Remove redundant null check before kfree in bus.c
Date: Tue, 20 Nov 2012 14:43:17 +0530
Message-ID: <1353402797-6785-2-git-send-email-sachin.kamat@linaro.org>
References: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:58140 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab2KTJTa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Nov 2012 04:19:30 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1160372dak.19
        for <linux-mmc@vger.kernel.org>; Tue, 20 Nov 2012 01:19:30 -0800 (PST)
In-Reply-To: <1353402797-6785-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org, patches@linaro.org

kfree on a null pointer is a no-op.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/core/bus.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 9b68933..420cb67 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -225,8 +225,7 @@ static void mmc_release_card(struct device *dev)
 
 	sdio_free_common_cis(card);
 
-	if (card->info)
-		kfree(card->info);
+	kfree(card->info);
 
 	kfree(card);
 }
-- 
1.7.4.1

