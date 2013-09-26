From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/27] mmc: mvsdio: Remove redundant suspend and resume callbacks
Date: Thu, 26 Sep 2013 16:54:34 +0200
Message-ID: <1380207292-16968-10-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are handled by the protocol layer and
consequently the mmc_suspend|resume_host APIs are marked as deprecated.

While moving away from using the deprecated APIs, there are nothing
left to be done for the suspend and resume callbacks, so remove them.

Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mvsdio.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index a592407..22ba4d3 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -838,33 +838,6 @@ static int __exit mvsd_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mvsd_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct mmc_host *mmc = platform_get_drvdata(dev);
-	int ret = 0;
-
-	if (mmc)
-		ret = mmc_suspend_host(mmc);
-
-	return ret;
-}
-
-static int mvsd_resume(struct platform_device *dev)
-{
-	struct mmc_host *mmc = platform_get_drvdata(dev);
-	int ret = 0;
-
-	if (mmc)
-		ret = mmc_resume_host(mmc);
-
-	return ret;
-}
-#else
-#define mvsd_suspend	NULL
-#define mvsd_resume	NULL
-#endif
-
 static const struct of_device_id mvsdio_dt_ids[] = {
 	{ .compatible = "marvell,orion-sdio" },
 	{ /* sentinel */ }
@@ -873,8 +846,6 @@ MODULE_DEVICE_TABLE(of, mvsdio_dt_ids);
 
 static struct platform_driver mvsd_driver = {
 	.remove		= __exit_p(mvsd_remove),
-	.suspend	= mvsd_suspend,
-	.resume		= mvsd_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.of_match_table = mvsdio_dt_ids,
-- 
1.7.9.5
