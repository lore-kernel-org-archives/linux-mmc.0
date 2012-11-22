From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/3] ACPI: add SDHCI to ACPI platform devices
Date: Thu, 22 Nov 2012 10:43:49 +0200
Message-ID: <1353573830-13006-3-git-send-email-adrian.hunter@intel.com>
References: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25178 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932273Ab2KVTIR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Nov 2012 14:08:17 -0500
In-Reply-To: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8c4ac6d..67a7fa6 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -35,6 +35,8 @@ static const char *dummy_hid = "device";
  */
 static const struct acpi_device_id acpi_platform_device_ids[] = {
 
+	{ "PNP0D40" },
+
 	{ }
 };
 
-- 
1.7.11.7

