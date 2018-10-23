From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 1/3] mmc: sdhci-pci: disable 1.8V with dmi quirk
Date: Tue, 23 Oct 2018 12:07:27 +0200
Message-ID: <20181023100729.28864-2-anisse@astier.eu>
References: <20181023100729.28864-1-anisse@astier.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023100729.28864-1-anisse@astier.eu>
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
List-Id: linux-mmc@vger.kernel.org

If the motherboard is known not to support 1.8V properly, add the
necessary quirk on probe.

This fixes an issue on a Gemini Lake (GLK) laptop : eMMC driver will
timeout on boot (from 60seconds to 10minutes ) as the cqhci attempts CQE
recovery after a failed voltage switch. In earlier kernels, the problem
existed, but only delayed boot for about 10 seconds after an I/O error,
allowing booting on the eMMC (almost) unnoticed.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/mmc/host/sdhci-pci-core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7bfd366d970d..396413f7c854 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/sdhci-pci-data.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "cqhci.h"
 
@@ -703,6 +704,16 @@ static int intel_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return 0;
 }
 
+static const struct dmi_system_id board_no_1_8v[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N75_77GU"),
+		},
+	},
+	{ }
+};
+
 static void byt_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
@@ -710,6 +721,12 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
 	byt_read_dsm(slot);
 
 	ops->execute_tuning = intel_execute_tuning;
+
+	if (dmi_check_system(board_no_1_8v)) {
+		pr_debug("%s: motherboard does not support 1.8V\n",
+				mmc_hostname(slot->host->mmc));
+		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+	}
 	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
 }
 
-- 
2.17.2
