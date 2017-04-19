From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci-pci: Allow for 3 bytes from Intel DSM
Date: Wed, 19 Apr 2017 15:48:55 +0300
Message-ID: <1492606135-4983-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40229 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934064AbdDSMyh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Apr 2017 08:54:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

The DSM used by some Intel controllers can return a 3 byte package. Allow
for that by using memcpy to copy the bytes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 57d6f50b73dc..eb3e34c7afe2 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -12,6 +12,7 @@
  *     - JMicron (hardware and technical support)
  */
 
+#include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
@@ -413,6 +414,7 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
 {
 	union acpi_object *obj;
 	int err = 0;
+	size_t len;
 
 	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), intel_dsm_uuid, 0, fn, NULL);
 	if (!obj)
@@ -423,12 +425,10 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
 		goto out;
 	}
 
-	if (obj->buffer.length >= 4)
-		*result = *(u32 *)obj->buffer.pointer;
-	else if (obj->buffer.length >= 2)
-		*result = *(u16 *)obj->buffer.pointer;
-	else
-		*result = *(u8 *)obj->buffer.pointer;
+	len = min_t(size_t, obj->buffer.length, 4);
+
+	*result = 0;
+	memcpy(result, obj->buffer.pointer, len);
 out:
 	ACPI_FREE(obj);
 
-- 
1.9.1

