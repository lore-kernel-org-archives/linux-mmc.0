From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/4] mmc:core: parse voltage from device-tree
Date: Mon, 26 Aug 2013 09:19:22 +0800
Message-ID: <1377479965-471-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:55274
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755974Ab3HZBVU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Aug 2013 21:21:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, galak@kernel.crashing.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add function to support get voltage from device-tree.
If there are voltage-range specified in device-tree node, this function
will parse it and return the available voltage mask.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Acked-by: Anton Vorontsov <anton@enomsg.org>
---
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  4 ++
 drivers/mmc/core/core.c                            | 44 ++++++++++++++++++++++
 include/linux/mmc/core.h                           |  2 +
 3 files changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
index bd9be0b..b7943f3 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
@@ -19,6 +19,9 @@ Optional properties:
     "bus-width = <1>" property.
   - sdhci,auto-cmd12: specifies that a controller can only handle auto
     CMD12.
+  - voltage-ranges : two cells are required, first cell specifies minimum
+    slot voltage (mV), second cell specifies maximum slot voltage (mV).
+    Several ranges could be specified.
 
 Example:
 
@@ -29,4 +32,5 @@ sdhci@2e000 {
 	interrupt-parent = <&ipic>;
 	/* Filled in by U-Boot */
 	clock-frequency = <0>;
+	voltage-ranges = <3300 3300>;
 };
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 49a5bca..b9b9fb6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -27,6 +27,7 @@
 #include <linux/fault-inject.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -1196,6 +1197,49 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
 
+#ifdef CONFIG_OF
+
+/**
+ * mmc_of_parse_voltage - return mask of supported voltages
+ * @np: The device node need to be parsed.
+ * @mask: mask of voltages available for MMC/SD/SDIO
+ *
+ * 1. Return zero on success.
+ * 2. Return negative errno: voltage-range is invalid.
+ */
+int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
+{
+	const u32 *voltage_ranges;
+	int num_ranges, i;
+
+	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
+	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+	if (!voltage_ranges || !num_ranges) {
+		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_ranges; i++) {
+		const int j = i * 2;
+		u32 ocr_mask;
+
+		ocr_mask = mmc_vddrange_to_ocrmask(
+				be32_to_cpu(voltage_ranges[j]),
+				be32_to_cpu(voltage_ranges[j + 1]));
+		if (!ocr_mask) {
+			pr_err("%s: voltage-range #%d is invalid\n",
+				np->full_name, i);
+			return -EINVAL;
+		}
+		*mask |= ocr_mask;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mmc_of_parse_voltage);
+
+#endif /* CONFIG_OF */
+
 #ifdef CONFIG_REGULATOR
 
 /**
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 443243b..da51bec 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -208,6 +208,8 @@ static inline void mmc_claim_host(struct mmc_host *host)
 	__mmc_claim_host(host, NULL);
 }
 
+struct device_node;
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
+extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.8.0


