From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 6/7] OMAP4: Fix for CONTROL register Base
Date: Wed, 21 Apr 2010 23:51:04 +0530 (IST)
Message-ID: <63621.10.24.255.18.1271874064.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54832 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755132Ab0DUSVT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2010 14:21:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the base address of CONTROL register on OMAP4430SDP.
The control base is used by peripherals like MMC1 for PBIAS configuration.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 2302474..b3ef1a7 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -32,7 +32,7 @@
 #define OMAP4430_PRM_BASE		0x4a306000
 #define OMAP44XX_GPMC_BASE		0x50000000
 #define OMAP443X_SCM_BASE		0x4a002000
-#define OMAP443X_CTRL_BASE		OMAP443X_SCM_BASE
+#define OMAP443X_CTRL_BASE		0x4a100000
 #define OMAP44XX_IC_BASE		0x48200000
 #define OMAP44XX_IVA_INTC_BASE		0x40000000
 #define IRQ_SIR_IRQ			0x0040
-- 
1.6.3.3

