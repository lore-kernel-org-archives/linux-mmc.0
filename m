From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 16/27] mmc: mxcmmc: Move away from using deprecated APIs
Date: Thu, 26 Sep 2013 16:54:41 +0200
Message-ID: <1380207292-16968-17-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Anatolij Gustschin <agust@denx.de>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are being handled from the protocol layer
and consequently the mmc_suspend|resume_host APIs are deprecated.

This means we can simplify the suspend|resume callbacks by removing the
use of the deprecated APIs.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mxcmmc.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index c174c6a..f7199c8 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1250,28 +1250,20 @@ static int mxcmci_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct mxcmci_host *host = mmc_priv(mmc);
-	int ret = 0;
 
-	if (mmc)
-		ret = mmc_suspend_host(mmc);
 	clk_disable_unprepare(host->clk_per);
 	clk_disable_unprepare(host->clk_ipg);
-
-	return ret;
+	return 0;
 }
 
 static int mxcmci_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct mxcmci_host *host = mmc_priv(mmc);
-	int ret = 0;
 
 	clk_prepare_enable(host->clk_per);
 	clk_prepare_enable(host->clk_ipg);
-	if (mmc)
-		ret = mmc_resume_host(mmc);
-
-	return ret;
+	return 0;
 }
 
 static const struct dev_pm_ops mxcmci_pm_ops = {
-- 
1.7.9.5
