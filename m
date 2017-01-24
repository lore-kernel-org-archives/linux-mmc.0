From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: sdhci-s3c: use the bitops API for bit operation
Date: Tue, 24 Jan 2017 18:27:28 +0900
Message-ID: <20170124092728.19874-3-jh80.chung@samsung.com>
References: <20170124092728.19874-1-jh80.chung@samsung.com>
 <CGME20170124092731epcas5p342bb2305df7da4d9cac5a182ece34449@epcas5p3.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52576 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdAXJ1g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 04:27:36 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKA032MQ29WTY30@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 24 Jan 2017 18:27:32 +0900 (KST)
In-reply-to: <20170124092728.19874-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, Jaehoon Chung <jh80.chung@samsung.com>

Use the bitops API instead of shifting directly.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog on V2:
- Keep the unused defined mask

 drivers/mmc/host/sdhci-s3c.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7a230a1..3e5c83d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -37,10 +37,10 @@
 #define S3C_SDHCI_CONTROL3			(0x84)
 #define S3C64XX_SDHCI_CONTROL4			(0x8C)
 
-#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
-#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
-#define S3C_SDHCI_CTRL2_CDINVRXD3		(1 << 29)
-#define S3C_SDHCI_CTRL2_SLCARDOUT		(1 << 28)
+#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	BIT(31)
+#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		BIT(30)
+#define S3C_SDHCI_CTRL2_CDINVRXD3		BIT(29)
+#define S3C_SDHCI_CTRL2_SLCARDOUT		BIT(28)
 
 #define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK		(0xf << 24)
 #define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT		(24)
@@ -50,11 +50,11 @@
 #define S3C_SDHCI_CTRL2_LVLDAT_SHIFT		(16)
 #define S3C_SDHCI_CTRL2_LVLDAT(_x)		((_x) << 16)
 
-#define S3C_SDHCI_CTRL2_ENFBCLKTX		(1 << 15)
-#define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
-#define S3C_SDHCI_CTRL2_SDCDSEL			(1 << 13)
-#define S3C_SDHCI_CTRL2_SDSIGPC			(1 << 12)
-#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	(1 << 11)
+#define S3C_SDHCI_CTRL2_ENFBCLKTX		BIT(15)
+#define S3C_SDHCI_CTRL2_ENFBCLKRX		BIT(14)
+#define S3C_SDHCI_CTRL2_SDCDSEL			BIT(13)
+#define S3C_SDHCI_CTRL2_SDSIGPC			BIT(12)
+#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	BIT(11)
 
 #define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
@@ -63,19 +63,20 @@
 #define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
 
-#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
-#define S3C_SDHCI_CTRL2_RWAITMODE		(1 << 7)
-#define S3C_SDHCI_CTRL2_DISBUFRD		(1 << 6)
+#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		BIT(8)
+#define S3C_SDHCI_CTRL2_RWAITMODE		BIT(7)
+#define S3C_SDHCI_CTRL2_DISBUFRD		BIT(6)
+
 #define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
 #define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
-#define S3C_SDHCI_CTRL2_PWRSYNC			(1 << 3)
-#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		(1 << 1)
-#define S3C_SDHCI_CTRL2_HWINITFIN		(1 << 0)
-
-#define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
-#define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
-#define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
-#define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
+#define S3C_SDHCI_CTRL2_PWRSYNC			BIT(3)
+#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		BIT(1)
+#define S3C_SDHCI_CTRL2_HWINITFIN		BIT(0)
+
+#define S3C_SDHCI_CTRL3_FCSEL3			BIT(31)
+#define S3C_SDHCI_CTRL3_FCSEL2			BIT(23)
+#define S3C_SDHCI_CTRL3_FCSEL1			BIT(15)
+#define S3C_SDHCI_CTRL3_FCSEL0			BIT(7)
 
 #define S3C_SDHCI_CTRL3_FIA3_MASK		(0x7f << 24)
 #define S3C_SDHCI_CTRL3_FIA3_SHIFT		(24)
-- 
2.10.2

