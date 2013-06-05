From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/3] mmc: dw: convert to use pcim_* and devm_*
Date: Wed,  5 Jun 2013 12:24:12 +0300
Message-ID: <1370424252-31562-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21663 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753549Ab3FEJYS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jun 2013 05:24:18 -0400
In-Reply-To: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The PCI driver is getting simplier and tidier with pcim_* and devm_* functions
in use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pci.c | 50 +++++++++++++------------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index c469ce6..b456b0c 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -21,7 +21,6 @@
 #include "dw_mmc.h"
 
 #define PCI_BAR_NO 2
-#define COMPLETE_BAR 0
 #define SYNOPSYS_DW_MCI_VENDOR_ID 0x700
 #define SYNOPSYS_DW_MCI_DEVICE_ID 0x1107
 /* Defining the Capabilities */
@@ -38,51 +37,37 @@ static struct dw_mci_board pci_board_data = {
 };
 
 static int dw_mci_pci_probe(struct pci_dev *pdev,
-				  const struct pci_device_id *entries)
+			    const struct pci_device_id *entries)
 {
 	struct dw_mci *host;
 	int ret;
 
-	ret = pci_enable_device(pdev);
+	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
-	if (pci_request_regions(pdev, "dw_mmc_pci")) {
-		ret = -ENODEV;
-		goto err_disable_dev;
-	}
 
-	host = kzalloc(sizeof(struct dw_mci), GFP_KERNEL);
-	if (!host) {
-		ret = -ENOMEM;
-		goto err_release;
-	}
+	host = devm_kzalloc(&pdev->dev, sizeof(struct dw_mci), GFP_KERNEL);
+	if (!host)
+		return -ENOMEM;
 
 	host->irq = pdev->irq;
 	host->irq_flags = IRQF_SHARED;
 	host->dev = &pdev->dev;
 	host->pdata = &pci_board_data;
 
-	host->regs = pci_iomap(pdev, PCI_BAR_NO, COMPLETE_BAR);
-	if (!host->regs) {
-		ret = -EIO;
-		goto err_unmap;
-	}
+	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_NO, pci_name(pdev));
+	if (ret)
+		return ret;
+
+	host->regs = pcim_iomap_table(pdev)[0];
 
-	pci_set_drvdata(pdev, host);
 	ret = dw_mci_probe(host);
 	if (ret)
-		goto err_probe_failed;
-	return ret;
-
-err_probe_failed:
-	pci_iounmap(pdev, host->regs);
-err_unmap:
-	kfree(host);
-err_release:
-	pci_release_regions(pdev);
-err_disable_dev:
-	pci_disable_device(pdev);
-	return ret;
+		return ret;
+
+	pci_set_drvdata(pdev, host);
+
+	return 0;
 }
 
 static void dw_mci_pci_remove(struct pci_dev *pdev)
@@ -90,11 +75,6 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
 	struct dw_mci *host = pci_get_drvdata(pdev);
 
 	dw_mci_remove(host);
-	pci_set_drvdata(pdev, NULL);
-	pci_release_regions(pdev);
-	pci_iounmap(pdev, host->regs);
-	kfree(host);
-	pci_disable_device(pdev);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
1.8.2.rc0.22.gb3600c3

