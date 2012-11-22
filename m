From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/3] PNPACPI: exclude SDHCI devices
Date: Thu, 22 Nov 2012 10:43:48 +0200
Message-ID: <1353573830-13006-2-git-send-email-adrian.hunter@intel.com>
References: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353573830-13006-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

These devices will be handled by a ACPI Platform driver.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/pnp/pnpacpi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 26b5d4b..5b17cc8 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -43,6 +43,7 @@ static struct acpi_device_id excluded_id_list[] __initdata = {
 	{"PNP0C0F", 0},		/* Link device */
 	{"PNP0000", 0},		/* PIC */
 	{"PNP0100", 0},		/* Timer */
+	{"PNP0D40", 0},		/* SDHCI */
 	{"", 0},
 };
 
-- 
1.7.11.7
