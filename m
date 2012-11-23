From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 2/3] ACPI: add SDHCI to ACPI platform devices
Date: Fri, 23 Nov 2012 13:36:00 +0200
Message-ID: <1353670561-22515-3-git-send-email-adrian.hunter@intel.com>
References: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, mika.westerberg@linux.intel.com, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

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
