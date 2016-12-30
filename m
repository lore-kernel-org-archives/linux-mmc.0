From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / scan: Prefer devices without _HID/_CID for _ADR matching
Date: Fri, 30 Dec 2016 02:27:31 +0100
Message-ID: <2022116.4lq1KAmrJA@aspire.rjw.lan>
References: <20161225102148.7706-1-hdegoede@redhat.com> <CAJZ5v0gjcaYtskSMueAz+GjHcLZv=4A8Qz_Lf6Bn7S0CLSkgPg@mail.gmail.com> <20161229084135.GC1460@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161229084135.GC1460@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-mmc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The way acpi_find_child_device() works currently is that, if there
are two (or more) devices with the same _ADR value in the same
namespace scope (which is not specifically allowed by the spec and
the OS behavior in that case is not defined), the first one of them
found to be present (with the help of _STA) will be returned.

This covers the majority of cases, but is not sufficient if some of
the devices in question have a _HID (or _CID) returning some valid
ACPI/PNP device IDs (which is disallowed by the spec) and the
ASL writers' expectation appears to be that the OS will match
devices without a valid ACPI/PNP device ID against a given bus
address first.

To cover this special case as well, modify find_child_checks()
to prefer devices without ACPI/PNP device IDs over devices that
have them.

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

I'm not actually sure if this is sufficient to fix the original 80860F14 uid "2"
sd-controller problem on CherryTrail.  Hans, can you please check?

If it is not sufficient, we may need to fail find_child_checks() right away
for devices with non-empty pnp.ids lists.

Thanks,
Rafael

---
 drivers/acpi/glue.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -98,7 +98,15 @@ static int find_child_checks(struct acpi
 	if (check_children && list_empty(&adev->children))
 		return -ENODEV;
 
-	return sta_present ? FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
+	/*
+	 * If the device has a _HID (or _CID) returning a valid ACPI/PNP
+	 * device ID, it is better to make it look less attractive here, so that
+	 * the other device with the same _ADR value (that may not have a valid
+	 * device ID) can be matched going forward.  [This means a second spec
+	 * violation in a row, so whatever we do here is best effort anyway.]
+	 */
+	return sta_present && list_empty(&adev->pnp.ids) ?
+			FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
 }
 
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,

