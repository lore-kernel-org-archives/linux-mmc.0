From: Adam Lee <adam.lee@canonical.com>
Subject: [PATCH 1/2] mmc: sdhci-pci: break out definitions to header file
Date: Wed, 18 Dec 2013 22:23:38 +0800
Message-ID: <1387376619-8050-2-git-send-email-adam.lee@canonical.com>
References: <1387376619-8050-1-git-send-email-adam.lee@canonical.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:63577 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663Ab3LROX7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 09:23:59 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so8525785pbb.3
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 06:23:58 -0800 (PST)
In-Reply-To: <1387376619-8050-1-git-send-email-adam.lee@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Guo <peter.guo@bayhubtech.com>

Break out definitions in sdhci-pci.c to sdhci-pci.h, for introducing
module files like sdhci-pci-xxx.c

Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 drivers/mmc/host/sdhci-pci.c | 74 +-----------------------------------------
 drivers/mmc/host/sdhci-pci.h | 77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 73 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci.h

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 8f75381..af44659 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -27,79 +27,7 @@
 #include <linux/mmc/sdhci-pci-data.h>
 
 #include "sdhci.h"
-
-/*
- * PCI device IDs
- */
-#define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
-#define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
-#define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
-#define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
-#define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
-#define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50
-#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
-#define PCI_DEVICE_ID_INTEL_CLV_SDIO0	0x08f9
-#define PCI_DEVICE_ID_INTEL_CLV_SDIO1	0x08fa
-#define PCI_DEVICE_ID_INTEL_CLV_SDIO2	0x08fb
-#define PCI_DEVICE_ID_INTEL_CLV_EMMC0	0x08e5
-#define PCI_DEVICE_ID_INTEL_CLV_EMMC1	0x08e6
-
-/*
- * PCI registers
- */
-
-#define PCI_SDHCI_IFPIO			0x00
-#define PCI_SDHCI_IFDMA			0x01
-#define PCI_SDHCI_IFVENDOR		0x02
-
-#define PCI_SLOT_INFO			0x40	/* 8 bits */
-#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
-#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
-
-#define MAX_SLOTS			8
-
-struct sdhci_pci_chip;
-struct sdhci_pci_slot;
-
-struct sdhci_pci_fixes {
-	unsigned int		quirks;
-	unsigned int		quirks2;
-	bool			allow_runtime_pm;
-
-	int			(*probe) (struct sdhci_pci_chip *);
-
-	int			(*probe_slot) (struct sdhci_pci_slot *);
-	void			(*remove_slot) (struct sdhci_pci_slot *, int);
-
-	int			(*suspend) (struct sdhci_pci_chip *);
-	int			(*resume) (struct sdhci_pci_chip *);
-};
-
-struct sdhci_pci_slot {
-	struct sdhci_pci_chip	*chip;
-	struct sdhci_host	*host;
-	struct sdhci_pci_data	*data;
-
-	int			pci_bar;
-	int			rst_n_gpio;
-	int			cd_gpio;
-	int			cd_irq;
-
-	void (*hw_reset)(struct sdhci_host *host);
-};
-
-struct sdhci_pci_chip {
-	struct pci_dev		*pdev;
-
-	unsigned int		quirks;
-	unsigned int		quirks2;
-	bool			allow_runtime_pm;
-	const struct sdhci_pci_fixes *fixes;
-
-	int			num_slots;	/* Slots on controller */
-	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
-};
-
+#include "sdhci-pci.h"
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
new file mode 100644
index 0000000..0347804
--- /dev/null
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -0,0 +1,77 @@
+#ifndef __SDHCI_PCI_H
+#define __SDHCI_PCI_H
+
+/*
+ * PCI device IDs
+ */
+
+#define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
+#define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
+#define PCI_DEVICE_ID_INTEL_BYT_EMMC	0x0f14
+#define PCI_DEVICE_ID_INTEL_BYT_SDIO	0x0f15
+#define PCI_DEVICE_ID_INTEL_BYT_SD	0x0f16
+#define PCI_DEVICE_ID_INTEL_BYT_EMMC2	0x0f50
+#define PCI_DEVICE_ID_INTEL_MRFL_MMC	0x1190
+#define PCI_DEVICE_ID_INTEL_CLV_SDIO0	0x08f9
+#define PCI_DEVICE_ID_INTEL_CLV_SDIO1	0x08fa
+#define PCI_DEVICE_ID_INTEL_CLV_SDIO2	0x08fb
+#define PCI_DEVICE_ID_INTEL_CLV_EMMC0	0x08e5
+#define PCI_DEVICE_ID_INTEL_CLV_EMMC1	0x08e6
+
+/*
+ * PCI registers
+ */
+
+#define PCI_SDHCI_IFPIO			0x00
+#define PCI_SDHCI_IFDMA			0x01
+#define PCI_SDHCI_IFVENDOR		0x02
+
+#define PCI_SLOT_INFO			0x40	/* 8 bits */
+#define  PCI_SLOT_INFO_SLOTS(x)		((x >> 4) & 7)
+#define  PCI_SLOT_INFO_FIRST_BAR_MASK	0x07
+
+#define MAX_SLOTS			8
+
+struct sdhci_pci_chip;
+struct sdhci_pci_slot;
+
+struct sdhci_pci_fixes {
+	unsigned int		quirks;
+	unsigned int		quirks2;
+	bool			allow_runtime_pm;
+
+	int			(*probe) (struct sdhci_pci_chip *);
+
+	int			(*probe_slot) (struct sdhci_pci_slot *);
+	void			(*remove_slot) (struct sdhci_pci_slot *, int);
+
+	int			(*suspend) (struct sdhci_pci_chip *);
+	int			(*resume) (struct sdhci_pci_chip *);
+};
+
+struct sdhci_pci_slot {
+	struct sdhci_pci_chip	*chip;
+	struct sdhci_host	*host;
+	struct sdhci_pci_data	*data;
+
+	int			pci_bar;
+	int			rst_n_gpio;
+	int			cd_gpio;
+	int			cd_irq;
+
+	void (*hw_reset)(struct sdhci_host *host);
+};
+
+struct sdhci_pci_chip {
+	struct pci_dev		*pdev;
+
+	unsigned int		quirks;
+	unsigned int		quirks2;
+	bool			allow_runtime_pm;
+	const struct sdhci_pci_fixes *fixes;
+
+	int			num_slots;	/* Slots on controller */
+	struct sdhci_pci_slot	*slots[MAX_SLOTS]; /* Pointers to host slots */
+};
+
+#endif /* __SDHCI_PCI_H */
-- 
1.8.5.2

