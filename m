From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/2] s5pv210: Aquila: add definitions for sdhci devices
Date: Wed, 16 Jun 2010 08:49:14 +0200
Message-ID: <1276670954-17652-3-git-send-email-m.szyprowski@samsung.com>
References: <1276670954-17652-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:18388 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926Ab0FPGtZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jun 2010 02:49:25 -0400
In-reply-to: <1276670954-17652-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com

This patch add support for SDHCI blocks on Samsung Aquila board. The
following host controllers are defined:
1. Internal MoviNAND device (permanently wired to the controller)
2. Internal WiFI SDIO device (card is activated by power regualor)
3. External MMC/SD socket (card detection is provided by external
gpio interrupt)

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    4 +++
 arch/arm/mach-s5pv210/mach-aquila.c |   43 +++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0761eac..f48d70a 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -50,7 +50,11 @@ config MACH_AQUILA
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_SDHCI
 	select S3C_DEV_FB
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 10bc76e..a616498 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 #include <linux/fb.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -22,12 +23,15 @@
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-fb.h>
+#include <mach/regs-gpio.h>
 
 #include <plat/regs-serial.h>
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/gpio-cfg.h>
+#include <plat/sdhci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -116,8 +120,44 @@ static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
+/* MoviNAND */
+static struct s3c_sdhci_platdata aquila_hsmmc0_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_PERMANENT,
+};
+
+/* Wireless LAN */
+static struct s3c_sdhci_platdata aquila_hsmmc1_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
+	/* ext_cd_{init,cleanup} callbacks will be added later */
+};
+
+/* External Flash */
+#define AQUILA_EXT_FLASH_EN	S5PV210_MP05(4)
+#define AQUILA_EXT_FLASH_CD	S5PV210_GPH3(4)
+static struct s3c_sdhci_platdata aquila_hsmmc2_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= AQUILA_EXT_FLASH_CD,
+	.ext_cd_gpio_invert	= 1,
+};
+
+static void aquila_setup_sdhci()
+{
+	gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
+	gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
+
+	s3c_sdhci0_set_platdata(&aquila_hsmmc0_data);
+	s3c_sdhci1_set_platdata(&aquila_hsmmc1_data);
+	s3c_sdhci2_set_platdata(&aquila_hsmmc2_data);
+};
+
 static struct platform_device *aquila_devices[] __initdata = {
 	&s3c_device_fb,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 };
 
 static void __init aquila_map_io(void)
@@ -129,6 +169,9 @@ static void __init aquila_map_io(void)
 
 static void __init aquila_machine_init(void)
 {
+	/* SDHCI */
+	aquila_setup_sdhci();
+
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
-- 
1.7.1.240.g225c

