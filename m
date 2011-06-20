From: Zhangfei Gao <zhangfei.gao@marvell.com>
Subject: [PATCH] mmc: sdhci-pxa move platform data to include/linux/platform_data
Date: Mon, 20 Jun 2011 22:11:52 +0800
Message-ID: <1308579112-5027-1-git-send-email-zhangfei.gao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:42413 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1FTOL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 10:11:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Arnd Bergmann <arnd@arndb.de>

	As suggested by Arnd, move platform data to include/linux/platform_data,
	Add 'depends on CLKDEV_LOOKUP' since clk API is used,
	As a result driver could be built on all platforms which support CLKDEV_LOOKUP
	This can improve the build test coverage

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
CC: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/include/mach/mmp2.h              |    2 +-
 drivers/mmc/host/Kconfig                           |    2 ++
 drivers/mmc/host/sdhci-pxav2.c                     |    2 +-
 drivers/mmc/host/sdhci-pxav3.c                     |    2 +-
 .../linux/platform_data/pxa_sdhci.h                |   10 +++++-----
 5 files changed, 10 insertions(+), 8 deletions(-)
 rename arch/arm/plat-pxa/include/plat/sdhci.h => include/linux/platform_data/pxa_sdhci.h (92%)

diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 2cbf6df..de7b888 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H
 
-#include <plat/sdhci.h>
+#include <linux/platform_data/pxa_sdhci.h>
 
 struct sys_timer;
 
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 198ddda..204ad7c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -183,6 +183,7 @@ config MMC_SDHCI_S3C
 
 config MMC_SDHCI_PXAV3
 	tristate "Marvell MMP2 SD Host Controller support (PXAV3)"
+	depends on CLKDEV_LOOKUP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default CPU_MMP2
@@ -195,6 +196,7 @@ config MMC_SDHCI_PXAV3
 
 config MMC_SDHCI_PXAV2
 	tristate "Marvell PXA9XX SD Host Controller support (PXAV2)"
+	depends on CLKDEV_LOOKUP
 	select MMC_SDHCI
 	select MMC_SDHCI_PLTFM
 	default CPU_PXA910
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 7a6fa8c..38f5899 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -25,7 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
-#include <plat/sdhci.h>
+#include <linux/platform_data/pxa_sdhci.h>
 #include <linux/slab.h>
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 901f00f..4198dbb 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -24,7 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
-#include <plat/sdhci.h>
+#include <linux/platform_data/pxa_sdhci.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include "sdhci.h"
diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/include/linux/platform_data/pxa_sdhci.h
similarity index 92%
rename from arch/arm/plat-pxa/include/plat/sdhci.h
rename to include/linux/platform_data/pxa_sdhci.h
index 800ebc1..51ad099 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/include/linux/platform_data/pxa_sdhci.h
@@ -1,4 +1,5 @@
-/* linux/arch/arm/plat-pxa/include/plat/sdhci.h
+/*
+ * include/linux/platform_data/pxa_sdhci.h
  *
  * Copyright 2010 Marvell
  *	Zhangfei Gao <zhangfei.gao@marvell.com>
@@ -10,8 +11,8 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __PLAT_PXA_SDHCI_H
-#define __PLAT_PXA_SDHCI_H
+#ifndef _PXA_SDHCI_H_
+#define _PXA_SDHCI_H_
 
 /* pxa specific flag */
 /* Require clock free running */
@@ -56,5 +57,4 @@ struct sdhci_pxa {
 	u8	clk_enable;
 	u8	power_mode;
 };
-
-#endif /* __PLAT_PXA_SDHCI_H */
+#endif /* _PXA_SDHCI_H_ */
-- 
1.7.0.4

