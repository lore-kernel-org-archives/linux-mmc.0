From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/2] mmc: sdhci-esdhc: clean up register definitions
Date: Fri, 25 Nov 2016 12:00:50 +0800
Message-ID: <1480046451-29492-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0073.outbound.protection.outlook.com ([104.47.42.73]:3936
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751303AbcKYEON (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Nov 2016 23:14:13 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

The eSDHC register definitions in header file were messy and confusing.
This patch is to clean up these definitions.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc.h | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index de132e2..8cd8449 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -24,30 +24,31 @@
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
 				SDHCI_QUIRK_NO_HISPD_BIT)
 
-#define ESDHC_PROCTL		0x28
-
-#define ESDHC_SYSTEM_CONTROL	0x2c
-#define ESDHC_CLOCK_MASK	0x0000fff0
-#define ESDHC_PREDIV_SHIFT	8
-#define ESDHC_DIVIDER_SHIFT	4
-#define ESDHC_CLOCK_PEREN	0x00000004
-#define ESDHC_CLOCK_HCKEN	0x00000002
-#define ESDHC_CLOCK_IPGEN	0x00000001
-
 /* pltfm-specific */
 #define ESDHC_HOST_CONTROL_LE	0x20
 
 /*
- * P2020 interpretation of the SDHCI_HOST_CONTROL register
+ * eSDHC register definition
  */
-#define ESDHC_CTRL_4BITBUS          (0x1 << 1)
-#define ESDHC_CTRL_8BITBUS          (0x2 << 1)
-#define ESDHC_CTRL_BUSWIDTH_MASK    (0x3 << 1)
-
-/* OF-specific */
-#define ESDHC_DMA_SYSCTL	0x40c
-#define ESDHC_DMA_SNOOP		0x00000040
 
-#define ESDHC_HOST_CONTROL_RES	0x01
+/* Protocol Control Register */
+#define ESDHC_PROCTL			0x28
+#define ESDHC_CTRL_4BITBUS		(0x1 << 1)
+#define ESDHC_CTRL_8BITBUS		(0x2 << 1)
+#define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
+#define ESDHC_HOST_CONTROL_RES		0x01
+
+/* System Control Register */
+#define ESDHC_SYSTEM_CONTROL		0x2c
+#define ESDHC_CLOCK_MASK		0x0000fff0
+#define ESDHC_PREDIV_SHIFT		8
+#define ESDHC_DIVIDER_SHIFT		4
+#define ESDHC_CLOCK_PEREN		0x00000004
+#define ESDHC_CLOCK_HCKEN		0x00000002
+#define ESDHC_CLOCK_IPGEN		0x00000001
+
+/* Control Register for DMA transfer */
+#define ESDHC_DMA_SYSCTL		0x40c
+#define ESDHC_DMA_SNOOP			0x00000040
 
 #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
-- 
2.1.0.27.g96db324

