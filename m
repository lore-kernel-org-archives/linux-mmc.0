From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/3] mmc: sdhci-acpi: Get UID directly from acpi_device
Date: Mon,  6 Oct 2014 15:23:05 +0300
Message-ID: <1412598187-5263-2-git-send-email-adrian.hunter@intel.com>
References: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60429 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160AbaJFMY5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Oct 2014 08:24:57 -0400
In-Reply-To: <1412598187-5263-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

UID was made available on acpi_device since
commit ccf78040265b ("ACPI: Add _UID support for ACPI devices.")
Use it from there instead of reprocessing the
ACPI object info.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-acpi.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index e9a2c6f..839f26c 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -225,8 +225,8 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
-static const struct sdhci_acpi_slot *sdhci_acpi_get_slot_by_ids(const char *hid,
-								const char *uid)
+static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
+							 const char *uid)
 {
 	const struct sdhci_acpi_uid_slot *u;
 
@@ -241,24 +241,6 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot_by_ids(const char *hid,
 	return NULL;
 }
 
-static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(acpi_handle handle,
-							 const char *hid)
-{
-	const struct sdhci_acpi_slot *slot;
-	struct acpi_device_info *info;
-	const char *uid = NULL;
-	acpi_status status;
-
-	status = acpi_get_object_info(handle, &info);
-	if (!ACPI_FAILURE(status) && (info->valid & ACPI_VALID_UID))
-		uid = info->unique_id.string;
-
-	slot = sdhci_acpi_get_slot_by_ids(hid, uid);
-
-	kfree(info);
-	return slot;
-}
-
 static int sdhci_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -269,6 +251,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	struct resource *iomem;
 	resource_size_t len;
 	const char *hid;
+	const char *uid;
 	int err;
 
 	if (acpi_bus_get_device(handle, &device))
@@ -278,6 +261,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	hid = acpi_device_hid(device);
+	uid = device->pnp.unique_id;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem)
@@ -296,7 +280,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 
 	c = sdhci_priv(host);
 	c->host = host;
-	c->slot = sdhci_acpi_get_slot(handle, hid);
+	c->slot = sdhci_acpi_get_slot(hid, uid);
 	c->pdev = pdev;
 	c->use_runtime_pm = sdhci_acpi_flag(c, SDHCI_ACPI_RUNTIME_PM);
 
-- 
1.9.1

