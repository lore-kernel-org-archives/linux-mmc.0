Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628B2C43217
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5061251
	for <linux-mmc@archiver.kernel.org>; Tue,  5 Oct 2021 10:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhJEK01 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:26:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:25954 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233966AbhJEK0Z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 5 Oct 2021 06:26:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="226017920"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="226017920"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 03:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="487971241"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2021 03:24:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1510D2FC; Tue,  5 Oct 2021 13:24:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v1 4/6] mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
Date:   Tue,  5 Oct 2021 13:24:28 +0300
Message-Id: <20211005102430.63716-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The last user of this struct gone couple of releases ago. Besides that
there were not so many users of this API for 10+ years: one is
implied above Intel Merrifield (added 2016-08-31, removed 2021-02-11),
and another is Intel Sunrisepoint (added 2015-02-06, removed 2017-03-20).

Effectively this is a revert of the commit 52c506f0bc72 ("mmc: sdhci-pci:
add platform data").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/host/Makefile          |  1 -
 drivers/mmc/host/sdhci-pci-core.c  | 31 ++++--------------------------
 drivers/mmc/host/sdhci-pci-data.c  |  6 ------
 drivers/mmc/host/sdhci-pci.h       |  1 -
 include/linux/mmc/sdhci-pci-data.h | 18 -----------------
 5 files changed, 4 insertions(+), 53 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
 delete mode 100644 include/linux/mmc/sdhci-pci-data.h

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 14004cc09aaa..ea36d379bd3c 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
-obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
 obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
 obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
 obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 30caa0b325de..8d01285e1b32 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -17,8 +17,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/device.h>
-#include <linux/mmc/host.h>
-#include <linux/mmc/mmc.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -26,11 +24,13 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/debugfs.h>
-#include <linux/mmc/slot-gpio.h>
-#include <linux/mmc/sdhci-pci-data.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
 
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+
 #ifdef CONFIG_X86
 #include <asm/iosf_mbi.h>
 #endif
@@ -2116,22 +2116,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 	slot->cd_gpio = -EINVAL;
 	slot->cd_idx = -1;
 
-	/* Retrieve platform data if there is any */
-	if (*sdhci_pci_get_data)
-		slot->data = sdhci_pci_get_data(pdev, slotno);
-
-	if (slot->data) {
-		if (slot->data->setup) {
-			ret = slot->data->setup(slot->data);
-			if (ret) {
-				dev_err(&pdev->dev, "platform setup failed\n");
-				goto free;
-			}
-		}
-		slot->rst_n_gpio = slot->data->rst_n_gpio;
-		slot->cd_gpio = slot->data->cd_gpio;
-	}
-
 	host->hw_name = "PCI";
 	host->ops = chip->fixes && chip->fixes->ops ?
 		    chip->fixes->ops :
@@ -2218,10 +2202,6 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		chip->fixes->remove_slot(slot, 0);
 
 cleanup:
-	if (slot->data && slot->data->cleanup)
-		slot->data->cleanup(slot->data);
-
-free:
 	sdhci_free_host(host);
 
 	return ERR_PTR(ret);
@@ -2244,9 +2224,6 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 	if (slot->chip->fixes && slot->chip->fixes->remove_slot)
 		slot->chip->fixes->remove_slot(slot, dead);
 
-	if (slot->data && slot->data->cleanup)
-		slot->data->cleanup(slot->data);
-
 	sdhci_free_host(slot->host);
 }
 
diff --git a/drivers/mmc/host/sdhci-pci-data.c b/drivers/mmc/host/sdhci-pci-data.c
deleted file mode 100644
index 18638fb363d8..000000000000
--- a/drivers/mmc/host/sdhci-pci-data.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/module.h>
-#include <linux/mmc/sdhci-pci-data.h>
-
-struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev, int slotno);
-EXPORT_SYMBOL_GPL(sdhci_pci_get_data);
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 8f90c4163bb5..15b36cd47860 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -156,7 +156,6 @@ struct sdhci_pci_fixes {
 struct sdhci_pci_slot {
 	struct sdhci_pci_chip	*chip;
 	struct sdhci_host	*host;
-	struct sdhci_pci_data	*data;
 
 	int			rst_n_gpio;
 	int			cd_gpio;
diff --git a/include/linux/mmc/sdhci-pci-data.h b/include/linux/mmc/sdhci-pci-data.h
deleted file mode 100644
index 1d42872d22f3..000000000000
--- a/include/linux/mmc/sdhci-pci-data.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef LINUX_MMC_SDHCI_PCI_DATA_H
-#define LINUX_MMC_SDHCI_PCI_DATA_H
-
-struct pci_dev;
-
-struct sdhci_pci_data {
-	struct pci_dev	*pdev;
-	int		slotno;
-	int		rst_n_gpio; /* Set to -EINVAL if unused */
-	int		cd_gpio;    /* Set to -EINVAL if unused */
-	int		(*setup)(struct sdhci_pci_data *data);
-	void		(*cleanup)(struct sdhci_pci_data *data);
-};
-
-extern struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev,
-				int slotno);
-#endif
-- 
2.33.0

