From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH] mmc:au1xmmc change driver to use dev_pm_ops infrastructure
Date: Sat, 10 Aug 2013 09:20:47 -0600
Message-ID: <1376148055-2539-2-git-send-email-shuah.kh@samsung.com>
References: <1376148055-2539-1-git-send-email-shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376148055-2539-1-git-send-email-shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: manuel.lauss@gmail.com, cjb@laptop.org
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-mmc@vger.kernel.org

Change au1xmmc platform driver to register pm ops using dev_pm_ops instead of
legacy pm_ops infrastructure.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/mmc/host/au1xmmc.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index df9becd..0bafd7f 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1154,11 +1154,12 @@ static int au1xmmc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int au1xmmc_suspend(struct device *dev)
 {
-	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host;
 	int ret;
 
+	host = platform_get_drvdata(to_platform_device(dev));
 	ret = mmc_suspend_host(host->mmc);
 	if (ret)
 		return ret;
@@ -1172,10 +1173,11 @@ static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int au1xmmc_resume(struct platform_device *pdev)
+static int au1xmmc_resume(struct device *dev)
 {
-	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host;
 
+	host = platform_get_drvdata(to_platform_device(dev));
 	au1xmmc_reset_controller(host);
 
 	return mmc_resume_host(host->mmc);
@@ -1185,14 +1187,15 @@ static int au1xmmc_resume(struct platform_device *pdev)
 #define au1xmmc_resume NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(au1xmmc_dev_pm_ops, au1xmmc_suspend, au1xmmc_resume);
+
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
 	.remove        = au1xmmc_remove,
-	.suspend       = au1xmmc_suspend,
-	.resume        = au1xmmc_resume,
 	.driver        = {
 		.name  = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.pm    = &au1xmmc_dev_pm_ops,
 	},
 };
 
-- 
1.7.10.4
