From: <dinguyen@altera.com>
Subject: [RESEND PATCHv2 1/3] arm: socfpga: Set the SDMMC clock phase in system manager
Date: Mon, 14 Oct 2013 14:47:29 -0500
Message-ID: <1381780051-1826-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0248.outbound.messaging.microsoft.com ([213.199.154.248]:5227
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756718Ab3JNTsC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 15:48:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Pavel Machek <pavel@denx.de>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Add functionality in the System Manager to set the SDR settings for the
SD/MMC IP.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Cc: Pavel Machek <pavel@denx.de>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>
Cc: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org

---
v2:
- Have socfpga_sysmgr_set_dwmmc_drvsel_smpsel() take in the SDR settings
directly so that it does not have to walk the DTB.
---
 arch/arm/mach-socfpga/Makefile     |    2 +-
 arch/arm/mach-socfpga/core.h       |    6 ++++++
 arch/arm/mach-socfpga/system_mgr.c |   28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-socfpga/system_mgr.c

diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 6dd7a93..e4ff8b9 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -2,5 +2,5 @@
 # Makefile for the linux kernel.
 #
 
-obj-y					:= socfpga.o
+obj-y					:= socfpga.o system_mgr.o
 obj-$(CONFIG_SMP)	+= headsmp.o platsmp.o
diff --git a/arch/arm/mach-socfpga/core.h b/arch/arm/mach-socfpga/core.h
index 572b8f7..b05fa6a 100644
--- a/arch/arm/mach-socfpga/core.h
+++ b/arch/arm/mach-socfpga/core.h
@@ -44,4 +44,10 @@ extern unsigned long cpu1start_addr;
 
 #define SOCFPGA_SCU_VIRT_BASE   0xfffec000
 
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMCGRP_CTRL_OFFSET             0x108
+#define DRV_CLK_PHASE_SHIFT_SEL_MASK    0x7
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
 #endif
diff --git a/arch/arm/mach-socfpga/system_mgr.c b/arch/arm/mach-socfpga/system_mgr.c
new file mode 100644
index 0000000..9fdce1d
--- /dev/null
+++ b/arch/arm/mach-socfpga/system_mgr.c
@@ -0,0 +1,28 @@
+/*
+ * Copyright Altera Corporation (C) 2013. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/of_platform.h>
+#include <asm/mach/map.h>
+
+#include "core.h"
+
+void socfpga_sysmgr_set_dwmmc_drvsel_smpsel(u32 drvsel, u32 smplsel)
+{
+	u32 hs_timing;
+
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel);
+	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
+}
+EXPORT_SYMBOL(socfpga_sysmgr_set_dwmmc_drvsel_smpsel);
-- 
1.7.9.5


