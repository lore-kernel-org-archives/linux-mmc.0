From: Jackey Shen <Jackey.Shen@amd.com>
Subject: [PATCH V4] mmc: sdhci: supporting PCI MSI
Date: Mon, 25 Nov 2013 10:32:10 +0800
Message-ID: <1385346730-9502-1-git-send-email-Jackey.Shen@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:46060
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753267Ab3KYCdG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Nov 2013 21:33:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: alexander.stein@systec-electronic.com, manuel.lauss@googlemail.com, hanfi@spahan.ch, aaron.lu@intel.com, linux-mmc@vger.kernel.org
Cc: mcuos.com@gmail.com, Ray.Huang@amd.com, Jackey Shen <Jackey.Shen@amd.com>

Enable MSI support in sdhci-pci driver and provide the mechanism
to fall back to Legacy Pin-based Interrupt if MSI register fails.
That is, sdhci-pci driver first checks and enables MSI. If error occurs,
it will fall to use Legacy Pin-based Interrupt.

Tested with SD cards on AMD platform.

Signed-off-by: Jackey Shen <Jackey.Shen@amd.com>
---
This patch is based on the patches e6039832 and 210b7d28 and applies to
the mmc-next branch.

NOTE:
If SD host controllers support and enable PCI MSI successfully, but doesn't
function well, the kind of patch like patch 210b7d28 should be added.

V4:
- update host->irq right after enabling MSI successfully or not

V3:
- clarify and tidy source code logic
- export sdhci_irq function to be used in sdhci-pci driver

V2:
- implement this PCI MSI feature in sdhci-pci.c instead of sdhci.c
---
 drivers/mmc/host/sdhci-pci.c | 56 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.c     | 27 ++++++++++++---------
 drivers/mmc/host/sdhci.h     |  1 +
 include/linux/mmc/sdhci.h    |  2 ++
 4 files changed, 73 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 8f75381..b9dd9bd 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1143,6 +1143,48 @@ static void sdhci_pci_hw_reset(struct sdhci_host *host)
 		slot->hw_reset(host);
 }
 
+static int sdhci_pci_enable_msi(struct sdhci_host *host)
+{
+	int ret;
+	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
+
+	if (!host->msi_enabled) {
+		ret = pci_enable_msi(pdev);
+		if (ret) {
+			dev_warn(&pdev->dev, "Fail to allocate MSI entry\n");
+			host->irq = pdev->irq;
+			host->msi_enabled = false;
+			return ret;
+		}
+	}
+
+	ret = request_irq(pdev->irq, sdhci_irq, 0,
+		mmc_hostname(host->mmc), host);
+	if (ret) {
+		dev_warn(&pdev->dev, "Fail to request MSI IRQ %d: %d\n",
+		       pdev->irq, ret);
+		pci_disable_msi(pdev);
+		host->irq = pdev->irq;
+		host->msi_enabled = false;
+		return ret;
+	}
+
+	host->irq = pdev->irq;
+	host->msi_enabled = true;
+	return ret;
+}
+
+static void sdhci_pci_disable_msi(struct sdhci_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->mmc->parent);
+
+	if (host->msi_enabled) {
+		pci_disable_msi(pdev);
+		host->irq = pdev->irq;
+		host->msi_enabled = false;
+	}
+}
+
 static const struct sdhci_ops sdhci_pci_ops = {
 	.enable_dma	= sdhci_pci_enable_dma,
 	.platform_bus_width	= sdhci_pci_bus_width,
@@ -1242,6 +1284,10 @@ static int sdhci_pci_resume(struct device *dev)
 		if (!slot)
 			continue;
 
+		ret = sdhci_pci_enable_msi(slot->host);
+		if (ret)
+			dev_warn(&pdev->dev, "Fall back to Pin-based Interrupt: %d\n", ret);
+
 		ret = sdhci_resume_host(slot->host);
 		if (ret)
 			return ret;
@@ -1415,8 +1461,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	host->quirks = chip->quirks;
 	host->quirks2 = chip->quirks2;
 
-	host->irq = pdev->irq;
-
 	ret = pci_request_region(pdev, bar, mmc_hostname(host->mmc));
 	if (ret) {
 		dev_err(&pdev->dev, "cannot request region\n");
@@ -1436,6 +1480,10 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 			goto unmap;
 	}
 
+	ret = sdhci_pci_enable_msi(host);
+	if (ret)
+		dev_warn(&pdev->dev, "Fall back to Pin-based Interrupt: %d\n", ret);
+
 	if (gpio_is_valid(slot->rst_n_gpio)) {
 		if (!gpio_request(slot->rst_n_gpio, "eMMC_reset")) {
 			gpio_direction_output(slot->rst_n_gpio, 1);
@@ -1463,6 +1511,8 @@ remove:
 	if (gpio_is_valid(slot->rst_n_gpio))
 		gpio_free(slot->rst_n_gpio);
 
+	sdhci_pci_disable_msi(host);
+
 	if (chip->fixes && chip->fixes->remove_slot)
 		chip->fixes->remove_slot(slot, 0);
 
@@ -1499,6 +1549,8 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (gpio_is_valid(slot->rst_n_gpio))
 		gpio_free(slot->rst_n_gpio);
 
+	sdhci_pci_disable_msi(slot->host);
+
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bd8a098..bd64825 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2412,7 +2412,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	}
 }
 
-static irqreturn_t sdhci_irq(int irq, void *dev_id)
+irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result;
 	struct sdhci_host *host = dev_id;
@@ -2527,6 +2527,7 @@ out:
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(sdhci_irq);
 
 /*****************************************************************************\
  *                                                                           *
@@ -2597,10 +2598,12 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-				  mmc_hostname(host->mmc), host);
-		if (ret)
-			return ret;
+		if (!host->msi_enabled) {
+			ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
+					  mmc_hostname(host->mmc), host);
+			if (ret)
+				return ret;
+		}
 	} else {
 		sdhci_disable_irq_wakeups(host);
 		disable_irq_wake(host->irq);
@@ -3220,12 +3223,14 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-		mmc_hostname(mmc), host);
-	if (ret) {
-		pr_err("%s: Failed to request IRQ %d: %d\n",
-		       mmc_hostname(mmc), host->irq, ret);
-		goto untasklet;
+	if (!host->msi_enabled) {
+		ret = request_irq(host->irq, sdhci_irq,	IRQF_SHARED,
+				mmc_hostname(host->mmc), host);
+		if (ret) {
+			pr_err("%s: Failed to request IRQ %d: %d\n",
+				mmc_hostname(mmc), host->irq, ret);
+			goto untasklet;
+		}
 	}
 
 #ifdef CONFIG_MMC_DEBUG
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a3ed01..597e53d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -396,6 +396,7 @@ extern int sdhci_add_host(struct sdhci_host *host);
 extern void sdhci_remove_host(struct sdhci_host *host, int dead);
 extern void sdhci_send_command(struct sdhci_host *host,
 				struct mmc_command *cmd);
+extern irqreturn_t sdhci_irq(int irq, void *dev_id);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 3e781b8..e36b74f 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -99,6 +99,8 @@ struct sdhci_host {
 /* Controller has a non-standard host control register */
 #define SDHCI_QUIRK2_BROKEN_HOST_CONTROL		(1<<5)
 
+	bool msi_enabled;	/* PCI MSI is enabled or not */
+
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
 
-- 
1.8.1.2


