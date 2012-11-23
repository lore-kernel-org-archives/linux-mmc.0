From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v2 1/3] PNPACPI: exclude devices already bound
Date: Fri, 23 Nov 2012 13:35:59 +0200
Message-ID: <1353670561-22515-2-git-send-email-adrian.hunter@intel.com>
References: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, mika.westerberg@linux.intel.com, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

This will exclude ACPI platform devices from also being created
as PNP devices.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/pnp/pnpacpi/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 26b5d4b..653d563 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -242,6 +242,10 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	char *pnpid;
 	struct acpi_hardware_id *id;
 
+	/* Skip devices that are already bound */
+	if (device->physical_node_count)
+		return 0;
+
 	/*
 	 * If a PnPacpi device is not present , the device
 	 * driver should not be loaded.
-- 
1.7.11.7
