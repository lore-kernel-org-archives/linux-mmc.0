From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 3/8] mmc: mmci: Implement PM runtime callbacks to save power
Date: Tue, 17 Jan 2012 15:34:22 +0100
Message-ID: <1326810867-5346-4-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:51807 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753524Ab2AQOex (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jan 2012 09:34:53 -0500
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

In the runtime_suspend callback we make use of mmci_save
to disable the VCORE regulator and the MCLK to decrease
current consumption. At runtime resume, we use mmci_restore
to re-enable the resourses again.

>From now on this will mean that especially the mmci_restore
function must be fast to execute since otherwise request
latency will be introduced.

For the ARM Primcell PL180, the MMCIPOWER register is used
to control an external power supply to the card. Thus we
need to prevent the runtime callbacks from doing save and
restore, otherwise the power to card will be cut. This is
done by adding a new flag to the variant data.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index cd7e144..a7c8f8f 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -55,6 +55,7 @@ static unsigned int fmax = 515633;
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
+ * @pwrreg_ctrl_power: bits in MMCIPOWER register controls ext. power supply
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -67,6 +68,7 @@ struct variant_data {
 	bool			blksz_datactrl16;
 	u32			pwrreg_powerup;
 	bool			signal_direction;
+	bool			pwrreg_ctrl_power;
 };
 
 static struct variant_data variant_arm = {
@@ -74,6 +76,7 @@ static struct variant_data variant_arm = {
 	.fifohalfsize		= 8 * 4,
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
+	.pwrreg_ctrl_power	= true,
 };
 
 static struct variant_data variant_arm_extended_fifo = {
@@ -81,6 +84,7 @@ static struct variant_data variant_arm_extended_fifo = {
 	.fifohalfsize		= 64 * 4,
 	.datalength_bits	= 16,
 	.pwrreg_powerup		= MCI_PWR_UP,
+	.pwrreg_ctrl_power	= true,
 };
 
 static struct variant_data variant_u300 = {
@@ -1496,7 +1500,7 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_PM_RUNTIME)
 static int mmci_save(struct amba_device *dev)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
@@ -1550,7 +1554,9 @@ static int mmci_restore(struct amba_device *dev)
 
 	return 0;
 }
+#endif
 
+#ifdef CONFIG_SUSPEND
 static int mmci_suspend(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
@@ -1587,8 +1593,43 @@ static int mmci_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_PM_RUNTIME
+static int mmci_runtime_suspend(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+	int ret = 0;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+		struct variant_data *variant = host->variant;
+		if (!variant->pwrreg_ctrl_power)
+			ret = mmci_save(adev);
+	}
+
+	return ret;
+}
+
+static int mmci_runtime_resume(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+	int ret = 0;
+
+	if (mmc) {
+		struct mmci_host *host = mmc_priv(mmc);
+		struct variant_data *variant = host->variant;
+		if (!variant->pwrreg_ctrl_power)
+			ret = mmci_restore(adev);
+	}
+
+	return ret;
+}
+#endif
+
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
+	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static struct amba_id mmci_ids[] = {
-- 
1.7.5.4

