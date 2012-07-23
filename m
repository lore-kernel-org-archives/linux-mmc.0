From: philipspatches@gmail.com
Subject: [PATCH] sdhci: Add regulator support for vccq (voltage regualor)
Date: Mon, 23 Jul 2012 15:56:23 -0700
Message-ID: <1343084183-6070-1-git-send-email-prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55941 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab2GWW43 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jul 2012 18:56:29 -0400
Received: by qadb17 with SMTP id b17so1437374qad.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jul 2012 15:56:28 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

On some systems the host controller does not support vccq
signaling.  This is supplied by a dedicated regulator (vqmmc).

Add support for this regulator.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c  |  179 +++++++++++++++++++++++++++++----------------
 include/linux/mmc/sdhci.h |    3 +-
 2 files changed, 117 insertions(+), 65 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a11dc3..ac50d35 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1597,57 +1597,64 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
-						struct mmc_ios *ios)
+static int sdhci_do_3_3v_signal_voltage_switch(struct sdhci_host *host,
+						u16 ctrl)
 {
-	u8 pwr;
-	u16 clk, ctrl;
-	u32 present_state;
-
-	/*
-	 * Signal Voltage Switching is only applicable for Host Controllers
-	 * v3.00 and above.
-	 */
-	if (host->version < SDHCI_SPEC_300)
-		return 0;
-
-	/*
-	 * We first check whether the request is to set signalling voltage
-	 * to 3.3V. If so, we change the voltage to 3.3V and return quickly.
-	 */
-	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
-		ctrl &= ~SDHCI_CTRL_VDD_180;
-		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+	int ret;
 
-		/* Wait for 5ms */
-		usleep_range(5000, 5500);
+	/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
+	ctrl &= ~SDHCI_CTRL_VDD_180;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		/* 3.3V regulator output should be stable within 5 ms */
-		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-		if (!(ctrl & SDHCI_CTRL_VDD_180))
-			return 0;
-		else {
+	if (host->vqmmc) {
+		ret = regulator_set_voltage(host->vqmmc,
+			3300000, 3300000);
+		if (ret) {
 			pr_info(DRIVER_NAME ": Switching to 3.3V "
 				"signalling voltage failed\n");
 			return -EIO;
 		}
-	} else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
-		  (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)) {
-		/* Stop SDCLK */
-		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		clk &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+	}
+	/* Wait for 5ms */
+	usleep_range(5000, 5500);
 
-		/* Check whether DAT[3:0] is 0000 */
-		present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
-		if (!((present_state & SDHCI_DATA_LVL_MASK) >>
-		       SDHCI_DATA_LVL_SHIFT)) {
-			/*
-			 * Enable 1.8V Signal Enable in the Host Control2
-			 * register
-			 */
+	/* 3.3V regulator output should be stable within 5 ms */
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (!(ctrl & SDHCI_CTRL_VDD_180))
+		return 0;
+
+	pr_info(DRIVER_NAME ": Switching to 3.3V signalling voltage failed\n");
+	return -EIO;
+}
+
+static int sdhci_do_1_8v_signal_voltage_switch(struct sdhci_host *host,
+						u16 ctrl)
+{
+	u8 pwr;
+	u16 clk;
+	u32 present_state;
+	int ret;
+
+	/* Stop SDCLK */
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	/* Check whether DAT[3:0] is 0000 */
+	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	if (!((present_state & SDHCI_DATA_LVL_MASK) >>
+	       SDHCI_DATA_LVL_SHIFT)) {
+		/*
+		 * Enable 1.8V Signal Enable in the Host Control2
+		 * register
+		 */
+		if (host->vqmmc)
+			ret = regulator_set_voltage(host->vqmmc,
+				1800000, 1800000);
+		else
+			ret = 0;
+
+		if (!ret) {
 			ctrl |= SDHCI_CTRL_VDD_180;
 			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
@@ -1656,7 +1663,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 
 			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			if (ctrl & SDHCI_CTRL_VDD_180) {
-				/* Provide SDCLK again and wait for 1ms*/
+				/* Provide SDCLK again and wait for 1ms */
 				clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
 				clk |= SDHCI_CLOCK_CARD_EN;
 				sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
@@ -1673,29 +1680,54 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 					return 0;
 			}
 		}
+	}
 
-		/*
-		 * If we are here, that means the switch to 1.8V signaling
-		 * failed. We power cycle the card, and retry initialization
-		 * sequence by setting S18R to 0.
-		 */
-		pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
-		pwr &= ~SDHCI_POWER_ON;
-		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
-		if (host->vmmc)
-			regulator_disable(host->vmmc);
+	/*
+	 * If we are here, that means the switch to 1.8V signaling
+	 * failed. We power cycle the card, and retry initialization
+	 * sequence by setting S18R to 0.
+	 */
+	pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	pwr &= ~SDHCI_POWER_ON;
+	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+	if (host->vmmc)
+		regulator_disable(host->vmmc);
 
-		/* Wait for 1ms as per the spec */
-		usleep_range(1000, 1500);
-		pwr |= SDHCI_POWER_ON;
-		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
-		if (host->vmmc)
-			regulator_enable(host->vmmc);
+	/* Wait for 1ms as per the spec */
+	usleep_range(1000, 1500);
+	pwr |= SDHCI_POWER_ON;
+	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+	if (host->vmmc)
+		regulator_enable(host->vmmc);
 
-		pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
-			"voltage failed, retrying with S18R set to 0\n");
-		return -EAGAIN;
-	} else
+	pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
+		"voltage failed, retrying with S18R set to 0\n");
+	return -EAGAIN;
+}
+
+static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
+						struct mmc_ios *ios)
+{
+	u16 ctrl;
+
+	/*
+	 * Signal Voltage Switching is only applicable for Host Controllers
+	 * v3.00 and above.
+	 */
+	if (host->version < SDHCI_SPEC_300)
+		return 0;
+
+	/*
+	 * We first check whether the request is to set signalling voltage
+	 * to 3.3V. If so, we change the voltage to 3.3V and return quickly.
+	 */
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		return sdhci_do_3_3v_signal_voltage_switch(host, ctrl);
+	else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
+			(ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180))
+		return sdhci_do_1_8v_signal_voltage_switch(host, ctrl);
+	else
 		/* No signal voltage switch required */
 		return 0;
 }
@@ -2802,6 +2834,20 @@ int sdhci_add_host(struct sdhci_host *host)
 	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	/* if vqmmc regulator and no 1.8V signaling no UHS */
+
+	host->vqmmc = regulator_get(mmc_dev(mmc), "vqmmc");
+	if (IS_ERR(host->vqmmc)) {
+		pr_info("%s: no vqmmc regulator found\n",
+			mmc_hostname(mmc));
+		host->vqmmc = NULL;
+	} else if (regulator_is_supported_voltage(host->vqmmc,
+			1800000, 1800000))
+		regulator_enable(host->vqmmc);
+	else
+		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+		       SDHCI_SUPPORT_DDR50);
+
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50))
@@ -3122,6 +3168,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	if (host->vmmc)
 		regulator_put(host->vmmc);
 
+	if (host->vqmmc) {
+		regulator_disable(host->vqmmc);
+		regulator_put(host->vqmmc);
+	}
+
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index ac83b10..fa8529a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -97,7 +97,8 @@ struct sdhci_host {
 
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
-	struct regulator *vmmc;	/* Power regulator */
+	struct regulator *vmmc;		/* Power regulator (vmmc) */
+	struct regulator *vqmmc;	/* Signaling regulator (vccq) */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.7.0.4

