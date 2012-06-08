From: philipspatches@gmail.com
Subject: [PATCH 1/2] mmc: Add support for Signal (vccq) Voltage Switching using Regulators
Date: Fri,  8 Jun 2012 12:26:25 -0700
Message-ID: <1339183585-21723-1-git-send-email-prakity@marvell.com>
References: <prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58197 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355Ab2FHT0b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jun 2012 15:26:31 -0400
Received: by dady13 with SMTP id y13so2743464dad.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jun 2012 12:26:31 -0700 (PDT)
In-Reply-To: <prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, aaron.lu@amd.com, mark.brown314@gmail.com
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

The SD Host Controller may require a regulator to support signal
and voltage switching.  Curently we support voltage (vmmc) but not
signal changing via a regulator.  Add this support.

If a regulator is supported and voltage switching to 1.8V is
supported then use the vmmc regulator to disable the voltage to
the core if 1.8 signal voltage switching fails.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c  |   88 ++++++++++++++++++++++++++++++++++-----------
 include/linux/mmc/sdhci.h |    3 +-
 2 files changed, 69 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 417851f..248f68b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1584,6 +1584,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 	u8 pwr;
 	u16 clk, ctrl;
 	u32 present_state;
+	int ret;
 
 	/*
 	 * Signal Voltage Switching is only applicable for Host Controllers
@@ -1604,6 +1605,15 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
+		if (host->vmmcvccq) {
+			ret = regulator_set_voltage(host->vmmcvccq,
+				3300000, 3300000);
+			if (ret) {
+				pr_info(DRIVER_NAME ": Switching to 3.3V "
+					"signalling voltage failed\n");
+				return -EIO;
+			}
+		}
 
 		/* 3.3V regulator output should be stable within 5 ms */
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
@@ -1629,29 +1639,43 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 			 * Enable 1.8V Signal Enable in the Host Control2
 			 * register
 			 */
-			ctrl |= SDHCI_CTRL_VDD_180;
-			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
-
-			/* Wait for 5ms */
-			usleep_range(5000, 5500);
-
-			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-			if (ctrl & SDHCI_CTRL_VDD_180) {
-				/* Provide SDCLK again and wait for 1ms*/
-				clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-				clk |= SDHCI_CLOCK_CARD_EN;
-				sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-				usleep_range(1000, 1500);
+			ret = 0;
+			if (host->vmmcvccq) {
+				ret = regulator_set_voltage(host->vmmcvccq,
+					1800000, 1800000);
+			}
 
-				/*
-				 * If DAT[3:0] level is 1111b, then the card
-				 * was successfully switched to 1.8V signaling.
-				 */
-				present_state = sdhci_readl(host,
+			if (!ret) {
+				ctrl |= SDHCI_CTRL_VDD_180;
+				sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+				/* Wait for 5ms */
+				usleep_range(5000, 5500);
+
+				ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+				if (ctrl & SDHCI_CTRL_VDD_180) {
+					/* Provide SDCLK again */
+					/* and wait for 1ms*/
+					clk = sdhci_readw(host,
+						SDHCI_CLOCK_CONTROL);
+					clk |= SDHCI_CLOCK_CARD_EN;
+					sdhci_writew(host, clk,
+						SDHCI_CLOCK_CONTROL);
+					usleep_range(1000, 1500);
+
+					/*
+					 * If DAT[3:0] level is 1111b,
+					 * then the card
+					 * was successfully switched
+					 * to 1.8V signaling.
+					 */
+					present_state = sdhci_readl(host,
 							SDHCI_PRESENT_STATE);
-				if ((present_state & SDHCI_DATA_LVL_MASK) ==
-				     SDHCI_DATA_LVL_MASK)
-					return 0;
+					if ((present_state &
+						SDHCI_DATA_LVL_MASK) ==
+							SDHCI_DATA_LVL_MASK)
+						return 0;
+				}
 			}
 		}
 
@@ -1663,11 +1687,15 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 		pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
 		pwr &= ~SDHCI_POWER_ON;
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		if (host->vmmc)
+			regulator_disable(host->vmmc);
 
 		/* Wait for 1ms as per the spec */
 		usleep_range(1000, 1500);
 		pwr |= SDHCI_POWER_ON;
 		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		if (host->vmmc)
+			regulator_enable(host->vmmc);
 
 		pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
 			"voltage failed, retrying with S18R set to 0\n");
@@ -2784,6 +2812,19 @@ int sdhci_add_host(struct sdhci_host *host)
 	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	/* if vccq regulator and no 1.8V signaling no UHS */
+	host->vmmcvccq = regulator_get(mmc_dev(mmc), "vmmcvccq");
+	if (IS_ERR(host->vmmcvccq)) {
+		printk(KERN_INFO "%s: no vmmcvccq regulator found\n",
+			mmc_hostname(mmc));
+		host->vmmcvccq = NULL;
+	} else if (regulator_is_supported_voltage(host->vmmcvccq,
+			1800000, 1800000)) {
+		regulator_enable(host->vmmcvccq);
+	} else
+		caps[1] &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
+		       SDHCI_SUPPORT_DDR50);
+
 	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */
 	if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
 		       SDHCI_SUPPORT_DDR50))
@@ -3108,6 +3149,11 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	if (host->vmmc)
 		regulator_put(host->vmmc);
 
+	if (host->vmmcvccq) {
+		regulator_disable(host->vmmcvccq);
+		regulator_put(host->vmmcvccq);
+	}
+
 	kfree(host->adma_desc);
 	kfree(host->align_buffer);
 
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 560fe22..67906bd 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -98,7 +98,8 @@ struct sdhci_host {
 
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
-	struct regulator *vmmc;	/* Power regulator */
+	struct regulator *vmmc;		/* Power regulator (vcc or vdd) */
+	struct regulator *vmmcvccq;	/* Signal regulator (vccq) */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
1.7.0.4

