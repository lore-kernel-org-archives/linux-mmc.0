From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: sdhci-pci: add platform data
Date: Fri, 28 Oct 2011 12:33:56 +0300
Message-ID: <1319794437-16870-4-git-send-email-adrian.hunter@intel.com>
References: <1319794437-16870-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62681 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145Ab1J1JeI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 28 Oct 2011 05:34:08 -0400
In-Reply-To: <1319794437-16870-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Add a means of getting platform data for the SDHCI PCI
devices.  The data is stored against the slot not the
device in order to support multi-slot devices.

The data allows platform-specific setup (such as getting
GPIO numbers from firmware or setting up wl12xx for SDIO)
to be done in platform support files instead of the
sdhci-pci driver.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci.c       |   32 ++++++++++++++++++++++++++++----
 include/linux/mmc/sdhci-pci-data.h |   18 ++++++++++++++++++
 2 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/mmc/sdhci-pci-data.h

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d833d9c..4f380e4 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/sfi.h>
 #include <linux/pm_runtime.h>
+#include <linux/mmc/sdhci-pci-data.h>
 
 #include "sdhci.h"
 
@@ -62,6 +63,7 @@ struct sdhci_pci_fixes {
 struct sdhci_pci_slot {
 	struct sdhci_pci_chip	*chip;
 	struct sdhci_host	*host;
+	struct sdhci_pci_data	*data;
 
 	int			pci_bar;
 	int			rst_n_gpio;
@@ -1188,11 +1190,12 @@ static const struct dev_pm_ops sdhci_pci_pm_ops = {
 \*****************************************************************************/
 
 static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
-	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int bar)
+	struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
+	int slotno)
 {
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
-	int ret;
+	int ret, bar = first_bar + slotno;
 
 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
@@ -1227,6 +1230,20 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 	slot->pci_bar = bar;
 	slot->rst_n_gpio = -EINVAL;
 
+	/* Retrieve platform data if there is any */
+	if (sdhci_pci_get_data)
+		slot->data = sdhci_pci_get_data(pdev, slotno);
+
+	if (slot->data) {
+		if (slot->data->setup) {
+			ret = slot->data->setup(slot->data);
+			if (ret) {
+				dev_err(&pdev->dev, "platform setup failed\n");
+				goto free;
+			}
+		}
+	}
+
 	host->hw_name = "PCI";
 	host->ops = &sdhci_pci_ops;
 	host->quirks = chip->quirks;
@@ -1236,7 +1253,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 	ret = pci_request_region(pdev, bar, mmc_hostname(host->mmc));
 	if (ret) {
 		dev_err(&pdev->dev, "cannot request region\n");
-		goto free;
+		goto cleanup;
 	}
 
 	host->ioaddr = pci_ioremap_bar(pdev, bar);
@@ -1270,6 +1287,10 @@ unmap:
 release:
 	pci_release_region(pdev, bar);
 
+cleanup:
+	if (slot->data && slot->data->cleanup)
+		slot->data->cleanup(slot->data);
+
 free:
 	sdhci_free_host(host);
 
@@ -1291,6 +1312,9 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
 
+	if (slot->data && slot->data->cleanup)
+		slot->data->cleanup(slot->data);
+
 	pci_release_region(slot->chip->pdev, slot->pci_bar);
 
 	sdhci_free_host(slot->host);
@@ -1377,7 +1401,7 @@ static int __devinit sdhci_pci_probe(struct pci_dev *pdev,
 	slots = chip->num_slots;	/* Quirk may have changed this */
 
 	for (i = 0; i < slots; i++) {
-		slot = sdhci_pci_probe_slot(pdev, chip, first_bar + i);
+		slot = sdhci_pci_probe_slot(pdev, chip, first_bar, i);
 		if (IS_ERR(slot)) {
 			for (i--; i >= 0; i--)
 				sdhci_pci_remove_slot(chip->slots[i]);
diff --git a/include/linux/mmc/sdhci-pci-data.h b/include/linux/mmc/sdhci-pci-data.h
new file mode 100644
index 0000000..65c57850
--- /dev/null
+++ b/include/linux/mmc/sdhci-pci-data.h
@@ -0,0 +1,18 @@
+#ifndef LINUX_MMC_SDHCI_PCI_DATA_H
+#define LINUX_MMC_SDHCI_PCI_DATA_H
+
+struct pci_dev;
+
+struct sdhci_pci_data {
+	struct pci_dev	*pdev;
+	int		slotno;
+	int		rst_n_gpio; /* Set to -EINVAL if unused */
+	int		cd_gpio;    /* Set to -EINVAL if unused */
+	int		(*setup)(struct sdhci_pci_data *data);
+	void		(*cleanup)(struct sdhci_pci_data *data);
+};
+
+extern struct sdhci_pci_data * __weak sdhci_pci_get_data(struct pci_dev *pdev,
+							 int slotno);
+
+#endif
-- 
1.7.6.4

