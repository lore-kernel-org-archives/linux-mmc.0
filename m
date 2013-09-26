From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/27] mmc: au1xmmc: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:27 +0200
Message-ID: <1380207292-16968-3-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Manuel Lauss <manuel.lauss@googlemail.com>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Manuel Lauss <manuel.lauss@googlemail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/au1xmmc.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index df9becd..f5443a6 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1157,11 +1157,6 @@ static int au1xmmc_remove(struct platform_device *pdev)
 static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = mmc_suspend_host(host->mmc);
-	if (ret)
-		return ret;
 
 	au_writel(0, HOST_CONFIG2(host));
 	au_writel(0, HOST_CONFIG(host));
@@ -1178,7 +1173,7 @@ static int au1xmmc_resume(struct platform_device *pdev)
 
 	au1xmmc_reset_controller(host);
 
-	return mmc_resume_host(host->mmc);
+	return 0;
 }
 #else
 #define au1xmmc_suspend NULL
-- 
1.7.9.5
