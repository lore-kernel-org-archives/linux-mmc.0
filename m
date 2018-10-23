From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 3/3] mmc: sdhci-pci: only install voltage switch method when useful
Date: Tue, 23 Oct 2018 12:07:29 +0200
Message-ID: <20181023100729.28864-4-anisse@astier.eu>
References: <20181023100729.28864-1-anisse@astier.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023100729.28864-1-anisse@astier.eu>
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
List-Id: linux-mmc@vger.kernel.org

If there's no ACPI DSM for voltage switch, it will just cause a lot of
debug info down the line, we only need one at startup.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/mmc/host/sdhci-pci-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index f2c1fb339d66..95fdbb883c7e 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -723,6 +723,7 @@ static const struct dmi_system_id board_no_1_8v[] = {
 static void byt_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
+	struct intel_host *intel_host = sdhci_pci_priv(slot);
 
 	byt_read_dsm(slot);
 
@@ -733,6 +734,16 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
 				mmc_hostname(slot->host->mmc));
 		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
+	/* Check if we have the appropriate voltage switch DSM methods */
+	if (!(intel_host->dsm_fns & (1 << INTEL_DSM_V18_SWITCH)) &&
+	    !(intel_host->dsm_fns & (1 << INTEL_DSM_V33_SWITCH))) {
+		/* No voltage switching supported at all, there's no
+		 * point in installing the callback: return.
+		 */
+		pr_debug("%s: No voltage switching ACPI DSM helper\n",
+				mmc_hostname(slot->host->mmc));
+		return;
+	}
 	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
 }
 
-- 
2.17.2
