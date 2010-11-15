From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [PATCH (mmc-next)] mmc: improve the SDHCI wake-up support [RFC: V2]
Date: Mon, 15 Nov 2010 15:53:00 +0100
Message-ID: <1289832780-9467-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:47964 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757593Ab0KOOxI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2010 09:53:08 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 942318E
	for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2010 14:53:06 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18BE6295D
	for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2010 14:53:06 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch allows the SDHCI to wake up the system
on the following events:
 1) Card Interrupts.
 2) Card Insertion.
 3) Card Removal.

Indeed, on a set-top-box, it can be nice to have the
capability to wake-up the system when a card is inserted.

These new module parameters have been added to select
which events have to wake-up the system:
 o wake_on_card_int
 o wake_on_card_ins
 o wake_on_card_rem

Ex:
$ echo 1 > /sys/module/sdhci/parameters/wakeup_card_ins

A new quirk has been also added to allow hosts, based
on sdhci d.d., to set the device as wake-up capable.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci-pci.c |    2 +-
 drivers/mmc/host/sdhci.c     |  104 ++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h     |    2 +-
 include/linux/mmc/sdhci.h    |    2 +
 4 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 3d9c246..de610f1 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -668,7 +668,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 
 		slot_pm_flags = slot->host->mmc->pm_flags;
 		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
-			sdhci_enable_irq_wakeups(slot->host);
+			sdhci_enable_irq_wakeups(slot->host, SDHCI_WAKE_ON_INT);
 
 		pm_flags |= slot_pm_flags;
 	}
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 154cbf8..531033e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -37,7 +37,20 @@
 #define SDHCI_USE_LEDS_CLASS
 #endif
 
-static unsigned int debug_quirks = 0;
+static unsigned int debug_quirks;
+#ifdef CONFIG_PM
+static unsigned int wakeup_card_int;
+module_param(wakeup_card_int, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(wakeup_card_int, "Wake Up on Card interrupt event");
+
+static unsigned int wakeup_card_ins;
+module_param(wakeup_card_ins, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(wakeup_card_ins, "Wake UP on Card insertion event");
+
+static unsigned int wakeup_card_rem;
+module_param(wakeup_card_rem, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(wakeup_card_rem, "Wake UP on Card removal event");
+#endif /* CONFIG_PM */
 
 static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
 static void sdhci_finish_data(struct sdhci_host *);
@@ -1629,6 +1642,71 @@ out:
 
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
+	/*
+	 * Program the Wakeup Control register according to the event selected.
+	 * If there is no event (SDHCI_WAKE_UP_CONTROL = 0x0) so the device
+	 * won't be able to wake up the system.
+	 */
+	if (wakeup_card_int)
+		wakeflag |= SDHCI_WAKE_ON_INT;
+	if (wakeup_card_ins)
+		wakeflag |= SDHCI_WAKE_ON_INSERT;
+	if (wakeup_card_rem)
+		wakeflag |= SDHCI_WAKE_ON_REMOVE;
+
+	sdhci_enable_irq_wakeups(host, wakeflag);
+}
+
 int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 {
 	int ret;
@@ -1639,7 +1717,10 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 	if (ret)
 		return ret;
 
-	free_irq(host->irq, host);
+	if (device_may_wakeup(host->mmc->parent))
+		sdhci_set_wakeup(host);
+	else
+		free_irq(host->irq, host);
 
 	if (host->vmmc)
 		ret = regulator_disable(host->vmmc);
@@ -1665,11 +1746,12 @@ int sdhci_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-			  mmc_hostname(host->mmc), host);
-	if (ret)
-		return ret;
-
+	if (!(device_may_wakeup(host->mmc->parent))) {
+		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
+				  mmc_hostname(host->mmc), host);
+		if (ret)
+			return ret;
+	}
 	sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
 	mmiowb();
 
@@ -1681,11 +1763,11 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
-void sdhci_enable_irq_wakeups(struct sdhci_host *host)
+void sdhci_enable_irq_wakeups(struct sdhci_host *host, int mode)
 {
 	u8 val;
 	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
-	val |= SDHCI_WAKE_ON_INT;
+	val |= mode;
 	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
 }
 
@@ -1987,6 +2069,10 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_enable_card_detection(host);
 
+#ifdef CONFIG_PM
+	if (host->quirks & SDHCI_QUIRK_WANT_WAKEUP_ON_CARD)
+		sdhci_can_wakeup(host);
+#endif
 	return 0;
 
 #ifdef SDHCI_USE_LEDS_CLASS
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d52a716..1682542 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -320,7 +320,7 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
 extern int sdhci_resume_host(struct sdhci_host *host);
-extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
+extern void sdhci_enable_irq_wakeups(struct sdhci_host *host, int mode);
 #endif
 
 #endif /* __SDHCI_HW_H */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..8aa3c2e 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -83,6 +83,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+/* Controller wants to wakeup on card events, i.e. card ins, rem or int */
+#define SDHCI_QUIRK_WANT_WAKEUP_ON_CARD			(1<<30)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.5.5.6

