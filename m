From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 5/6] mmc: Add OF bindings support for mmc host controller
 capabilities
Date: Thu, 03 Nov 2011 02:06:02 +0530
Message-ID: <1320266163-15292-6-git-send-email-thomas.abraham@linaro.org>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Device nodes representing sd/mmc controllers in a device tree would include
mmc host controller capabilities. Add support for parsing of mmc host
controller capabilities included in device nodes.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/mmc/linux-mmc-host.txt     |   13 ++++++++
 drivers/mmc/core/host.c                            |   31 ++++++++++++++++++++
 include/linux/mmc/host.h                           |    1 +
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/linux-mmc-host.txt

diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
new file mode 100644
index 0000000..714b2b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
@@ -0,0 +1,13 @@
+* Linux MMC Host Controller Capabilities
+
+The following bindings can be used in a device node to specify any board
+specific mmc host controller capabilities.
+
+- linux,mmc_cap_4_bit_data - Host can do 4-bit transfers
+- linux,mmc_cap_mmc_highspeed - Host can do MMC high-speed timing
+- linux,mmc_cap_sd_highspeed - Host can do SD high-speed timing
+- linux,mmc_cap_needs_poll - Host needs polling for card detection
+- linux,mmc_cap_8_bit_data - Host can do 8-bit transfer
+- linux,mmc_cap_disable - Host can be disabled and re-enabled to save power
+- linux,mmc_cap_nonremovable - Host is connected to nonremovable media
+- linux,mmc_cap_erase - Host allows erase/trim commands
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ca2e4f5..aabf440 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -19,6 +19,7 @@
 #include <linux/leds.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
+#include <linux/of.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -396,3 +397,33 @@ void mmc_free_host(struct mmc_host *host)
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
index a3ac9c4..c81c6e8 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -330,6 +330,7 @@ extern struct mmc_host *mmc_alloc_host(int extra, struct device *);
 extern int mmc_add_host(struct mmc_host *);
 extern void mmc_remove_host(struct mmc_host *);
 extern void mmc_free_host(struct mmc_host *);
+extern void mmc_of_parse_host_caps(struct device_node *np, unsigned long *caps);
 
 static inline void *mmc_priv(struct mmc_host *host)
 {
-- 
1.6.6.rc2
