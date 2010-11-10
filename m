From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH 3/5] mmc_sdhci: improve the wake-up support
Date: Wed, 10 Nov 2010 16:28:07 +0100
Message-ID: <1289402889-14160-5-git-send-email-peppe.cavallaro@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:46986 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756677Ab0KJP2i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:28:38 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BDEF9A
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:36 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 493DB541D
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:36 +0000 (GMT)
In-Reply-To: <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch reworks the wake-up support in the sdhci driver.
It is now able to wake-up the system on: Card interrupts,
Card insertion and Card removal events.
This has been tested on ST STB where can make sense to
wake-up the box as soon as a card is inserted.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c |  110 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.h |    3 +-
 include/linux/mmc/pm.h   |    9 +++-
 3 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 69c80c9..8db9757 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -36,7 +36,8 @@
 #define SDHCI_USE_LEDS_CLASS
 #endif
 
-static unsigned int debug_quirks = 0;
+static unsigned int debug_quirks;
+static unsigned int wakeup;
 
 static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
 static void sdhci_finish_data(struct sdhci_host *);
@@ -1595,6 +1596,83 @@ out:
 
 #ifdef CONFIG_PM
 
+static void sdhci_can_wakeup(struct sdhci_host *host)
+{
+	struct device *dev = host->mmc->parent;
+
+	/* SDHCI is capable to wakeup the system */
+	device_set_wakeup_capable(dev, 1);
+
+	/* Enable wakeup */
+	device_set_wakeup_enable(dev, 1);
+	enable_irq_wake(host->irq);
+}
+
+/*
+ * According to the SD SPEC to wake up the system
+ * the HC has to be programmed as below:
+ * - SD Bus power: ON
+ * - SD clock: Stop
+ * - Internal clock: Oscillate
+ * - Data transfer witdh: 0
+ *
+ * While suspending we have to:
+ * 1) Set BUS width to 1
+ * 2) Mask the Signal Interrupt register
+ * 3) Clean the Signal Interrupt register
+ * 4) Set the enable bits of each factor to 1 in the Wakeup
+ *    control register
+ * 5) Set the bits of Normal Interrupt Status Enable register
+ *    to use wakeup.
+ */
+static void sdhci_set_wakeup(struct sdhci_host *host)
+{
+	u16 clk;
+	u8 pwr;
+	mmc_pm_flag_t wakeflag = 0;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk &= ~SDHCI_CLOCK_CARD_EN;
+	clk |= SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	pwr |= SDHCI_POWER_ON;
+	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+	sdhci_mask_irqs(host, SDHCI_INT_NORMAL_MASK |
+			SDHCI_INT_ERROR_MASK);
+	sdhci_writel(host, 0, SDHCI_INT_STATUS);
+	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
+	sdhci_writel(host, SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT |
+		     SDHCI_INT_CARD_INT, SDHCI_INT_ENABLE);
+
+	/*
+	 * If a wake up event is set by user, then force the pm_flags
+	 * to use it (independently of the previous setting made in the d.d.
+	 */
+	if (wakeup == 1)
+		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_IRQ;
+	else if (wakeup == 2)
+		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_CARD_INS;
+	else if (wakeup == 3)
+		host->mmc->pm_flags |= MMC_PM_WAKE_SDIO_CARD_REM;
+
+	/*
+	 * Program the Wakeup Control register according to the event selected.
+	 * If there is no event (SDHCI_WAKE_UP_CONTROL = 0x0) so the device
+	 * won't be able to wake up the system.
+	 */
+	if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_IRQ)
+		wakeflag |= SDHCI_WAKE_ON_INT;
+	if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_CARD_INS)
+		wakeflag |= SDHCI_WAKE_ON_INSERT;
+	if (host->mmc->pm_flags & MMC_PM_WAKE_SDIO_CARD_REM)
+		wakeflag |= SDHCI_WAKE_ON_REMOVE;
+
+	sdhci_enable_irq_wakeups(host, wakeflag);
+}
+
 int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 {
 	int ret;
@@ -1605,7 +1683,10 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 	if (ret)
 		return ret;
 
-	free_irq(host->irq, host);
+	if (host->mmc->pm_flags & MMC_PM_KEEP_POWER)
+		sdhci_set_wakeup(host);
+	else
+		free_irq(host->irq, host);
 
 	return 0;
 }
@@ -1621,12 +1702,13 @@ int sdhci_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-			  mmc_hostname(host->mmc), host);
-	if (ret)
-		return ret;
-
-	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
+	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER)) {
+		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
+				  mmc_hostname(host->mmc), host);
+		if (ret)
+			return ret;
+	}
+	sdhci_init(host, host->mmc->pm_flags);
 	mmiowb();
 
 	ret = mmc_resume_host(host->mmc);
@@ -1637,16 +1719,16 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
-void sdhci_enable_irq_wakeups(struct sdhci_host *host)
+void sdhci_enable_irq_wakeups(struct sdhci_host *host, unsigned int mode)
 {
 	u8 val;
+
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
-	val |= SDHCI_WAKE_ON_INT;
+	val |= mode;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
 
 EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
-
 #endif /* CONFIG_PM */
 
 /*****************************************************************************\
@@ -1928,6 +2010,10 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_enable_card_detection(host);
 
+#ifdef CONFIG_PM
+	if (host->mmc->pm_flags & MMC_PM_KEEP_POWER)
+		sdhci_can_wakeup(host);
+#endif
 	return 0;
 
 #ifdef SDHCI_USE_LEDS_CLASS
@@ -2021,9 +2107,11 @@ module_init(sdhci_drv_init);
 module_exit(sdhci_drv_exit);
 
 module_param(debug_quirks, uint, 0444);
+module_param(wakeup, uint, S_IRUGO | S_IWUSR);
 
 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface core driver");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM_DESC(debug_quirks, "Force certain quirks.");
+MODULE_PARM_DESC(wakeup, "Wakeup:0:disable,1:Card Int,2:Card Ins,3: Card Rem.");
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f939371..cd70d00 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -312,7 +312,8 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
 extern int sdhci_resume_host(struct sdhci_host *host);
-extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
+extern void sdhci_enable_irq_wakeups(struct sdhci_host *host,
+				     unsigned int mode);
 #endif
 
 #endif /* __SDHCI_HW_H */
diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
index d37aac4..31df7f2 100644
--- a/include/linux/mmc/pm.h
+++ b/include/linux/mmc/pm.h
@@ -24,7 +24,14 @@
 
 typedef unsigned int mmc_pm_flag_t;
 
-#define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during suspend */
+/* Preserve card power during suspend. It is also used for notifying
+ * that the device can wakeup the system. This can be done, for example,
+ * by either card interrupt enent or card insertion event or card
+ * removal event.
+ */
+#define MMC_PM_KEEP_POWER	(1 << 0)
 #define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO IRQ assertion */
+#define MMC_PM_WAKE_SDIO_CARD_INS	(1 << 2) /* wake up on card insertion */
+#define MMC_PM_WAKE_SDIO_CARD_REM	(1 << 3) /* wake up on card removal  */
 
 #endif
-- 
1.5.5.6

