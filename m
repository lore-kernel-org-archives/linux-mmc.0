From: Jackey Shen <Jackey.Shen@amd.com>
Subject: [PATCH V2] mmc: sdhci: supporting PCI MSI
Date: Tue, 12 Nov 2013 14:56:53 +0800
Message-ID: <1384239413-7027-1-git-send-email-Jackey.Shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:55983 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751407Ab3KLG6O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Nov 2013 01:58:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alexander.stein@systec-electronic.com, manuel.lauss@googlemail.com, hanfi@spahan.ch, aaron.lu@intel.com, linux-mmc@vger.kernel.org
Cc: mcuos.com@gmail.com, Ray.Huang@amd.com, Jackey Shen <Jackey.Shen@amd.com>

Enable MSI support in sdhci-pci driver and provide the mechanism
to fall back to Legacy Pin-based Interrupt if MSI register fails.

Tested with SD cards on AMD platform.

Change from V1:
- implement this PCI MSI feature in sdhci-pci.c instead of sdhci.c

Signed-off-by: Jackey Shen <Jackey.Shen@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/mmc/host/Kconfig     | 11 +++++++++
 drivers/mmc/host/sdhci-pci.c | 58 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     | 42 ++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.h     |  2 ++
 include/linux/mmc/sdhci.h    |  2 ++
 5 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..a56cf27 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -68,6 +68,17 @@ config MMC_SDHCI_PCI
 
 	  If unsure, say N.
 
+config MMC_SDHCI_PCI_MSI
+	bool "SDHCI support with MSI on PCI bus"
+	depends on MMC_SDHCI_PCI && PCI_MSI
+	help
+	  This enables PCI MSI (Message Signaled Interrupts) for Secure
+	  Digital Host Controller Interface.
+
+	  If you have a controller with this capability, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_RICOH_MMC
 	bool "Ricoh MMC Controller Disabler"
 	depends on MMC_SDHCI_PCI
diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 8f75381..2ca29c0 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1143,10 +1143,68 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 		slot->hw_reset(host);
 }
 
+#ifdef CONFIG_MMC_SDHCI_PCI_MSI
+static int sdhci_pci_setup_msi(struct sdhci_host *host, irq_handler_t handler)
+{
+	int ret;
+	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
+
+	host->msi_enabled = false;
+
+	ret = pci_enable_msi(pdev);
+	if (ret) {
+		pr_warn("%s: Failed to allocate MSI entry\n",
+			mmc_hostname(host->mmc));
+		return ret;
+	}
+
+	ret = request_irq(pdev->irq, handler, 0,
+		mmc_hostname(host->mmc), host);
+	if (ret) {
+		pr_warn("%s: Failed to request MSI IRQ %d: %d\n",
+		       mmc_hostname(host->mmc), pdev->irq, ret);
+		pci_disable_msi(pdev);
+		return ret;
+	}
+
+	host->irq = pdev->irq;
+	host->msi_enabled = true;
+	return ret;
+}
+
+static int sdhci_pci_enable_msi(struct sdhci_host *host, irq_handler_t handler)
+{
+	return sdhci_pci_setup_msi(host, handler);
+}
+
+static void sdhci_pci_disable_msi(struct sdhci_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
+
+	if (host->msi_enabled) {
+		pci_disable_msi(pdev);
+		host->msi_enabled = false;
+	}
+}
+
+#else
+
+static int sdhci_pci_enable_msi(struct sdhci_host *host, irq_handler_t handler)
+{
+	return 0;
+}
+
+static void sdhci_pci_disable_msi(struct sdhci_host *host)
+{
+}
+#endif /* CONFIG_MMC_SDHCI_PCI_MSI */
+
 static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.platform_bus_width	= sdhci_pci_bus_width,
 	.hw_reset		= sdhci_pci_hw_reset,
+	.enable_msi		= sdhci_pci_enable_msi,
+	.disable_msi		= sdhci_pci_disable_msi,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6785fb1..4c2a1ac 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2554,6 +2554,31 @@ void sdhci_disable_irq_wakeups(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
+static int sdhci_request_irq(struct sdhci_host *host)
+{
+	int ret = 0;
+
+	/* try to enable MSI */
+	if (host->ops->enable_msi) {
+		ret = host->ops->enable_msi(host, sdhci_irq);
+		if (ret)
+			pr_warn("%s: Fall back to Pin-based Interrupt: %d\n",
+				mmc_hostname(host->mmc), ret);
+	}
+
+	if (!host->msi_enabled) {
+		/* fall back to legacy pin-based interrupt */
+		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
+				mmc_hostname(host->mmc), host);
+		if (ret) {
+			pr_err("%s: Failed to request IRQ %d: %d\n",
+				 mmc_hostname(host->mmc), host->irq, ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
 int sdhci_suspend_host(struct sdhci_host *host)
 {
 	if (host->ops->platform_suspend)
@@ -2570,6 +2595,8 @@ int sdhci_suspend_host(struct sdhci_host *host)
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
 		sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 		free_irq(host->irq, host);
+		if (host->ops->disable_msi)
+			host->ops->disable_msi(host);
 	} else {
 		sdhci_enable_irq_wakeups(host);
 		enable_irq_wake(host->irq);
@@ -2589,8 +2616,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-				  mmc_hostname(host->mmc), host);
+		ret = sdhci_request_irq(host);
 		if (ret)
 			return ret;
 	} else {
@@ -3212,13 +3238,9 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-		mmc_hostname(mmc), host);
-	if (ret) {
-		pr_err("%s: Failed to request IRQ %d: %d\n",
-		       mmc_hostname(mmc), host->irq, ret);
+	ret = sdhci_request_irq(host);
+	if (ret)
 		goto untasklet;
-	}
 
 #ifdef CONFIG_MMC_DEBUG
 	sdhci_dumpregs(host);
@@ -3258,6 +3280,8 @@ reset:
 	sdhci_reset(host, SDHCI_RESET_ALL);
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
+	if (host->ops->disable_msi)
+		host->ops->disable_msi(host);
 #endif
 untasklet:
 	tasklet_kill(&host->card_tasklet);
@@ -3301,6 +3325,8 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
+	if (host->ops->disable_msi)
+		host->ops->disable_msi(host);
 
 	del_timer_sync(&host->timer);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a3ed01..cbee843 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -296,6 +296,8 @@ struct sdhci_ops {
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
+	int	(*enable_msi)(struct sdhci_host *host, irq_handler_t handler);
+	void	(*disable_msi)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 3e781b8..3812479 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -99,6 +99,8 @@ struct sdhci_host {
 /* Controller has a non-standard host control register */
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
 
+	bool msi_enabled;	/* SD host controller with PCI MSI enabled */
+
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.8.1.2


