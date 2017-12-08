From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] mmc: sdhci-acpi: Avoid broken UHS transfer modes on Intel CHT
Date: Fri,  8 Dec 2017 15:08:18 +0200
Message-ID: <1512738498-5812-1-git-send-email-adrian.hunter@intel.com>
References: <1512738299-5650-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44814 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752990AbdLHNIl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Dec 2017 08:08:41 -0500
In-Reply-To: <1512738299-5650-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>

Intel DSM function 8 has been used to identify transfer modes that are not
working on some CHT boards. Add support for that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/mmc/host/sdhci-acpi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f7445cf8f7dd..264f10327bf9 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -97,14 +97,21 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 	return c->slot && (c->slot->flags & flag);
 }
 
+#define INTEL_DSM_HS_CAPS_SDR25		BIT(0)
+#define INTEL_DSM_HS_CAPS_DDR50		BIT(1)
+#define INTEL_DSM_HS_CAPS_SDR50		BIT(2)
+#define INTEL_DSM_HS_CAPS_SDR104	BIT(3)
+
 enum {
 	INTEL_DSM_FNS		=  0,
 	INTEL_DSM_V18_SWITCH	=  3,
 	INTEL_DSM_V33_SWITCH	=  4,
+	INTEL_DSM_HS_CAPS	=  8,
 };
 
 struct intel_host {
 	u32	dsm_fns;
+	u32	hs_caps;
 };
 
 static const guid_t intel_dsm_guid =
@@ -153,6 +160,8 @@ static void intel_dsm_init(struct intel_host *intel_host, struct device *dev,
 {
 	int err;
 
+	intel_host->hs_caps = ~0;
+
 	err = __intel_dsm(intel_host, dev, INTEL_DSM_FNS, &intel_host->dsm_fns);
 	if (err) {
 		pr_debug("%s: DSM not supported, error %d\n",
@@ -162,6 +171,8 @@ static void intel_dsm_init(struct intel_host *intel_host, struct device *dev,
 
 	pr_debug("%s: DSM function mask %#x\n",
 		 mmc_hostname(mmc), intel_host->dsm_fns);
+
+	intel_dsm(intel_host, dev, INTEL_DSM_HS_CAPS, &intel_host->hs_caps);
 }
 
 static int intel_start_signal_voltage_switch(struct mmc_host *mmc,
@@ -399,6 +410,26 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 	return 0;
 }
 
+static int intel_setup_host(struct platform_device *pdev)
+{
+	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct intel_host *intel_host = sdhci_acpi_priv(c);
+
+	if (!(intel_host->hs_caps & INTEL_DSM_HS_CAPS_SDR25))
+		c->host->mmc->caps &= ~MMC_CAP_UHS_SDR25;
+
+	if (!(intel_host->hs_caps & INTEL_DSM_HS_CAPS_SDR50))
+		c->host->mmc->caps &= ~MMC_CAP_UHS_SDR50;
+
+	if (!(intel_host->hs_caps & INTEL_DSM_HS_CAPS_DDR50))
+		c->host->mmc->caps &= ~MMC_CAP_UHS_DDR50;
+
+	if (!(intel_host->hs_caps & INTEL_DSM_HS_CAPS_SDR104))
+		c->host->mmc->caps &= ~MMC_CAP_UHS_SDR104;
+
+	return 0;
+}
+
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
 	.chip    = &sdhci_acpi_chip_int,
 	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE |
@@ -410,6 +441,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 		   SDHCI_QUIRK2_STOP_WITH_TC |
 		   SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
 	.probe_slot	= intel_probe_slot,
+	.setup_host	= intel_setup_host,
 	.priv_size	= sizeof(struct intel_host),
 };
 
@@ -422,6 +454,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
 	.probe_slot	= intel_probe_slot,
+	.setup_host	= intel_setup_host,
 	.priv_size	= sizeof(struct intel_host),
 };
 
@@ -433,6 +466,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
 	.probe_slot	= intel_probe_slot,
+	.setup_host	= intel_setup_host,
 	.priv_size	= sizeof(struct intel_host),
 };
 
-- 
1.9.1

