From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/3] s5pv210: Aquila: add definitions for sdhci devices
Date: Wed, 09 Jun 2010 11:39:05 +0200
Message-ID: <1276076345-24370-4-git-send-email-m.szyprowski@samsung.com>
References: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:34311 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab0FIJjM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2010 05:39:12 -0400
In-reply-to: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
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
 arch/arm/mach-s5pv210/Kconfig       |    4 ++
 arch/arm/mach-s5pv210/mach-aquila.c |   66 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index b7a2f38..dcc9d74 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -57,7 +57,11 @@ config MACH_AQUILA
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_SDHCI
 	select S3C_DEV_FB
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC1
+	select S3C_DEV_HSMMC2
 	select S5PC110_DEV_ONENAND
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index fb9dbb2..1b7fe79 100644
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
@@ -116,9 +120,66 @@ static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
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
+#define AQUILA_EXT_FLASH_IRQ	IRQ_EINT(28)	/* S5PV210_GPH3(4) */
+#define AQUILA_EXT_FLASH_EN	S5PV210_MP05(4)
+#define AQUILA_EXT_FLASH_CD	S5PV210_GPH3(4)
+
+static irqreturn_t aquila_ext_flash_card_detect_isr(int irq, void *dev_id)
+{
+	void (*notify_func)(struct platform_device *, int state) = dev_id;
+	notify_func(&s3c_device_hsmmc2, !gpio_get_value(AQUILA_EXT_FLASH_CD));
+	return IRQ_HANDLED;
+}
+
+static int aquila_ext_flash_card_detect_init(
+		void (*notify_func)(struct platform_device *, int state))
+{
+	gpio_request(AQUILA_EXT_FLASH_EN, "FLASH_EN");
+	gpio_direction_output(AQUILA_EXT_FLASH_EN, 1);
+
+	if (request_irq(AQUILA_EXT_FLASH_IRQ, aquila_ext_flash_card_detect_isr,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"SDHCI card detect", notify_func))
+		printk(KERN_ERR "Error: cannot request irq for External Flash\n");
+	return 0;
+}
+
+static int aquila_ext_flash_card_detect_cleanup(
+		void (*notify_func)(struct platform_device *, int state))
+{
+	free_irq(AQUILA_EXT_FLASH_IRQ, notify_func);
+	gpio_direction_output(AQUILA_EXT_FLASH_EN, 0);
+	gpio_free(AQUILA_EXT_FLASH_EN);
+	return 0;
+}
+
+static struct s3c_sdhci_platdata aquila_hsmmc2_data __initdata = {
+	.max_width		= 4,
+	.cd_type		= S3C_SDHCI_CD_EXTERNAL,
+	.ext_cd_init		= aquila_ext_flash_card_detect_init,
+	.ext_cd_cleanup		= aquila_ext_flash_card_detect_cleanup,
+};
+
 static struct platform_device *aquila_devices[] __initdata = {
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
 };
 
 static void __init aquila_map_io(void)
@@ -130,6 +191,11 @@ static void __init aquila_map_io(void)
 
 static void __init aquila_machine_init(void)
 {
+	/* SDHCI */
+	s3c_sdhci0_set_platdata(&aquila_hsmmc0_data);
+	s3c_sdhci1_set_platdata(&aquila_hsmmc1_data);
+	s3c_sdhci2_set_platdata(&aquila_hsmmc2_data);
+
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
-- 
1.7.1.240.g225c

