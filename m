From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Tue, 11 Dec 2012 15:17:54 +0100
Message-ID: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:34370 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753656Ab2LKOST (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 09:18:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The amba bus is already performing same actions but for the apb_pclk.
So here we just make sure the clock to card is gated as well to save
more power. At runtime resume we will thus restore the clock again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index aa04b42..0f397a2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1636,8 +1636,37 @@ static int mmci_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int mmci_runtime_suspend(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+		clk_disable_unprepare(host->clk);
+	}
+
+	return 0;
+}
+
+static int mmci_runtime_resume(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+		clk_prepare_enable(host->clk);
+	}
+
+	return 0;
+}
+#endif
+
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static struct amba_id mmci_ids[] = {
-- 
1.7.10

