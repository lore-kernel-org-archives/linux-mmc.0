From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/3] mmc: sdhci-s3c: remove the sdhci-s3c-regs header file
Date: Fri, 20 Jan 2017 18:50:02 +0900
Message-ID: <20170120095004.14509-2-jh80.chung@samsung.com>
References: <20170120095004.14509-1-jh80.chung@samsung.com>
 <CGME20170120095012epcas5p444c0df4b86b9118c2bc5571a3f5c0161@epcas5p4.samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59569 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751613AbdATKBb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2017 05:01:31 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OK200K4JONP0G30@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 20 Jan 2017 18:50:13 +0900 (KST)
In-reply-to: <20170120095004.14509-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, Jaehoon Chung <jh80.chung@samsung.com>

Remove the sdhci-s3c-regs.h file.
Instead, it located those defined values into sdhci-s3c.c.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/sdhci-s3c-regs.h | 87 ---------------------------------------
 drivers/mmc/host/sdhci-s3c.c      | 70 ++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 88 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-s3c-regs.h

diff --git a/drivers/mmc/host/sdhci-s3c-regs.h b/drivers/mmc/host/sdhci-s3c-regs.h
deleted file mode 100644
index e34049ad..0000000
--- a/drivers/mmc/host/sdhci-s3c-regs.h
+++ /dev/null
@@ -1,87 +0,0 @@
-/* linux/arch/arm/plat-s3c/include/plat/regs-sdhci.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C Platform - SDHCI (HSMMC) register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_S3C_SDHCI_REGS_H
-#define __PLAT_S3C_SDHCI_REGS_H __FILE__
-
-#define S3C_SDHCI_CONTROL2			(0x80)
-#define S3C_SDHCI_CONTROL3			(0x84)
-#define S3C64XX_SDHCI_CONTROL4			(0x8C)
-
-#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
-#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
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
-#define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
-#define S3C_SDHCI_CTRL2_SDCDSEL			(1 << 13)
-#define S3C_SDHCI_CTRL2_SDSIGPC			(1 << 12)
-#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	(1 << 11)
-
-#define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
-#define S3C_SDHCI_CTRL2_DFCNT_NONE		(0x0 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK		(0x1 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
-#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
-
-#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
-#define S3C_SDHCI_CTRL2_RWAITMODE		(1 << 7)
-#define S3C_SDHCI_CTRL2_DISBUFRD		(1 << 6)
-#define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
-#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
-#define S3C_SDHCI_CTRL2_PWRSYNC			(1 << 3)
-#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		(1 << 1)
-#define S3C_SDHCI_CTRL2_HWINITFIN		(1 << 0)
-
-#define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
-#define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
-#define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
-#define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
-
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
-#define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA	(0x3 << 16)
-
-#define S3C64XX_SDHCI_CONTROL4_BUSY		(1)
-
-#endif /* __PLAT_S3C_SDHCI_REGS_H */
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index de219ca..7a230a1 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -29,11 +29,79 @@
 
 #include <linux/mmc/host.h>
 
-#include "sdhci-s3c-regs.h"
 #include "sdhci.h"
 
 #define MAX_BUS_CLK	(4)
 
