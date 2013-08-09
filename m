From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/3 V3] mmc:core: parse voltage from device-tree
Date: Fri, 9 Aug 2013 11:11:01 +0800
Message-ID: <1376017863-31453-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:7055 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751028Ab3HIEEd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 00:04:33 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add function to support get voltage from device-tree.
If there are voltage-range specified in device-tree node, this function
will parse it and return the available voltage mask.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V3:
	- Correct the type of return value.
changes for v2:
	- Update the parameters of function

 drivers/mmc/core/core.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h |  2 ++
 2 files changed, 47 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 49a5bca..1b13c37 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1196,6 +1196,51 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
 
+#ifdef CONFIG_OF
+
+/**
+ * mmc_of_parse_voltage - return mask of supported voltages
+ * @np: The device node need to be parsed.
+ *
+ * 1. Return zero: voltage-ranges unspecified in device-tree
+ * 2. Return negative errno: voltage-range is invalid.
+ * 3. Return ocr_mask: a mask of voltages that parse from device-tree
+ * node that can be provided to MMC/SD/SDIO devices.
+ */
+int mmc_of_parse_voltage(struct device_node *np)
+{
+	const u32 *voltage_ranges;
+	int num_ranges, i;
+	int ocr_mask;
+
+	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
+	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+	if (!voltage_ranges || !num_ranges) {
+		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
+		return 0;
+	}
+
+	for (i = 0; i < num_ranges; i++) {
+		const int j = i * 2;
+		u32 mask;
+
+		mask = mmc_vddrange_to_ocrmask(
+				be32_to_cpu(voltage_ranges[j]),
+				be32_to_cpu(voltage_ranges[j + 1]));
+		if (!mask) {
+			pr_err("%s: voltage-range #%d is invalid\n",
+				np->full_name, i);
+			return -EINVAL;
+		}
+		ocr_mask |= mask;
+	}
+
+	return ocr_mask;
+}
+EXPORT_SYMBOL(mmc_of_parse_voltage);
+
+#endif /* CONFIG_OF */
+
 #ifdef CONFIG_REGULATOR
 
 /**
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 443243b..117f719 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/completion.h>
+#include <linux/of.h>
 
 struct request;
 struct mmc_data;
@@ -209,5 +210,6 @@ static inline void mmc_claim_host(struct mmc_host *host)
 }
 
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
+extern int mmc_of_parse_voltage(struct device_node *np);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.8.0


