From: Shuah Khan <shuah.kh@samsung.com>
Subject: [RFT][PATCH 05/12] mmc: change au1xmmc platform power management to use dev_pm_ops
Date: Mon, 10 Feb 2014 09:12:28 -0700
Message-ID: <73aacb87b305ccffbb75dadd9c89da73f6592d6d.1392040067.git.shuah.kh@samsung.com>
References: <cover.1392040064.git.shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1392040064.git.shuah.kh@samsung.com>
In-Reply-To: <cover.1392040064.git.shuah.kh@samsung.com>
References: <cover.1392040064.git.shuah.kh@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, manuel.lauss@gmail.com, chris@printf.net
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-mmc@vger.kernel.org

Change au1xmmc platform driver to register pm ops using dev_pm_ops instead of
legacy pm_ops. .pm hooks call existing legacy suspend and resume interfaces
by passing in the right pm state.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/mmc/host/au1xmmc.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index f5443a6..1601f39 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1154,7 +1154,7 @@ static int au1xmmc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int __au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1167,7 +1167,22 @@ static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int au1xmmc_resume(struct platform_device *pdev)
+static int au1xmmc_suspend(struct device *dev)
+{
+	return __au1xmmc_suspend(to_platform_device(dev), PMSG_SUSPEND);
+}
+
+static int au1xmmc_freeze(struct device *dev)
+{
+	return __au1xmmc_suspend(to_platform_device(dev), PMSG_FREEZE);
+}
+
+static int au1xmmc_poweroff(struct device *dev)
+{
+	return __au1xmmc_suspend(to_platform_device(dev), PMSG_HIBERNATE);
+}
+
+static int __au1xmmc_resume(struct platform_device *pdev)
 {
 	struct au1xmmc_host *host = platform_get_drvdata(pdev);
 
@@ -1175,19 +1190,31 @@ static int au1xmmc_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define au1xmmc_suspend NULL
-#define au1xmmc_resume NULL
-#endif
 
+static int au1xmmc_resume(struct device *dev)
+{
+	return __au1xmmc_resume(to_platform_device(dev));
+}
+
+static const struct dev_pm_ops au1xmmc_dev_pm_ops = {
+	.suspend = au1xmmc_suspend,
+	.resume = au1xmmc_resume,
+	/* Hibernate hooks */
+	.freeze = au1xmmc_freeze,
+	.thaw = au1xmmc_resume,
+	.poweroff = au1xmmc_poweroff,
+	.restore = au1xmmc_resume,
+};
+#endif
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
 	.remove        = au1xmmc_remove,
-	.suspend       = au1xmmc_suspend,
-	.resume        = au1xmmc_resume,
 	.driver        = {
 		.name  = DRIVER_NAME,
 		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm    = &au1xmmc_dev_pm_ops,
+#endif
 	},
 };
 
-- 
1.7.10.4
