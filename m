From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/27] mmc: bfin_sdh: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:28 +0200
Message-ID: <1380207292-16968-4-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sonic Zhang <sonic.zhang@analog.com>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Sonic Zhang <sonic.zhang@analog.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/bfin_sdh.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 94fae2f..bc9110f 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -640,21 +640,15 @@ static int sdh_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int sdh_suspend(struct platform_device *dev, pm_message_t state)
 {
-	struct mmc_host *mmc = platform_get_drvdata(dev);
 	struct bfin_sd_host *drv_data = get_sdh_data(dev);
-	int ret = 0;
-
-	if (mmc)
-		ret = mmc_suspend_host(mmc);
 
 	peripheral_free_list(drv_data->pin_req);
 
-	return ret;
+	return 0;
 }
 
 static int sdh_resume(struct platform_device *dev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(dev);
 	struct bfin_sd_host *drv_data = get_sdh_data(dev);
 	int ret = 0;
 
@@ -665,10 +659,6 @@ static int sdh_resume(struct platform_device *dev)
 	}
 
 	sdh_reset();
-
-	if (mmc)
-		ret = mmc_resume_host(mmc);
-
 	return ret;
 }
 #else
-- 
1.7.9.5
