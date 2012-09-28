From: Johan Rudholm <johan.rudholm@stericsson.com>
Subject: [RFC] mmc: sdhci: Let core handle UHS switch failure
Date: Fri, 28 Sep 2012 09:35:43 +0200
Message-ID: <1348817743-1391-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:47718 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755186Ab2I1HhP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Sep 2012 03:37:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>, Kevin Liu <keyuan.liu@gmail.com>, Philip Rakity <prakity@marvell.com>, Johan Rudholm <johan.rudholm@stericsson.com>

Let the upper layers handle the details of the UHS signal voltage
switch, such as timings and detection and handling of failure states.

Implement the card_busy host_ops function to let the upper layers
check if the card is signaling busy.

Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
---
This is a humble attempt to adapt the sdhci driver so it will work with
[RFC/PATCH] mmc: core: Fixup signal voltage switch

The patch is untested as I don't have the proper hardware. Furthermore,
I don't have any particular insight into how the sdhci controller
works, so quite possibly mistakes have been made, but the idea should
hopefully be clear.

I hope I can get some help at testing this, and I'm grateful for any
comments.
---
 drivers/mmc/host/sdhci.c |  102 ++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 66 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e15c79..01eed72 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1639,80 +1639,32 @@ static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
 static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
 						u16 ctrl)
 {
-	u8 pwr;
-	u16 clk;
-	u32 present_state;
 	int ret;
 
-	/* Stop SDCLK */
-	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	clk &= ~SDHCI_CLOCK_CARD_EN;
-	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-	/* Check whether DAT[3:0] is 0000 */
-	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
-	if (!((present_state & SDHCI_DATA_LVL_MASK) >>
-	       SDHCI_DATA_LVL_SHIFT)) {
-		/*
-		 * Enable 1.8V Signal Enable in the Host Control2
-		 * register
-		 */
-		if (host->vqmmc)
-			ret = regulator_set_voltage(host->vqmmc,
-				1800000, 1800000);
-		else
-			ret = 0;
-
-		if (!ret) {
-			ctrl |= SDHCI_CTRL_VDD_180;
-			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
-
-			/* Wait for 5ms */
-			usleep_range(5000, 5500);
-
-			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			if (ctrl & SDHCI_CTRL_VDD_180) {
-				/* Provide SDCLK again and wait for 1ms */
-				clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-				clk |= SDHCI_CLOCK_CARD_EN;
-				sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-				usleep_range(1000, 1500);
-
-				/*
-				 * If DAT[3:0] level is 1111b, then the card
-				 * was successfully switched to 1.8V signaling.
-				 */
-				present_state = sdhci_readl(host,
-							SDHCI_PRESENT_STATE);
-				if ((present_state & SDHCI_DATA_LVL_MASK) ==
-				     SDHCI_DATA_LVL_MASK)
-					return 0;
-			}
+	if (host->vqmmc) {
+		ret = regulator_set_voltage(host->vqmmc, 1800000, 1800000);
+		if (ret) {
+			pr_warning("%s: Switching to 1.8V signalling voltage "
+				   " failed\n", mmc_hostname(host->mmc));
+			return -EIO;
 		}
 	}
 
-	/*
-	 * If we are here, that means the switch to 1.8V signaling
-	 * failed. We power cycle the card, and retry initialization
-	 * sequence by setting S18R to 0.
-	 */
-	pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
-	pwr &= ~SDHCI_POWER_ON;
-	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
-	if (host->vmmc)
-		regulator_disable(host->vmmc);
+	/* Enable 1.8V Signal Enable in the Host Control2 register */
+	ctrl |= SDHCI_CTRL_VDD_180;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-	/* Wait for 1ms as per the spec */
-	usleep_range(1000, 1500);
-	pwr |= SDHCI_POWER_ON;
-	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
-	if (host->vmmc)
-		regulator_enable(host->vmmc);
+	/* Wait for 5ms */
+	usleep_range(5000, 5500);
 
-	pr_warning("%s: Switching to 1.8V signalling voltage failed, "
-		   "retrying with S18R set to 0\n", mmc_hostname(host->mmc));
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ctrl & SDHCI_CTRL_VDD_180)
+		return 0;
+
+	pr_warning("%s: 1.8V regulator output did not become stable\n",
+		   mmc_hostname(host->mmc));
 
-	return -EAGAIN;
+	return -EIO;
 }
 
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
@@ -1991,6 +1943,23 @@ static void sdhci_enable_preset_value(struct mmc_host *mmc, bool enable)
 	sdhci_runtime_pm_put(host);
 }
 
+static void sdhci_card_busy(struct mmc_host *mmc, bool keep_busy)
+{
+	u32 present_state;
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/* Check whether DAT[3:0] is 0000 */
+	sdhci_runtime_pm_get(host);
+	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	sdhci_runtime_pm_put(host);
+
+	if (!((present_state & SDHCI_DATA_LVL_MASK) >> SDHCI_DATA_LVL_SHIFT))
+		return 1;
+	else
+		return 0;
+
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
@@ -2000,6 +1969,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 	.execute_tuning			= sdhci_execute_tuning,
 	.enable_preset_value		= sdhci_enable_preset_value,
+	.card_busy	= sdhci_card_busy,
 };
 
 /*****************************************************************************\
-- 
1.7.10

