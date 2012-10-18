From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 6/6] mmc: core: sdio_bus.c: Removed unnecessary NULL check routine
Date: Fri, 19 Oct 2012 01:58:23 +0900
Message-ID: <1350579503-3100-6-git-send-email-antiroot@gmail.com>
References: <n>
 <1350579503-3100-1-git-send-email-antiroot@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350579503-3100-1-git-send-email-antiroot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul.gortmaker@windriver.com, stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, rjw@sisk.pl, girish.shivananjappa@linaro.org, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>
List-Id: linux-mmc@vger.kernel.org

kfree(something) is safe function, so I removed the NULL check routine
for the input of kfree.

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/sdio_bus.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index e5b7197..cf02146 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -259,8 +259,7 @@ static void sdio_release_func(struct device *dev)
 
 	sdio_free_func_cis(func);
 
-	if (func->info)
-		kfree(func->info);
+	kfree(func->info);
 
 	kfree(func);
 }
-- 
1.7.9.5
