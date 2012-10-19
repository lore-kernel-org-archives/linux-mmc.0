From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 1/2] mmc: core: bus.c: removed unnecessary NULL check for kfree(...)
Date: Fri, 19 Oct 2012 22:58:57 +0900
Message-ID: <1350655138-2252-1-git-send-email-antiroot@gmail.com>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38868 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab2JSN7S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Oct 2012 09:59:18 -0400
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: prakity@nvidia.com, aaron.lu@amd.com, linus.walleij@linaro.org, paul.gortmaker@windriver.com, chuanxiao.dong@intel.com, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>

kfree(NULL) is safe so I removed the if statements for NULL check.

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/bus.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

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
1.7.9.5

