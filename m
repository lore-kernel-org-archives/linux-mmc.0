From: Shyam Sundar S K <ssundark@amd.com>
Subject: [PATCH] mmc: sdhci-pci: Let devices define their own private data
Date: Wed, 9 Nov 2016 12:04:49 +0530
Message-ID: <14a1a029-9e91-2467-5bf0-f3b50b737b2b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:52191
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751226AbcKIGth (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Nov 2016 01:49:37 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Pankaj.Sen@amd.com, Nehal-bakulchandra.Shah@amd.com, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

Submitting the patch on behalf of Adrian.

Let devices define their own private data to facilitate device-specific
operations. The size of the private structure is specified in the
sdhci_pci_fixes structure,then sdhci_pci_probe_slot() will allocate extra
space for it, and sdhci_pci_priv() can be used to get a reference to it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 drivers/mmc/host/sdhci-pci.h      | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1d9e00a..782c8d2 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1646,6 +1646,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
 	int ret, bar = first_bar + slotno;
+	size_t priv_size = chip->fixes ? chip->fixes->priv_size : 0;

 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
@@ -1667,7 +1668,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}

-	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
+	host = sdhci_alloc_host(&pdev->dev, sizeof(*slot) + priv_size);
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
 		return ERR_CAST(host);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 6bccf56..0bfd568 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -67,6 +67,7 @@ struct sdhci_pci_fixes {
 	int			(*resume) (struct sdhci_pci_chip *);

 	const struct sdhci_ops	*ops;
+	size_t			priv_size;
 };

 struct sdhci_pci_slot {
@@ -87,6 +88,7 @@ struct sdhci_pci_slot {
 				     struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
 				     int card_drv, int *drv_type);
+	unsigned long		private[0] ____cacheline_aligned;
 };

 struct sdhci_pci_chip {
@@ -101,4 +103,9 @@ struct sdhci_pci_chip {
 	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
 };

+static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
+{
+	return (void *)slot->private;
+}
+
 #endif /* __SDHCI_PCI_H */
-- 
2.7.4
