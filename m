From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH] SDHCI: Properly enable SDIO IRQ wakeups
Date: Thu,  4 Nov 2010 22:20:39 +0000 (GMT)
Message-ID: <20101104222039.93AA69D401B@zog.reactivated.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:4834 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753376Ab0KDWwa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 18:52:30 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20101104222041.AZC29865.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>
          for <linux-mmc@vger.kernel.org>; Thu, 4 Nov 2010 22:20:41 +0000
Received: from zog.reactivated.net ([86.14.215.141])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20101104222041.JDRH20122.aamtaout01-winn.ispmail.ntl.com@zog.reactivated.net>
          for <linux-mmc@vger.kernel.org>; Thu, 4 Nov 2010 22:20:41 +0000
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org

A little more work was needed for SDIO IRQ wakeups to be functional.

Wake-on-WLAN on the SD WiFi adapter in the XO-1.5 laptop is now working.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/mmc/host/sdhci-pci.c |   11 +++++++++--
 drivers/mmc/host/sdhci.c     |   10 ++++++++++
 drivers/mmc/host/sdhci.h     |    4 ++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 55746ba..d196e77 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -637,6 +637,7 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_pci_slot *slot;
+	mmc_pm_flag_t slot_pm_flags;
 	mmc_pm_flag_t pm_flags = 0;
 	int i, ret;
 
@@ -657,7 +658,11 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 			return ret;
 		}
 
-		pm_flags |= slot->host->mmc->pm_flags;
+		slot_pm_flags = slot->host->mmc->pm_flags;
+		if (slot_pm_flags & MMC_PM_WAKE_SDIO_IRQ)
+			sdhci_enable_irq_wakeups(slot->host);
+
+		pm_flags |= slot_pm_flags;
 	}
 
 	if (chip->fixes && chip->fixes->suspend) {
@@ -671,8 +676,10 @@ static int sdhci_pci_suspend (struct pci_dev *pdev, pm_message_t state)
 
 	pci_save_state(pdev);
 	if (pm_flags & MMC_PM_KEEP_POWER) {
-		if (pm_flags & MMC_PM_WAKE_SDIO_IRQ)
+		if (pm_flags & MMC_PM_WAKE_SDIO_IRQ) {
+			pci_pme_active(pdev, true);
 			pci_enable_wake(pdev, PCI_D3hot, 1);
+		}
 		pci_set_power_state(pdev, PCI_D3hot);
 	} else {
 		pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..154cbf8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1681,6 +1681,16 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
+void sdhci_enable_irq_wakeups(struct sdhci_host *host)
+{
+	u8 val;
+	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
+	val |= SDHCI_WAKE_ON_INT;
+	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+}
+
+EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
+
 #endif /* CONFIG_PM */
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b7b8a3b..d52a716 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -87,6 +87,9 @@
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
 #define SDHCI_WAKE_UP_CONTROL	0x2B
+#define  SDHCI_WAKE_ON_INT	0x01
+#define  SDHCI_WAKE_ON_INSERT	0x02
+#define  SDHCI_WAKE_ON_REMOVE	0x04
 
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
@@ -317,6 +320,7 @@ extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state);
 extern int sdhci_resume_host(struct sdhci_host *host);
+extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
 #endif
 
 #endif /* __SDHCI_HW_H */
-- 
1.7.2.3

