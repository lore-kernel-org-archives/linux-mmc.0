From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 2/6] mmc: core: sdio_bus.c: Removed trailing whitespace error
Date: Fri, 19 Oct 2012 01:31:55 +0900
Message-ID: <1350577919-2750-2-git-send-email-antiroot@gmail.com>
References: <n>
 <1350577919-2750-1-git-send-email-antiroot@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350577919-2750-1-git-send-email-antiroot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul.gortmaker@windriver.com, stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, rjw@sisk.pl, girish.shivananjappa@linaro.org, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Removed the one unnecessary whitespace error from sdio_bus.c

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/sdio_bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 6bf6879..13146d2 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -105,7 +105,7 @@ sdio_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			"SDIO_CLASS=%02X", func->class))
 		return -ENOMEM;
 
-	if (add_uevent_var(env, 
+	if (add_uevent_var(env,
 			"SDIO_ID=%04X:%04X", func->vendor, func->device))
 		return -ENOMEM;
 
-- 
1.7.9.5
