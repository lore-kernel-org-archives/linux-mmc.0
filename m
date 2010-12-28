From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 5/6 v3] sh: sh7722 Enable SDIO IRQs
Date: Tue, 28 Dec 2010 23:22:35 +0100
Message-ID: <1293574956-30035-6-git-send-email-arnd@arndnet.de>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:52598 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752053Ab0L1WYN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Dec 2010 17:24:13 -0500
In-Reply-To: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>

This patch enables the interrupt generation for SDIO IRQs
of the sdhi controllers of the SoC. To make sure SDIO IRQs
are used, announce the MMC_CAP_SDIO_IRQ capability
on migor.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
Changes in v3:
 - Added missing include to migor.

 arch/sh/boards/mach-migor/setup.c      |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 5dc72b4..affeec4 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
@@ -413,6 +414,7 @@ static struct resource sdhi_cn9_resources[] = {
 static struct sh_mobile_sdhi_info sh7724_sdhi_data = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
 };
 
 static struct platform_device sdhi_cn9_device = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index d551ed8..a164f89 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -699,7 +699,7 @@ static struct intc_mask_reg mask_registers[] __initdata = {
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { DISABLED, DISABLED, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
+	  { DISABLED, ENABLED, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB_USBI1, USB_USBI0, } },
 	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
-- 
1.7.2.3

