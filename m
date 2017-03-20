From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/25] mmc: sdhci-pci: Let devices define their own private data
Date: Mon, 20 Mar 2017 19:50:33 +0200
Message-ID: <1490032253-6030-6-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46805 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756158AbdCTR6M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:12 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Let devices define their own private data to facilitate device-specific
operations. The size of the private structure is specified in the
sdhci_pci_fixes structure, then sdhci_pci_probe_slot() will allocate extra
space for it, and sdhci_pci_priv() can be used to get a reference to it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 drivers/mmc/host/sdhci-pci.h      | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index b7150e935fb6..84b73cb22940 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1830,6 +1830,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
 	int ret, bar = first_bar + slotno;
+	size_t priv_size = chip->fixes ? chip->fixes->priv_size : 0;
 
 	if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "BAR %d is not iomem. Aborting.\n", bar);
@@ -1851,7 +1852,7 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		return ERR_PTR(-ENODEV);
 	}
 
-	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
+	host = sdhci_alloc_host(&pdev->dev, sizeof(*slot) + priv_size);
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
 		return ERR_CAST(host);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index e6e916b3361e..cfe519c0c990 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -70,6 +70,7 @@ struct sdhci_pci_fixes {
 	int			(*resume) (struct sdhci_pci_chip *);
 
 	const struct sdhci_ops	*ops;
+	size_t			priv_size;
 };
 
 struct sdhci_pci_slot {
@@ -89,6 +90,7 @@ struct sdhci_pci_slot {
 				     struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
 				     int card_drv, int *drv_type);
+	unsigned long		private[0] ____cacheline_aligned;
 };
 
 struct sdhci_pci_chip {
@@ -105,4 +107,9 @@ struct sdhci_pci_chip {
 	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
 };
 
+static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
+{
+	return (void *)slot->private;
+}
+
 #endif /* __SDHCI_PCI_H */
-- 
1.9.1

