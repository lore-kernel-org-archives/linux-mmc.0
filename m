From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/3] mmc: sdhci-s3c: remove the unnecessary defined values
Date: Fri, 20 Jan 2017 18:50:03 +0900
Message-ID: <20170120095004.14509-3-jh80.chung@samsung.com>
References: <20170120095004.14509-1-jh80.chung@samsung.com>
 <CGME20170120095012epcas5p436242f1882d319fe958f0084dea71628@epcas5p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:59844 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdATJvu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 04:51:50 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OK200DCLONOB310@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jan 2017 18:50:12 +0900 (KST)
In-reply-to: <20170120095004.14509-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

Some defined value don't use anywhere.
It doesn't need to maintain anywhere.
Just keeps the minimum values what is using and needs.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c | 50 ++------------------------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 7a230a1..e8b57cd 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -34,74 +34,28 @@
 #define MAX_BUS_CLK	(4)
 
 #define S3C_SDHCI_CONTROL2			(0x80)
-#define S3C_SDHCI_CONTROL3			(0x84)
-#define S3C64XX_SDHCI_CONTROL4			(0x8C)
-
 #define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
 #define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
-#define S3C_SDHCI_CTRL2_CDINVRXD3		(1 << 29)
-#define S3C_SDHCI_CTRL2_SLCARDOUT		(1 << 28)
-
-#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK		(0xf << 24)
-#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT		(24)
-#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x)		((_x) << 24)
-
-#define S3C_SDHCI_CTRL2_LVLDAT_MASK		(0xff << 16)
-#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT		(16)
-#define S3C_SDHCI_CTRL2_LVLDAT(_x)		((_x) << 16)
-
-#define S3C_SDHCI_CTRL2_ENFBCLKTX		(1 << 15)
 #define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
-#define S3C_SDHCI_CTRL2_SDCDSEL			(1 << 13)
-#define S3C_SDHCI_CTRL2_SDSIGPC			(1 << 12)
-#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	(1 << 11)
-
 #define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
 #define S3C_SDHCI_CTRL2_DFCNT_NONE		(0x0 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_4SDCLK		(0x1 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
 #define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
-
 #define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
-#define S3C_SDHCI_CTRL2_RWAITMODE		(1 << 7)
-#define S3C_SDHCI_CTRL2_DISBUFRD		(1 << 6)
 #define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
 #define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
-#define S3C_SDHCI_CTRL2_PWRSYNC			(1 << 3)
-#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		(1 << 1)
-#define S3C_SDHCI_CTRL2_HWINITFIN		(1 << 0)
 
+#define S3C_SDHCI_CONTROL3			(0x84)
 #define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
 #define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
 #define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
 #define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
 
-#define S3C_SDHCI_CTRL3_FIA3_MASK		(0x7f << 24)
-#define S3C_SDHCI_CTRL3_FIA3_SHIFT		(24)
-#define S3C_SDHCI_CTRL3_FIA3(_x)		((_x) << 24)
-
-#define S3C_SDHCI_CTRL3_FIA2_MASK		(0x7f << 16)
-#define S3C_SDHCI_CTRL3_FIA2_SHIFT		(16)
-#define S3C_SDHCI_CTRL3_FIA2(_x)		((_x) << 16)
-
-#define S3C_SDHCI_CTRL3_FIA1_MASK		(0x7f << 8)
-#define S3C_SDHCI_CTRL3_FIA1_SHIFT		(8)
-#define S3C_SDHCI_CTRL3_FIA1(_x)		((_x) << 8)
-
-#define S3C_SDHCI_CTRL3_FIA0_MASK		(0x7f << 0)
-#define S3C_SDHCI_CTRL3_FIA0_SHIFT		(0)
-#define S3C_SDHCI_CTRL3_FIA0(_x)		((_x) << 0)
-
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_MASK	(0x3 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_SHIFT	(16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_2mA	(0x0 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_4mA	(0x1 << 16)
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_7mA	(0x2 << 16)
+#define S3C64XX_SDHCI_CONTROL4			(0x8C)
 #define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA	(0x3 << 16)
 
-#define S3C64XX_SDHCI_CONTROL4_BUSY		(1)
-
 /**
  * struct sdhci_s3c - S3C SDHCI instance
  * @host: The SDHCI host created
-- 
2.10.2

