From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 3/3] mmc: mmci: Save and restore register context
Date: Mon, 13 May 2013 15:47:17 +0200
Message-ID: <1368452837-31458-4-git-send-email-ulf.hansson@stericsson.com>
References: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:44898 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752808Ab3EMNsS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 09:48:18 -0400
In-Reply-To: <1368452837-31458-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Rickard Andersson <rickard.andersson@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

If a corresponding power domain exists for the device and it manages
to cut the domain regulator while the device is runtime suspended,
the IP loses it's registers context. We restore the context in the
.runtime_resume callback from the existing register caches to adapt
to this siutuation.

We also want to make sure the registers are in a known state while
restoring context in the case when the power domain did not drop the
power, since there are restrictions for the order of writing to these
registers. To handle this, we clear the registers in the
.runtime_suspend callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7815816..790d744 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -61,6 +61,7 @@ static unsigned int fmax = 515633;
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
+ * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -74,6 +75,7 @@ struct variant_data {
 	u32			pwrreg_powerup;
 	bool			signal_direction;
 	bool			pwrreg_clkgate;
+	bool			pwrreg_nopower;
 };
 
 static struct variant_data variant_arm = {
@@ -107,6 +109,7 @@ static struct variant_data variant_u300 = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
 };
 
 static struct variant_data variant_nomadik = {
@@ -119,6 +122,7 @@ static struct variant_data variant_nomadik = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -132,6 +136,7 @@ static struct variant_data variant_ux500 = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -146,6 +151,7 @@ static struct variant_data variant_ux500v2 = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
 };
 
 /*
@@ -1695,6 +1701,39 @@ static int mmci_resume(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM_RUNTIME
+static void mmci_save(struct mmci_host *host)
+{
+	unsigned long flags;
+
+	if (host->variant->pwrreg_nopower) {
+		spin_lock_irqsave(&host->lock, flags);
+
+		writel(0, host->base + MMCIMASK0);
+		writel(0, host->base + MMCIPOWER);
+		writel(0, host->base + MMCICLOCK);
+		mmci_reg_delay(host);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+
+}
+
+static void mmci_restore(struct mmci_host *host)
+{
+	unsigned long flags;
+
+	if (host->variant->pwrreg_nopower) {
+		spin_lock_irqsave(&host->lock, flags);
+
+		writel(host->clk_reg, host->base + MMCICLOCK);
+		writel(host->pwr_reg, host->base + MMCIPOWER);
+		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+		mmci_reg_delay(host);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}
+
 static int mmci_runtime_suspend(struct device *dev)
 {
 	struct amba_device *adev = to_amba_device(dev);
@@ -1707,6 +1746,7 @@ static int mmci_runtime_suspend(struct device *dev)
 		if (!IS_ERR(host->pins_sleep))
 			pinctrl_select_state(host->pinctrl, host->pins_sleep);
 
+		mmci_save(host);
 		clk_disable_unprepare(host->clk);
 	}
 
@@ -1722,6 +1762,7 @@ static int mmci_runtime_resume(struct device *dev)
 		struct mmci_host *host = mmc_priv(mmc);
 
 		clk_prepare_enable(host->clk);
+		mmci_restore(host);
 
 		/* Optionally enable pins to be muxed in and configured */
 		if (!IS_ERR(host->pins_default))
-- 
1.7.10

