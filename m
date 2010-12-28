From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 6/6 v3] sh: sh7723 / ap325rxa enable SDIO IRQs
Date: Tue, 28 Dec 2010 23:22:36 +0100
Message-ID: <1293574956-30035-7-git-send-email-arnd@arndnet.de>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1293574956-30035-1-git-send-email-arnd@arndnet.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, Arnd Hannemann <arnd@arndnet.de>
List-Id: linux-mmc@vger.kernel.org

This patch enables the interrupt generation for SDIO IRQs
of the sdhi controllers of the SoC. To make sure SDIO IRQs
are used announce the MMC_CAP_SDIO_IRQ capability
on ap325rxa.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
Acked-by: Magnus Damm <damm@opensource.se>
---
 arch/sh/boards/mach-ap325rxa/setup.c   |   16 ++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    4 ++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index 07ea908..3e5fc3b 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -14,6 +14,8 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mmc/host.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
 #include <linux/delay.h>
@@ -430,11 +432,18 @@ static struct resource sdhi0_cn3_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sdhi0_cn3_data = {
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
+};
+
 static struct platform_device sdhi0_cn3_device = {
 	.name		= "sh_mobile_sdhi",
 	.id             = 0, /* "sdhi0" clock */
 	.num_resources	= ARRAY_SIZE(sdhi0_cn3_resources),
 	.resource	= sdhi0_cn3_resources,
+	.dev = {
+		.platform_data = &sdhi0_cn3_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
 	},
@@ -453,11 +462,18 @@ static struct resource sdhi1_cn7_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sdhi1_cn7_data = {
+	.tmio_caps      = MMC_CAP_SDIO_IRQ,
+};
+
 static struct platform_device sdhi1_cn7_device = {
 	.name		= "sh_mobile_sdhi",
 	.id             = 1, /* "sdhi1" clock */
 	.num_resources	= ARRAY_SIZE(sdhi1_cn7_resources),
 	.resource	= sdhi1_cn7_resources,
+	.dev = {
+		.platform_data = &sdhi1_cn7_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI1,
 	},
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 0eadefd..d764122 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -719,7 +719,7 @@ static struct intc_group groups[] __initdata = {
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
 	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
-	    0, DISABLED, ENABLED, ENABLED } },
+	    0, ENABLED, ENABLED, ENABLED } },
 	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
 	  { VIO_VOUI, VIO_VEU2HI,VIO_BEUI,VIO_CEUI,DMAC0A_DEI3,DMAC0A_DEI2,DMAC0A_DEI1,DMAC0A_DEI0 } },
 	{ 0xa4080088, 0xa40800c8, 8, /* IMR2 / IMCR2 */
@@ -736,7 +736,7 @@ static struct intc_mask_reg mask_registers[] __initdata = {
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { 0, DISABLED, ENABLED, ENABLED,
+	  { 0, ENABLED, ENABLED, ENABLED,
 	    0, 0, SCIFA_SCIFA2, SIU_SIUI } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT_CMTI, 0, 0, USB_USI0,0 } },
-- 
1.7.2.3

