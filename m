From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 2/8] mmc: mmci: Decrease current consumption in suspend
Date: Tue, 17 Jan 2012 15:34:21 +0100
Message-ID: <1326810867-5346-3-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:36658 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754501Ab2AQOex (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:34:53 -0500
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

To decrease current consumption in suspend state the
VCORE regulator, the MCLK and PCLK for the ARM PL18x
are now disabled.

When resuming the resourses are re-enabled and
register values for MMCICLOCK, MMCIPOWER and MMCIMASK0
are restored.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   64 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0de2f3d..cd7e144 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1497,6 +1497,60 @@ static int __devexit mmci_remove(struct amba_device *dev)
 }
 
 #ifdef CONFIG_SUSPEND
+static int mmci_save(struct amba_device *dev)
+{
+	struct mmc_host *mmc = amba_get_drvdata(dev);
+	unsigned long flags;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/*
+		 * Make sure we do not get any interrupts when we disabled the
+		 * clock and the regulator and as well make sure to clear the
+		 * registers for clock and power.
+		 */
+		writel(0, host->base + MMCIMASK0);
+		writel(0, host->base + MMCIPOWER);
+		writel(0, host->base + MMCICLOCK);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		clk_unprepare(host->clk);
+		clk_disable(host->clk);
+		amba_vcore_disable(dev);
+	}
+
+	return 0;
+}
+
+static int mmci_restore(struct amba_device *dev)
+{
+	struct mmc_host *mmc = amba_get_drvdata(dev);
+	unsigned long flags;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+
+		amba_vcore_enable(dev);
+		clk_prepare(host->clk);
+		clk_enable(host->clk);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* Restore registers and re-enable interrupts. */
+		writel(host->clk_reg, host->base + MMCICLOCK);
+		writel(host->pwr_reg, host->base + MMCIPOWER);
+		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+	return 0;
+}
+
 static int mmci_suspend(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
@@ -1504,12 +1558,11 @@ static int mmci_suspend(struct device *dev)
 	int ret = 0;
 
 	if (mmc) {
-		struct mmci_host *host = mmc_priv(mmc);
-
 		ret = mmc_suspend_host(mmc);
 		if (ret == 0) {
 			pm_runtime_get_sync(dev);
-			writel(0, host->base + MMCIMASK0);
+			mmci_save(adev);
+			amba_pclk_disable(adev);
 		}
 	}
 
@@ -1523,9 +1576,8 @@ static int mmci_resume(struct device *dev)
 	int ret = 0;
 
 	if (mmc) {
-		struct mmci_host *host = mmc_priv(mmc);
-
-		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+		amba_pclk_enable(adev);
+		mmci_restore(adev);
 		pm_runtime_put(dev);
 
 		ret = mmc_resume_host(mmc);
-- 
1.7.5.4

