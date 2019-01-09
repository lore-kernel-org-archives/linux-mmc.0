From: wangbo <wdjjwb@163.com>
Subject: [PATCH] mmc:sdio: Remove unneeded variable ret
Date: Wed,  9 Jan 2019 20:10:33 +0800
Message-ID: <1547035833-3924-1-git-send-email-wdjjwb@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, wang.bo116@zte.com.cn
List-Id: linux-mmc@vger.kernel.org

In sdio_bus_remove the variable is unneeded,remove it now.

Signed-off-by: wangbo <wang.bo116@zte.com.cn>
---
 drivers/mmc/core/sdio_bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index b6d8203..62b0f5e 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -179,7 +179,6 @@ static int sdio_bus_remove(struct device *dev)
 {
 	struct sdio_driver *drv = to_sdio_driver(dev->driver);
 	struct sdio_func *func = dev_to_sdio_func(dev);
-	int ret = 0;
 
 	/* Make sure card is powered before invoking ->remove() */
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
@@ -205,7 +204,7 @@ static int sdio_bus_remove(struct device *dev)
 
 	dev_pm_domain_detach(dev, false);
 
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.7.4
