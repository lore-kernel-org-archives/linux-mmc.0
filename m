From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 3/3] mmc: mmci: Save and restore register context
Date: Thu, 23 May 2013 11:45:07 +0200
Message-ID: <1369302307-28540-4-git-send-email-ulf.hansson@stericsson.com>
References: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:55768 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757675Ab3EWJqR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 05:46:17 -0400
In-Reply-To: <1369302307-28540-1-git-send-email-ulf.hansson@stericsson.com>
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

Changes in v2:
	Rebased on top of recently merged patchset for UHS card support.
---
 drivers/mmc/host/mmci.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8f70e5b..ec9f17c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -62,6 +62,7 @@ static unsigned int fmax = 515633;
  * @signal_direction: input/out direction of bus signals can be indicated
  * @pwrreg_clkgate: MMCIPOWER register must be used to gate the clock
  * @busy_detect: true if busy detection on dat0 is supported
+ * @pwrreg_nopower: bits in MMCIPOWER don't controls ext. power supply
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -76,6 +77,7 @@ struct variant_data {
 	bool			signal_direction;
 	bool			pwrreg_clkgate;
 	bool			busy_detect;
+	bool			pwrreg_nopower;
 };
 
 static struct variant_data variant_arm = {
@@ -109,6 +111,7 @@ static struct variant_data variant_u300 = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
 };
 
 static struct variant_data variant_nomadik = {
@@ -121,6 +124,7 @@ static struct variant_data variant_nomadik = {
 	.pwrreg_powerup		= MCI_PWR_ON,
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
+	.pwrreg_nopower		= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -135,6 +139,7 @@ static struct variant_data variant_ux500 = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.busy_detect		= true,
+	.pwrreg_nopower		= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -150,6 +155,7 @@ static struct variant_data variant_ux500v2 = {
 	.signal_direction	= true,
 	.pwrreg_clkgate		= true,
 	.busy_detect		= true,
+	.pwrreg_nopower		= true,
 };
 
 static int mmci_card_busy(struct mmc_host *mmc)
@@ -1782,6 +1788,41 @@ static int mmci_resume(struct device *dev)
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
+		writel(0, host->base + MMCIDATACTRL);
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
+		writel(host->datactrl_reg, host->base + MMCIDATACTRL);
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
@@ -1794,6 +1835,7 @@ static int mmci_runtime_suspend(struct device *dev)
 		if (!IS_ERR(host->pins_sleep))
 			pinctrl_select_state(host->pinctrl, host->pins_sleep);
 
+		mmci_save(host);
 		clk_disable_unprepare(host->clk);
 	}
 
@@ -1809,6 +1851,7 @@ static int mmci_runtime_resume(struct device *dev)
 		struct mmci_host *host = mmc_priv(mmc);
 
 		clk_prepare_enable(host->clk);
+		mmci_restore(host);
 
 		/* Optionally enable pins to be muxed in and configured */
 		if (!IS_ERR(host->pins_default))
-- 
1.7.10

