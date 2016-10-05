From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: sdhci-pci: Let devices define their own sdhci_ops
Date: Wed,  5 Oct 2016 12:11:23 +0300
Message-ID: <1475658684-32312-4-git-send-email-adrian.hunter@intel.com>
References: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752488AbcJEJRG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 05:17:06 -0400
In-Reply-To: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

Let devices define their own sdhci_ops so that device-specific variations
can be implemented without adding quirks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 4 +++-
 drivers/mmc/host/sdhci-pci.h      | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 72a1f1f5180a..5e11e0e3be63 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1648,7 +1648,9 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	}
 
 	host->hw_name = "PCI";
-	host->ops = &sdhci_pci_ops;
+	host->ops = chip->fixes && chip->fixes->ops ?
+		    chip->fixes->ops :
+		    &sdhci_pci_ops;
 	host->quirks = chip->quirks;
 	host->quirks2 = chip->quirks2;
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 9c7c08b93223..6bccf56bc5ff 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -65,6 +65,8 @@ struct sdhci_pci_fixes {
 
 	int			(*suspend) (struct sdhci_pci_chip *);
 	int			(*resume) (struct sdhci_pci_chip *);
+
+	const struct sdhci_ops	*ops;
 };
 
 struct sdhci_pci_slot {
-- 
1.9.1

