From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 3/6] powerpc/fsl: move mpc85xx.h to include/linux
Date: Mon, 14 Dec 2015 12:24:24 +0800
Message-ID: <1450067067-44869-4-git-send-email-yangbo.lu@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0137.outbound.protection.outlook.com ([65.55.169.137]:33694
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752213AbbLNErN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 13 Dec 2015 23:47:13 -0500
In-Reply-To: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: scottwood@freescale.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Move mpc85xx.h to include/linux and rename it to svr.h as
a common header file. It has been used for mpc85xx and it will
be used for ARM-based SoC as well.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v2:
	- None
Changes for v3:
	- None
Changes for v4:
	- None
---
 drivers/clk/clk-qoriq.c                                   | 2 +-
 drivers/i2c/busses/i2c-mpc.c                              | 2 +-
 drivers/iommu/fsl_pamu.c                                  | 2 +-
 drivers/net/ethernet/freescale/gianfar.c                  | 2 +-
 arch/powerpc/include/asm/mpc85xx.h => include/linux/svr.h | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/powerpc/include/asm/mpc85xx.h => include/linux/svr.h (97%)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 1ab0fb8..98c5ae0 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -1146,7 +1146,7 @@ bad_args:
 }
 
 #ifdef CONFIG_PPC
-#include <asm/mpc85xx.h>
+#include <linux/svr.h>
 
 static const u32 a4510_svrs[] __initconst = {
 	(SVR_P2040 << 8) | 0x10,	/* P2040 1.0 */
diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 48ecffe..24b5bc7 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -27,9 +27,9 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/svr.h>
 
 #include <asm/mpc52xx.h>
-#include <asm/mpc85xx.h>
 #include <sysdev/fsl_soc.h>
 
 #define DRV_NAME "mpc-i2c"
diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index a34355f..b014b63 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -24,7 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 
-#include <asm/mpc85xx.h>
+#include <linux/svr.h>
 
 /* define indexes for each operation mapping scenario */
 #define OMI_QMAN        0x00
diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 3e6b9b4..9b2d641 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -90,7 +90,7 @@
 #include <asm/io.h>
 #ifdef CONFIG_PPC
 #include <asm/reg.h>
-#include <asm/mpc85xx.h>
+#include <linux/svr.h>
 #endif
 #include <asm/irq.h>
 #include <asm/uaccess.h>
diff --git a/arch/powerpc/include/asm/mpc85xx.h b/include/linux/svr.h
similarity index 97%
rename from arch/powerpc/include/asm/mpc85xx.h
rename to include/linux/svr.h
index 213f3a8..531b5a9 100644
--- a/arch/powerpc/include/asm/mpc85xx.h
+++ b/include/linux/svr.h
@@ -9,8 +9,8 @@
  * (at your option) any later version.
  */
 
-#ifndef __ASM_PPC_MPC85XX_H
-#define __ASM_PPC_MPC85XX_H
+#ifndef __SVR_H__
+#define __SVR_H__
 
 #define SVR_REV(svr)	((svr) & 0xFF)		/* SOC design resision */
 #define SVR_MAJ(svr)	(((svr) >>  4) & 0xF)	/* Major revision field*/
-- 
2.1.0.27.g96db324

