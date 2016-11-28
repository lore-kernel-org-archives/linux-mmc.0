From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH v3 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for Intel byt sdio controller sub-vended by NI
Date: Mon, 28 Nov 2016 13:16:39 -0600
Message-ID: <1480360599-13295-3-git-send-email-zach.brown@ni.com>
References: <1480360599-13295-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:37937 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751569AbcK1TRf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Nov 2016 14:17:35 -0500
In-Reply-To: <1480360599-13295-1-git-send-email-zach.brown@ni.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com

On NI 9037 boards the max SDIO frequency is limited by trace lengths
and other layout choices. The max SDIO frequency is stored in an ACPI
table.

The driver reads the ACPI entry MXFQ during sdio_probe_slot and sets the
f_max field of the host.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
Reviewed-by: Jaeden Amero <jaeden.amero@ni.com>
Reviewed-by: Josh Cartwright <joshc@ni.com>
Signed-off-by: Zach Brown <zach.brown@ni.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 9741505..c9e51b1 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci-pci-data.h>
+#include <linux/acpi.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -375,8 +376,39 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static int ni_set_max_freq(struct sdhci_pci_slot *slot)
+{
+	acpi_status status;
+	unsigned long long max_freq;
+
+	status = acpi_evaluate_integer(ACPI_HANDLE(&slot->chip->pdev->dev),
+				       "MXFQ", NULL, &max_freq);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&slot->chip->pdev->dev,
+			"MXFQ not found in acpi table\n");
+		return -EINVAL;
+	}
+
+	slot->host->mmc->f_max = max_freq * 1000000;
+
+	return 0;
+}
+#else
+static inline int ni_set_max_freq(struct sdhci_pci_slot *slot)
+{
+	return 0;
+}
+#endif
+
 static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
+	int err;
+
+	err = ni_set_max_freq(slot);
+	if (err)
+		return err;
+
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
 				 MMC_CAP_WAIT_WHILE_BUSY;
 	return 0;
-- 
2.7.4

