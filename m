From: Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH 1/4] sdhci: add slot number into sdhci_host structure
Date: Fri, 12 Oct 2012 11:12:38 +0800
Message-ID: <1350011561-21039-2-git-send-email-aaron.lu@intel.com>
References: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56528 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087Ab2JLDMv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Oct 2012 23:12:51 -0400
In-Reply-To: <1350011561-21039-1-git-send-email-aaron.lu@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Per the SDHCI spec, a SD host controller can have multiple slots, and
each slot corresponds to a sdhci_host structure.

This patch adds the slot number information to the sdhci_host structure,
this will be used in the following patch to bind a sdio card to an acpi
node.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/mmc/host/sdhci-pci.c   | 2 +-
 drivers/mmc/host/sdhci-pltfm.c | 4 ++--
 drivers/mmc/host/sdhci-s3c.c   | 2 +-
 drivers/mmc/host/sdhci-spear.c | 4 ++--
 drivers/mmc/host/sdhci.c       | 3 ++-
 drivers/mmc/host/sdhci.h       | 2 +-
 include/linux/mmc/sdhci.h      | 1 +
 7 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 3f0794e..f9da09f 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1211,7 +1211,7 @@ static struct sdhci_pci_slot * __devinit sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}
 
-	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
+	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot), slotno);
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
 		return ERR_CAST(host);
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 65551a9..9a07b86 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -116,9 +116,9 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 
 	/* Some PCI-based MFD need the parent here */
 	if (pdev->dev.parent != &platform_bus && !np)
-		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
+		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host), 0);
 	else
-		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
+		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host), 0);
 
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..d689a8a 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -569,7 +569,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
+	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c), 0);
 	if (IS_ERR(host)) {
 		dev_err(dev, "sdhci_alloc_host() failed\n");
 		return PTR_ERR(host);
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 423da81..4825bef 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -115,9 +115,9 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
 	pdev->dev.platform_data = sdhci;
 
 	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
+		host = sdhci_alloc_host(pdev->dev.parent, 0, 0);
 	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
+		host = sdhci_alloc_host(&pdev->dev, 0, 0);
 
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0e15c79..f4f51d1a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2622,7 +2622,7 @@ EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
 \*****************************************************************************/
 
 struct sdhci_host *sdhci_alloc_host(struct device *dev,
-	size_t priv_size)
+	size_t priv_size, int slotno)
 {
 	struct mmc_host *mmc;
 	struct sdhci_host *host;
@@ -2635,6 +2635,7 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
+	host->slotno = slotno;
 
 	return host;
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 97653ea..86d7ec6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -365,7 +365,7 @@ static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
 #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
 
 extern struct sdhci_host *sdhci_alloc_host(struct device *dev,
-	size_t priv_size);
+	size_t priv_size, int slotno);
 extern void sdhci_free_host(struct sdhci_host *host);
 
 static inline void *sdhci_priv(struct sdhci_host *host)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index fa8529a..3f3a508 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -18,6 +18,7 @@
 #include <linux/mmc/host.h>
 
 struct sdhci_host {
+	int slotno;	/* slot number of this host */
 	/* Data set by hardware interface driver */
 	const char *hw_name;	/* Hardware bus name */
 
-- 
1.7.12.21.g871e293

