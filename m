From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhci: allow mdelay to reschedule by not holding spin_lock
Date: Mon, 3 Jan 2011 21:26:53 -0800
Message-ID: <1CE9AD0D-5B2D-4E27-96B7-F18C3A3BAA8B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:57953 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750897Ab1ADFei convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Jan 2011 00:34:38 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: Mark Brown <markb@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Code is UNTESTED -- I can test in the morning when I have hardware available. 

Code releases spin_lock and reacquires it so that mdelay can cause system to schedule
other tasks.  It is backed on my version of sdhci.c but should be simple matter to 
patch into existing sdhci.c

Signed-off-by:  Philip Rakity <prakity@marvell.com>

NOTE AGAIN -- UNTESTED 



diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cb48baa..603ea67 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1009,15 +1009,18 @@ static void sdhci_finish_command(struct sdhci_host *host)
 static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
 {
 	u16 con;
+	unsigned long flags;
 
 	if (ddr == MMC_SDR_MODE)
 		return;
 
+	spin_lock_irqsave(&host->lock, flags);
 	con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
 	con |= SDCTRL_2_SDH_V18_EN;
 	sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
 
 	/* Change signaling voltage and wait for it to be stable */
+	spin_unlock_irqrestore(&host->lock, flags);
 	if (host->ops->set_signaling_voltage)
 		host->ops->set_signaling_voltage(host, ddr);
 	else
@@ -1027,10 +1030,12 @@ static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
 	 * We can fail here but there is no higher level recovery
 	 * since the card is already past the switch to ddr
 	 */
+	spin_lock_irqsave(&host->lock, flags);
 	con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
 	con &= ~SDCTRL_2_UHS_MODE_MASK;
 	con |= SDCTRL_2_UHS_MODE_SEL_DDR50;
 	sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -1038,14 +1043,18 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	int div;
 	u16 clk;
 	unsigned long timeout;
+	unsigned long flags;
 
 	if (clock == host->clock)
 		return;
 
+	spin_lock_irqsave(&host->lock, flags);
 	if (host->ops->set_clock) {
 		host->ops->set_clock(host, clock);
-		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
+		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
+			spin_unlock_irqrestore(&host->lock, flags);
 			return;
+		}
 	}
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
@@ -1086,10 +1095,14 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 			printk(KERN_ERR "%s: Internal clock never "
 				"stabilised.\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
+			spin_unlock_irqrestore(&host->lock, flags);
 			return;
 		}
 		timeout--;
+		spin_unlock_irqrestore(&host->lock, flags);
 		mdelay(1);
+		spin_lock_irqsave(&host->lock, flags);
+
 	}
 
 	clk |= SDHCI_CLOCK_CARD_EN;
@@ -1097,11 +1110,13 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 out:
 	host->clock = clock;
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 {
 	u8 pwr = 0;
+	unsigned long flags;
 
 	if (power != (unsigned short)-1) {
 		switch (1 << power) {
@@ -1131,6 +1146,8 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 		return;
 	}
 
+	spin_lock_irqsave(&host->lock, flags);
+
 	/*
 	 * Spec says that we should clear the power reg before setting
 	 * a new value. Some controllers don't seem to like this though.
@@ -1153,8 +1170,12 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned short power)
 	 * Some controllers need an extra 10ms delay of 10ms before they
 	 * can apply clock after applying power
 	 */
-	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
+	if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER) {
+		spin_unlock_irqrestore(&host->lock, flags);
 		mdelay(10);
+		spin_lock_irqsave(&host->lock, flags);
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 /*****************************************************************************\
@@ -1226,6 +1247,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_reinit(host);
 	}
 
+	spin_unlock_irqrestore(&host->lock, flags);
 	sdhci_set_clock(host, ios->clock);
 	sdhci_set_ddr(host, ios->ddr);
 
@@ -1234,6 +1256,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_set_power(host, ios->vdd);
 
+	spin_lock_irqsave(&host->lock, flags);
+
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 