+#define S3C_SDHCI_CONTROL2			(0x80)
+#define S3C_SDHCI_CONTROL3			(0x84)
+#define S3C64XX_SDHCI_CONTROL4			(0x8C)
+
+#define S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR	(1 << 31)
+#define S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK		(1 << 30)
+#define S3C_SDHCI_CTRL2_CDINVRXD3		(1 << 29)
+#define S3C_SDHCI_CTRL2_SLCARDOUT		(1 << 28)
+
+#define S3C_SDHCI_CTRL2_FLTCLKSEL_MASK		(0xf << 24)
+#define S3C_SDHCI_CTRL2_FLTCLKSEL_SHIFT		(24)
+#define S3C_SDHCI_CTRL2_FLTCLKSEL(_x)		((_x) << 24)
+
+#define S3C_SDHCI_CTRL2_LVLDAT_MASK		(0xff << 16)
+#define S3C_SDHCI_CTRL2_LVLDAT_SHIFT		(16)
+#define S3C_SDHCI_CTRL2_LVLDAT(_x)		((_x) << 16)
+
+#define S3C_SDHCI_CTRL2_ENFBCLKTX		(1 << 15)
+#define S3C_SDHCI_CTRL2_ENFBCLKRX		(1 << 14)
+#define S3C_SDHCI_CTRL2_SDCDSEL			(1 << 13)
+#define S3C_SDHCI_CTRL2_SDSIGPC			(1 << 12)
+#define S3C_SDHCI_CTRL2_ENBUSYCHKTXSTART	(1 << 11)
+
+#define S3C_SDHCI_CTRL2_DFCNT_MASK		(0x3 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_SHIFT		(9)
+#define S3C_SDHCI_CTRL2_DFCNT_NONE		(0x0 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_4SDCLK		(0x1 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_16SDCLK		(0x2 << 9)
+#define S3C_SDHCI_CTRL2_DFCNT_64SDCLK		(0x3 << 9)
+
+#define S3C_SDHCI_CTRL2_ENCLKOUTHOLD		(1 << 8)
+#define S3C_SDHCI_CTRL2_RWAITMODE		(1 << 7)
+#define S3C_SDHCI_CTRL2_DISBUFRD		(1 << 6)
+#define S3C_SDHCI_CTRL2_SELBASECLK_MASK		(0x3 << 4)
+#define S3C_SDHCI_CTRL2_SELBASECLK_SHIFT	(4)
+#define S3C_SDHCI_CTRL2_PWRSYNC			(1 << 3)
+#define S3C_SDHCI_CTRL2_ENCLKOUTMSKCON		(1 << 1)
+#define S3C_SDHCI_CTRL2_HWINITFIN		(1 << 0)
+
+#define S3C_SDHCI_CTRL3_FCSEL3			(1 << 31)
+#define S3C_SDHCI_CTRL3_FCSEL2			(1 << 23)
+#define S3C_SDHCI_CTRL3_FCSEL1			(1 << 15)
+#define S3C_SDHCI_CTRL3_FCSEL0			(1 << 7)
+
+#define S3C_SDHCI_CTRL3_FIA3_MASK		(0x7f << 24)
+#define S3C_SDHCI_CTRL3_FIA3_SHIFT		(24)
+#define S3C_SDHCI_CTRL3_FIA3(_x)		((_x) << 24)
+
+#define S3C_SDHCI_CTRL3_FIA2_MASK		(0x7f << 16)
+#define S3C_SDHCI_CTRL3_FIA2_SHIFT		(16)
+#define S3C_SDHCI_CTRL3_FIA2(_x)		((_x) << 16)
+
+#define S3C_SDHCI_CTRL3_FIA1_MASK		(0x7f << 8)
+#define S3C_SDHCI_CTRL3_FIA1_SHIFT		(8)
+#define S3C_SDHCI_CTRL3_FIA1(_x)		((_x) << 8)
+
+#define S3C_SDHCI_CTRL3_FIA0_MASK		(0x7f << 0)
+#define S3C_SDHCI_CTRL3_FIA0_SHIFT		(0)
+#define S3C_SDHCI_CTRL3_FIA0(_x)		((_x) << 0)
+
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_MASK	(0x3 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_SHIFT	(16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_2mA	(0x0 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_4mA	(0x1 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_7mA	(0x2 << 16)
+#define S3C64XX_SDHCI_CONTROL4_DRIVE_9mA	(0x3 << 16)
+
+#define S3C64XX_SDHCI_CONTROL4_BUSY		(1)
+
 /**
  * struct sdhci_s3c - S3C SDHCI instance
  * @host: The SDHCI host created
-- 
2.10.2

