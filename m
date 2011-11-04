From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Incorrect checkpatch warning
Date: Fri, 04 Nov 2011 10:00:52 +0200
Message-ID: <4EB39BB4.3060508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joe@perches.com
Cc: linux-kernel@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi

This checkpatch warning looks wrong:

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#73: FILE: drivers/mmc/host/sdhci-pci-data.c:5:
+EXPORT_SYMBOL_GPL(sdhci_pci_get_data);

The patch has this:

diff --git a/drivers/mmc/host/sdhci-pci-data.c b/drivers/mmc/host/sdhci-pci-data.c
new file mode 100644
index 0000000..a611217
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci-data.c
@@ -0,0 +1,5 @@
+#include <linux/module.h>
+#include <linux/mmc/sdhci-pci-data.h>
+
+struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev, int slotno);
+EXPORT_SYMBOL_GPL(sdhci_pci_get_data);


Regards
Adrian
