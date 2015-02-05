From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/12] mmc: core: Add function to read driver-strength device property
Date: Thu,  5 Feb 2015 15:13:46 +0200
Message-ID: <1423142029-22521-10-git-send-email-adrian.hunter@intel.com>
References: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58011 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757547AbbBENSF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Feb 2015 08:18:05 -0500
In-Reply-To: <1423142029-22521-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

Add a function to read a new "driver-strength" device property.

Currently there is no documentation for device properties,
so add "driver-strength" to mmc devicetree bindings.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |  4 ++++
 drivers/mmc/core/host.c                       | 21 +++++++++++++++++++++
 include/linux/mmc/host.h                      |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 438899e..cfcb66b 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -43,6 +43,10 @@ Optional properties:
 - dsr: Value the card's (optional) Driver Stage Register (DSR) should be
   programmed with. Valid range: [0 .. 0xffff].
 
+Device properties (use device_property_ API):
+- driver-strength: Optional driver strength value for a card using UHS-I or
+  HS200/HS400
+
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
 line levels. We choose to follow the SDHCI standard, which specifies both those
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 20354a5..bf19d14 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -22,6 +22,7 @@
 #include <linux/leds.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/property.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -516,6 +517,26 @@ int mmc_of_parse(struct mmc_host *host)
 
 EXPORT_SYMBOL(mmc_of_parse);
 
+int mmc_host_read_drive_strength(struct mmc_host *host)
+{
+	struct device *dev = host->parent;
+	u8 drive_strength;
+	int err;
+
+	if (!device_property_present(dev, "driver-strength"))
+		return -ENODATA;
+
+	err = device_property_read_u8(dev, "driver-strength", &drive_strength);
+	if (err) {
+		dev_err(dev, "Bad \"driver-strength\" property, error %d\n",
+			err);
+		return -EINVAL;
+	}
+
+	return drive_strength;
+}
+EXPORT_SYMBOL(mmc_host_read_drive_strength);
+
 /**
  *	mmc_alloc_host - initialise the per-host structure.
  *	@extra: sizeof private data structure
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 967e7db..d876892 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -394,6 +394,8 @@ void mmc_remove_host(struct mmc_host *);
 void mmc_free_host(struct mmc_host *);
 int mmc_of_parse(struct mmc_host *host);
 
+int mmc_host_read_drive_strength(struct mmc_host *host);
+
 static inline void *mmc_priv(struct mmc_host *host)
 {
 	return (void *)host->private;
-- 
1.9.1

