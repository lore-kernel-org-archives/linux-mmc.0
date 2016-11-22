From: Zach Brown <zach.brown@ni.com>
Subject: [PATCH v2 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for Intel byt sdio controller sub-vended by NI
Date: Tue, 22 Nov 2016 15:53:22 -0600
Message-ID: <1479851602-19788-3-git-send-email-zach.brown@ni.com>
References: <1479851602-19788-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479851602-19788-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, zach.brown@ni.com
List-Id: linux-mmc@vger.kernel.org

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
 drivers/mmc/host/sdhci-pci-core.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 9741505..34284b8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci-pci-data.h>
+#include <linux/acpi.h>
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
@@ -375,6 +376,30 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
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
+	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
+				 MMC_CAP_WAIT_WHILE_BUSY;
+	return 0;
+}
+
+#else
+
 static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
@@ -382,6 +407,9 @@ static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+#endif
+
+
 static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->mmc->caps |= MMC_CAP_POWER_OFF_CARD | MMC_CAP_NONREMOVABLE |
-- 
2.7.4
