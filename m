From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/3] mmc: sdhci-s3c: use the bitops API for bit operation
Date: Fri, 20 Jan 2017 18:50:04 +0900
Message-ID: <20170120095004.14509-4-jh80.chung@samsung.com>
References: <20170120095004.14509-1-jh80.chung@samsung.com>
 <CGME20170120095012epcas5p4b5e0955e3e75e96b37ef1ef66fb501f6@epcas5p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:46295 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdATKBb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 05:01:31 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OK2003GPONO5K30@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jan 2017 18:50:12 +0900 (KST)
In-reply-to: <20170120095004.14509-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

Use the bitops API instead of shifting directly.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index e8b57cd..6c102d8 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -34,24 +34,24 @@
 #define MAX_BUS_CLK	(4)
 
 #define S3C_SDHCI_CONTROL2			(0x80)
-#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
-#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
-#define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
+#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	BIT(31)
+#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		BIT(30)
+#define S3C_SDHCI_CTRL2_ENFBCLKRX		BIT(14)
 #define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
 #define S3C_SDHCI_CTRL2_DFCNT_NONE		(0x0 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_4SDCLK		(0x1 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
-#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
+#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		BIT(8)
 #define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
 #define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
 
 #define S3C_SDHCI_CONTROL3			(0x84)
-#define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
-#define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
-#define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
-#define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
+#define S3C_SDHCI_CTRL3_FCSEL3			BIT(31)
+#define S3C_SDHCI_CTRL3_FCSEL2			BIT(23)
+#define S3C_SDHCI_CTRL3_FCSEL1			BIT(15)
+#define S3C_SDHCI_CTRL3_FCSEL0			BIT(7)
 
 #define S3C64XX_SDHCI_CONTROL4			(0x8C)
 #define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA	(0x3 << 16)
-- 
2.10.2

