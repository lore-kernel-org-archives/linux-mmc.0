From: David Fries <david@fries.net>
Subject: [PATCH] sdhci-pci register legacy PCI PM or runtime PM not both
Date: Sun, 20 Nov 2011 15:29:51 -0600
Message-ID: <20111120212951.GA4577@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Yunpeng Gao <yunpeng.gao@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: David Fries <David@Fries.net>

pci_has_legacy_pm_support says to not register both legacy PM
and runtime PM callbacks, modified ifdefs.

Signed-off-by: David Fries <David@Fries.net>
Cc: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Yunpeng Gao <yunpeng.gao@intel.com>
---
 drivers/mmc/host/sdhci-pci.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index d833d9c..eca6e84 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -991,7 +991,8 @@ static struct sdhci_ops sdhci_pci_ops = {
  *                                                                           *
 \*****************************************************************************/
 
-#ifdef CONFIG_PM
+/* Register legacy PM or PM runtime, not both. */
+#if defined(CONFIG_PM) && !defined(CONFIG_PM_RUNTIME)
 
 static int sdhci_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
@@ -1085,12 +1086,12 @@ static int sdhci_pci_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#else /* CONFIG_PM */
+#else /* CONFIG_PM && !CONFIG_PM_RUNTIME */
 
 #define sdhci_pci_suspend NULL
 #define sdhci_pci_resume NULL
 
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && !CONFIG_PM_RUNTIME */
 
 #ifdef CONFIG_PM_RUNTIME
 
-- 
1.7.7.1
