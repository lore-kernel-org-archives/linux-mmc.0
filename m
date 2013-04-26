From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/3] mmc: sdhci-acpi: add more device ids
Date: Fri, 26 Apr 2013 11:27:22 +0300
Message-ID: <1366964843-20413-3-git-send-email-adrian.hunter@intel.com>
References: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:54342 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758895Ab3DZIXG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 26 Apr 2013 04:23:06 -0400
In-Reply-To: <1366964843-20413-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

Add three more ACPI HIDs.  Also, as some devices must be
further distinguished by ACPI UID, slot information is now
associated with HID and UID.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 1da5f29..706d9cb 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -87,6 +87,12 @@ static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.enable_dma = sdhci_acpi_enable_dma,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
+	.caps    = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.caps2   = MMC_CAP2_HC_ERASE_SZ,
+	.flags   = SDHCI_ACPI_RUNTIME_PM,
+};
+
 static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
@@ -94,23 +100,67 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
 	.pm_caps = MMC_PM_KEEP_POWER,
 };
 
+static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
+};
+
+struct sdhci_acpi_uid_slot {
+	const char *hid;
+	const char *uid;
+	const struct sdhci_acpi_slot *slot;
+};
+
+static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
+	{ "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
+	{ "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
+	{ "INT33BB"  , "2" , &sdhci_acpi_slot_int_sdio },
+	{ "INT33C6"  , NULL, &sdhci_acpi_slot_int_sdio },
+	{ "PNP0D40"  },
+	{ },
+};
+
 static const struct acpi_device_id sdhci_acpi_ids[] = {
-	{ "INT33C6", (kernel_ulong_t)&sdhci_acpi_slot_int_sdio },
-	{ "PNP0D40" },
+	{ "80860F14" },
+	{ "INT33BB"  },
+	{ "INT33C6"  },
+	{ "PNP0D40"  },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
-static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid)
+static const struct sdhci_acpi_slot *sdhci_acpi_get_slot_by_ids(const char *hid,
+								const char *uid)
 {
-	const struct acpi_device_id *id;
-
-	for (id = sdhci_acpi_ids; id->id[0]; id++)
-		if (!strcmp(id->id, hid))
-			return (const struct sdhci_acpi_slot *)id->driver_data;
+	const struct sdhci_acpi_uid_slot *u;
+
+	for (u = sdhci_acpi_uids; u->hid; u++) {
+		if (strcmp(u->hid, hid))
+			continue;
+		if (!u->uid)
+			return u->slot;
+		if (uid && !strcmp(u->uid, uid))
+			return u->slot;
+	}
 	return NULL;
 }
 
+static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(acpi_handle handle,
+							 const char *hid)
+{
+	const struct sdhci_acpi_slot *slot;
+	struct acpi_device_info *info;
+	const char *uid = NULL;
+	acpi_status status;
+
+	status = acpi_get_object_info(handle, &info);
+	if (!ACPI_FAILURE(status) && (info->valid & ACPI_VALID_UID))
+		uid = info->unique_id.string;
+
+	slot = sdhci_acpi_get_slot_by_ids(hid, uid);
+
+	kfree(info);
+	return slot;
+}
+
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -148,7 +198,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	c = sdhci_priv(host);
 	c->host = host;
-	c->slot = sdhci_acpi_get_slot(hid);
+	c->slot = sdhci_acpi_get_slot(handle, hid);
 	c->pdev = pdev;
 	c->use_runtime_pm = sdhci_acpi_flag(c, SDHCI_ACPI_RUNTIME_PM);
 
-- 
1.7.11.7

