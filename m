From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/3] mmc: dw: eliminate useless usage of ret
Date: Wed,  5 Jun 2013 12:24:11 +0300
Message-ID: <1370424252-31562-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:53600 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753285Ab3FEJYS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jun 2013 05:24:18 -0400
In-Reply-To: <1370424252-31562-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In few places usage of ret variable is not needed. This patch simplifies that
pieces of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/dw_mmc-pci.c   |  8 ++------
 drivers/mmc/host/dw_mmc-pltfm.c | 17 +++--------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index 083fcd2..c469ce6 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -100,22 +100,18 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int dw_mci_pci_suspend(struct device *dev)
 {
-	int ret;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_mci *host = pci_get_drvdata(pdev);
 
-	ret = dw_mci_suspend(host);
-	return ret;
+	return dw_mci_suspend(host);
 }
 
 static int dw_mci_pci_resume(struct device *dev)
 {
-	int ret;
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dw_mci *host = pci_get_drvdata(pdev);
 
-	ret = dw_mci_resume(host);
-	return ret;
+	return dw_mci_resume(host);
 }
 #else
 #define dw_mci_pci_suspend	NULL
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 526abae..2721bd5 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -56,8 +56,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	}
 
 	platform_set_drvdata(pdev, host);
-	ret = dw_mci_probe(host);
-	return ret;
+	return dw_mci_probe(host);
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
@@ -81,26 +80,16 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_remove);
  */
 static int dw_mci_pltfm_suspend(struct device *dev)
 {
-	int ret;
 	struct dw_mci *host = dev_get_drvdata(dev);
 
-	ret = dw_mci_suspend(host);
-	if (ret)
-		return ret;
-
-	return 0;
+	return dw_mci_suspend(host);
 }
 
 static int dw_mci_pltfm_resume(struct device *dev)
 {
-	int ret;
 	struct dw_mci *host = dev_get_drvdata(dev);
 
-	ret = dw_mci_resume(host);
-	if (ret)
-		return ret;
-
-	return 0;
+	return dw_mci_resume(host);
 }
 #else
 #define dw_mci_pltfm_suspend	NULL
-- 
1.8.2.rc0.22.gb3600c3

