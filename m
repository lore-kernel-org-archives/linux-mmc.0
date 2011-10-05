From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 2/3] mmc: Add OF bindings support for mmc host controller
 capabilities
Date: Wed, 05 Oct 2011 15:43:00 +0530
Message-ID: <1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:21741 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932963Ab1JEKNI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 06:13:08 -0400
In-reply-to: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

Device nodes representing sd/mmc controllers in a device tree would include
mmc host controller capabilities. Add support for parsing of mmc host
controller capabilities included in device nodes.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/mmc/linux-mmc-host.txt     |   11 +++++++
 drivers/mmc/core/host.c                            |   31 ++++++++++++++++++++
 include/linux/mmc/host.h                           |    3 ++
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/linux-mmc-host.txt

diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
new file mode 100644
index 0000000..cb43905
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
@@ -0,0 +1,11 @@
+* Linux mmc host capabilities
+
+MMC Host Controller capabilities used in linux:
+- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
+- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed timing
+- linux,mmc_cap_sd_highspeed - host can do SD high-speed timing
+- linux,mmc_cap_needs_poll - host needs polling for card detection
+- linux,mmc_cap_8_bit_data - host can do 8 bit transfer
+- linux,mmc_cap_disable - host can be disabled
+- linux,mmc_cap_nonremovable - host is connected to nonremovable media
+- linux,mmc_cap_erase - host allows erase/trim commands
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 793d0a0..4ee2e43 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -19,6 +19,7 @@
 #include <linux/leds.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/of.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -385,3 +386,33 @@ void mmc_free_host(struct mmc_host *host)
 }
 
 EXPORT_SYMBOL(mmc_free_host);
+
+#ifdef CONFIG_OF
+/**
+ *	mmc_of_parse_host_caps - parse mmc host capabilities from device node
+ *	@np: pointer to device node in device tree
+ *	@caps: pointer to host caps value to be returned
+ *
+ *	Search the device node in device tree for mmc host capabilities.
+ */
+void mmc_of_parse_host_caps(struct device_node *np, unsigned long *caps)
+{
+	if (of_find_property(np, "linux,mmc_cap_4_bit_data", NULL))
+		*caps |= MMC_CAP_4_BIT_DATA;
+	if (of_find_property(np, "linux,mmc_cap_mmc_highspeed", NULL))
+		*caps |= MMC_CAP_MMC_HIGHSPEED;
+	if (of_find_property(np, "linux,mmc_cap_sd_highspeed", NULL))
+		*caps |= MMC_CAP_SD_HIGHSPEED;
+	if (of_find_property(np, "linux,mmc_cap_needs_poll", NULL))
+		*caps |= MMC_CAP_NEEDS_POLL;
+	if (of_find_property(np, "linux,mmc_cap_8_bit_data", NULL))
+		*caps |= MMC_CAP_8_BIT_DATA;
+	if (of_find_property(np, "linux,mmc_cap_disable", NULL))
+		*caps |= MMC_CAP_DISABLE;
+	if (of_find_property(np, "linux,mmc_cap_nonremovable", NULL))
+		*caps |= MMC_CAP_NONREMOVABLE;
+	if (of_find_property(np, "linux,mmc_cap_erase", NULL))
+		*caps |= MMC_CAP_ERASE;
+}
+EXPORT_SYMBOL(mmc_of_parse_host_caps);
+#endif /* CONFIG_OF */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1d09562..72b5df2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -309,6 +309,9 @@ extern struct mmc_host *mmc_alloc_host(int extra, struct device *);
 extern int mmc_add_host(struct mmc_host *);
 extern void mmc_remove_host(struct mmc_host *);
 extern void mmc_free_host(struct mmc_host *);
+#ifdef CONFIG_OF
+extern void mmc_of_parse_host_caps(struct device_node *np, unsigned long *caps);
+#endif
 
 static inline void *mmc_priv(struct mmc_host *host)
 {
-- 
1.6.6.rc2

