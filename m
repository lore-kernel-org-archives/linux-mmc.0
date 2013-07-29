From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/3] mmc:core: parse voltage from device-tree
Date: Mon, 29 Jul 2013 10:56:33 +0800
Message-ID: <1375066595-14968-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:42578
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752631Ab3G2DtV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Jul 2013 23:49:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Add function to support get voltage from device-tree.
If there are voltage-range specified in device-tree node, this function
will parse it and return the avail voltage mask.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 drivers/mmc/core/core.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 49a5bca..217cd42 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -27,6 +27,7 @@
 #include <linux/fault-inject.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -1196,6 +1197,53 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
 }
 EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
 
+#ifdef CONFIG_OF
+
+/*
+ * mmc_of_parse_voltage - return mask of supported voltages
+ * @host: host whose node should be parsed.
+ *
+ * 1. Return zero: voltage-ranges unspecified in device-tree.
+ * 2. Return negative errno: voltage-range is invalid.
+ * 3. Return ocr_mask: a mask of voltages that parse from device-tree
+ * node can be provided to MMC/SD/SDIO devices.
+ */
+
+u32 mmc_of_parse_voltage(struct mmc_host *host)
+{
+	const u32 *voltage_ranges;
+	int num_ranges, i;
+	struct device_node *np;
+	u32 ocr_mask = 0;
+
+	np = host->parent->of_node;
+	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
+	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
+	if (!voltage_ranges || !num_ranges) {
+		dev_info(host->parent, "OF: voltage-ranges unspecified\n");
+		return 0;
+	}
+
+	for (i = 0; i < num_ranges; i++) {
+		const int j = i * 2;
+		u32 mask;
+
+		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
+				be32_to_cpu(voltage_ranges[j + 1]));
+		if (!mask) {
+			dev_err(host->parent,
+				"OF: voltage-range #%d is invalid\n", i);
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
index 443243b..107375c 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -209,5 +209,6 @@ static inline void mmc_claim_host(struct mmc_host *host)
 }
 
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
+extern u32 mmc_of_parse_voltage(struct mmc_host *host);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
1.8.0


