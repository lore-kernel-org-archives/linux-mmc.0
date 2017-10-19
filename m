From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci-acpi: Fix voltage switch for some Intel host controllers
Date: Thu, 19 Oct 2017 13:41:46 +0300
Message-ID: <1508409706-27026-5-git-send-email-adrian.hunter@intel.com>
References: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21701 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751967AbdJSKsn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Oct 2017 06:48:43 -0400
In-Reply-To: <1508409706-27026-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Some Intel host controllers use an ACPI device-specific method to ensure
correct voltage switching. Fix voltage switch for those, by adding a call
to the DSM.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 5bb5880403b2..b988997a1e80 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -96,6 +96,105 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 	return c->slot && (c->slot->flags & flag);
 }
 
+enum {
+	INTEL_DSM_FNS		=  0,
+	INTEL_DSM_V18_SWITCH	=  3,
+	INTEL_DSM_V33_SWITCH	=  4,
+};
+
+struct intel_host {
+	u32	dsm_fns;
+};
+
+static const guid_t intel_dsm_guid =
+	GUID_INIT(0xF6C13EA5, 0x65CD, 0x461F,
+		  0xAB, 0x7A, 0x29, 0xF7, 0xE8, 0xD5, 0xBD, 0x61);
+
+static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
+		       unsigned int fn, u32 *result)
+{
+	union acpi_object *obj;
+	int err = 0;
+
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL);
+	if (!obj)
+		return -EOPNOTSUPP;
+
+	if (obj->type == ACPI_TYPE_INTEGER) {
+		*result = obj->integer.value;
+	} else if (obj->type == ACPI_TYPE_BUFFER && obj->buffer.length > 0) {
+		size_t len = min_t(size_t, obj->buffer.length, 4);
+
+		*result = 0;
+		memcpy(result, obj->buffer.pointer, len);
+	} else {
+		dev_err(dev, "%s DSM fn %u obj->type %d obj->buffer.length %d\n",
+			__func__, fn, obj->type, obj->buffer.length);
+		err = -EINVAL;
+	}
+
+	ACPI_FREE(obj);
+
+	return err;
+}
+
+static int intel_dsm(struct intel_host *intel_host, struct device *dev,
+		     unsigned int fn, u32 *result)
+{
+	if (fn > 31 || !(intel_host->dsm_fns & (1 << fn)))
+		return -EOPNOTSUPP;
+
+	return __intel_dsm(intel_host, dev, fn, result);
+}
+
+static void intel_dsm_init(struct intel_host *intel_host, struct device *dev,
+			   struct mmc_host *mmc)
+{
+	int err;
+
+	err = __intel_dsm(intel_host, dev, INTEL_DSM_FNS, &intel_host->dsm_fns);
+	if (err) {
+		pr_debug("%s: DSM not supported, error %d\n",
+			 mmc_hostname(mmc), err);
+		return;
+	}
+
+	pr_debug("%s: DSM function mask %#x\n",
+		 mmc_hostname(mmc), intel_host->dsm_fns);
+}
+
+static int intel_start_signal_voltage_switch(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct device *dev = mmc_dev(mmc);
+	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
+	struct intel_host *intel_host = sdhci_acpi_priv(c);
+	unsigned int fn;
+	u32 result = 0;
+	int err;
+
+	err = sdhci_start_signal_voltage_switch(mmc, ios);
+	if (err)
+		return err;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		fn = INTEL_DSM_V33_SWITCH;
+		break;
+	case MMC_SIGNAL_VOLTAGE_180:
+		fn = INTEL_DSM_V18_SWITCH;
+		break;
+	default:
+		return 0;
+	}
+
+	err = intel_dsm(intel_host, dev, fn, &result);
+	pr_debug("%s: %s DSM fn %u error %d result %u\n",
+		 mmc_hostname(mmc), __func__, fn, err, result);
+
+	return 0;
+}
+
 static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 {
 	u8 reg;
@@ -280,6 +379,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 			    const char *uid)
 {
 	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
+	struct intel_host *intel_host = sdhci_acpi_priv(c);
 	struct sdhci_host *host = c->host;
 
 	if (hid && uid && !strcmp(hid, "80860F14") && !strcmp(uid, "1") &&
@@ -290,6 +390,11 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 	if (hid && !strcmp(hid, "80865ACA"))
 		host->mmc_host_ops.get_cd = bxt_get_cd;
 
+	intel_dsm_init(intel_host, &pdev->dev, host->mmc);
+
+	host->mmc_host_ops.start_signal_voltage_switch =
+					intel_start_signal_voltage_switch;
+
 	return 0;
 }
 
@@ -304,6 +409,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 		   SDHCI_QUIRK2_STOP_WITH_TC |
 		   SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
 	.probe_slot	= intel_probe_slot,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
@@ -315,6 +421,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 	.flags   = SDHCI_ACPI_RUNTIME_PM,
 	.pm_caps = MMC_PM_KEEP_POWER,
 	.probe_slot	= intel_probe_slot,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
@@ -325,6 +432,7 @@ static int intel_probe_slot(struct platform_device *pdev, const char *hid,
 		   SDHCI_QUIRK2_STOP_WITH_TC,
 	.caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
 	.probe_slot	= intel_probe_slot,
+	.priv_size	= sizeof(struct intel_host),
 };
 
 static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd_3v = {
-- 
1.9.1

