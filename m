From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 4/5] mach-mmp: PXA168: support multiple SD controllers
Date: Sun, 13 Feb 2011 22:53:02 -0800
Message-ID: <98D93479-F894-4649-966D-D5B8DA2DF3E8@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:33299 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751761Ab1BNGyX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 01:54:23 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>


Subject: [PATCH 4/5] mach-mmp: PXA168: support multiple SD controllers

add support for pxa168 family for multiple sd controllers
move board specific settings from mfp-pxa168.h to aspenite.c

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/aspenite.c                |   61 +++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/mfp-pxa168.h |   24 ++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h     |   30 +++++++++++++
 arch/arm/mach-mmp/pxa168.c                  |   36 ++++++++++++++++
 4 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 06b5fa8..74914c4 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -27,6 +27,7 @@
 #include <video/pxa168fb.h>
 #include <linux/input.h>
 #include <plat/pxa27x_keypad.h>
+#include <plat/sdhci.h>
 
 #include "common.h"
 
@@ -109,6 +110,41 @@ static unsigned long common_pin_config[] __initdata = {
 	GPIO121_KP_MKIN4,
 };
 
+static unsigned long mmc1_pin_config[] __initdata = {
+	GPIO51_MMC1_DAT3 | MFP_DRIVE_FAST,
+	GPIO52_MMC1_DAT2 | MFP_DRIVE_FAST,
+	GPIO40_MMC1_DAT1 | MFP_DRIVE_FAST,
+	GPIO41_MMC1_DAT0 | MFP_DRIVE_FAST,
+	GPIO49_MMC1_CMD | MFP_DRIVE_FAST,
+	GPIO43_MMC1_CLK | MFP_DRIVE_FAST,
+	GPIO53_MMC1_CD | MFP_DRIVE_FAST,
+	GPIO46_MMC1_WP | MFP_DRIVE_FAST,
+};
+
+static unsigned long mmc2_pin_config[] __initdata = {
+	GPIO90_MMC2_DAT3 | MFP_DRIVE_FAST,
+	GPIO91_MMC2_DAT2 | MFP_DRIVE_FAST,
+	GPIO92_MMC2_DAT1 | MFP_DRIVE_FAST,
+	GPIO93_MMC2_DAT0 | MFP_DRIVE_FAST,
+	GPIO94_MMC2_CMD | MFP_DRIVE_FAST,
+	GPIO95_MMC2_CLK | MFP_DRIVE_FAST,
+};
+
+#ifdef CONFIG_ASPENITE_MMC3
+static unsigned long mmc3_pin_config[] __initdata = {
+	GPIO0_MMC3_DAT7 | MFP_DRIVE_FAST,
+	GPIO1_MMC3_DAT6 | MFP_DRIVE_FAST,
+	GPIO2_MMC3_DAT5 | MFP_DRIVE_FAST,
+	GPIO3_MMC3_DAT4 | MFP_DRIVE_FAST,
+	GPIO4_MMC3_DAT3 | MFP_DRIVE_FAST,
+	GPIO5_MMC3_DAT2 | MFP_DRIVE_FAST,
+	GPIO6_MMC3_DAT1 | MFP_DRIVE_FAST,
+	GPIO7_MMC3_DAT0 | MFP_DRIVE_FAST,
+	GPIO8_MMC3_CLK | MFP_DRIVE_FAST,
+	GPIO9_MMC3_CMD | MFP_DRIVE_FAST,
+};
+#endif
+
 static struct smc91x_platdata smc91x_info = {
 	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -220,6 +256,21 @@ static struct pxa27x_keypad_platform_data aspenite_keypad_info __initdata = {
 	.debounce_interval	= 30,
 };
 
+static struct sdhci_pxa_platdata pxa168_sdh_platdata_mmc1 = {
+};
+
+static struct sdhci_pxa_platdata pxa168_sdh_platdata_mmc2 = {
+	.max_speed	= 24000000,
+	.flags		= PXA_FLAG_CARD_PERMANENT,
+};
+
+#ifdef CONFIG_ASPENITE_MMC3
+static struct sdhci_pxa_platdata pxa168_sdh_platdata_mmc3 = {
+	.flags		= PXA_FLAG_CARD_PERMANENT |
+				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
+};
+#endif
+
 static void __init common_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(common_pin_config));
@@ -232,6 +283,16 @@ static void __init common_init(void)
 	pxa168_add_fb(&aspenite_lcd_info);
 	pxa168_add_keypad(&aspenite_keypad_info);
 
+	mfp_config(ARRAY_AND_SIZE(mmc1_pin_config));
+	pxa168_add_sdhost(0, &pxa168_sdh_platdata_mmc1); /* SD Slot */
+
+	mfp_config(ARRAY_AND_SIZE(mmc2_pin_config));
+	pxa168_add_sdhost(1, &pxa168_sdh_platdata_mmc2); /* Wifi */
+#ifdef CONFIG_ASPENITE_MMC3
+	mfp_config(ARRAY_AND_SIZE(mmc3_pin_config));
+	pxa168_add_sdhost(2, &pxa168_sdh_platdata_mmc3); /* eMMC */
+#endif
+
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
 }
diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
index 4621067..2600dcb 100644
--- a/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/mfp-pxa168.h
@@ -210,6 +210,7 @@
 #define GPIO112_UART1_DCD	MFP_CFG(GPIO112, AF2)
 
 /* MMC1 */
+/* PULL and DRIVE are functions of the board */
 #define GPIO37_MMC1_DAT7	MFP_CFG(GPIO37, AF1)
 #define GPIO38_MMC1_DAT6	MFP_CFG(GPIO38, AF1)
 #define GPIO54_MMC1_DAT5	MFP_CFG(GPIO54, AF1)
@@ -223,6 +224,29 @@
 #define GPIO53_MMC1_CD		MFP_CFG(GPIO53, AF1)
 #define GPIO46_MMC1_WP		MFP_CFG(GPIO46, AF1)
 
+/*MMC2*/
+/* PULL and DRIVE are functions of the board */
+#define	GPIO90_MMC2_DAT3	MFP_CFG(GPIO90, AF1)
+#define	GPIO91_MMC2_DAT2	MFP_CFG(GPIO91, AF1)
+#define	GPIO92_MMC2_DAT1	MFP_CFG(GPIO92, AF1)
+#define	GPIO93_MMC2_DAT0	MFP_CFG(GPIO93, AF1)
+#define	GPIO94_MMC2_CMD		MFP_CFG(GPIO94, AF1)
+#define	GPIO95_MMC2_CLK		MFP_CFG(GPIO95, AF1)
+
+/* MMC3*/
+/* PULL and DRIVE are functions of the board */
+#define GPIO0_MMC3_DAT7		MFP_CFG(GPIO0, AF6)
+#define GPIO1_MMC3_DAT6		MFP_CFG(GPIO1, AF6)
+#define GPIO2_MMC3_DAT5		MFP_CFG(GPIO2, AF6)
+#define GPIO3_MMC3_DAT4		MFP_CFG(GPIO3, AF6)
+#define GPIO4_MMC3_DAT3		MFP_CFG(GPIO4, AF6)
+#define GPIO5_MMC3_DAT2		MFP_CFG(GPIO5, AF6)
+#define GPIO6_MMC3_DAT1		MFP_CFG(GPIO6, AF6)
+#define GPIO7_MMC3_DAT0		MFP_CFG(GPIO7, AF6)
+#define GPIO8_MMC3_CLK			MFP_CFG(GPIO8, AF6)
+#define GPIO9_MMC3_CMD			MFP_CFG(GPIO9, AF6)
+#define GPIO16_SMC_nCS0_DIS		MFP_CFG(GPIO16, AF0)
+
 /* LCD */
 #define GPIO84_LCD_CS		MFP_CFG(GPIO84, AF1)
 #define GPIO60_LCD_DD0		MFP_CFG(GPIO60, AF1)
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 1801e42..2b84dea 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -14,6 +14,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 #include <video/pxa168fb.h>
 #include <plat/pxa27x_keypad.h>
 #include <mach/cputype.h>
+#include <plat/sdhci.h>
 
 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -31,6 +32,11 @@ extern struct pxa_device_desc pxa168_device_ssp5;
 extern struct pxa_device_desc pxa168_device_nand;
 extern struct pxa_device_desc pxa168_device_fb;
 extern struct pxa_device_desc pxa168_device_keypad;
+extern struct pxa_device_desc pxa168_device_sdh0;
+extern struct pxa_device_desc pxa168_device_sdh1;
+extern struct pxa_device_desc pxa168_device_sdh2;
+extern struct pxa_device_desc pxa168_device_sdh3;
+
 
 static inline int pxa168_add_uart(int id)
 {
@@ -99,6 +105,30 @@ static inline int pxa168_add_ssp(int id)
 	return pxa_register_device(d, NULL, 0);
 }
 
+static inline int pxa168_add_sdhost(int id, struct sdhci_pxa_platdata *data)
+{
+	struct pxa_device_desc *d = NULL;
+
+	switch (id) {
+	case 0:
+		d = &pxa168_device_sdh0;
+		break;
+	case 1:
+		d = &pxa168_device_sdh1;
+		break;
+	case 2:
+		d = &pxa168_device_sdh2;
+		break;
+	case 3:
+		d = &pxa168_device_sdh3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return pxa_register_device(d, data, sizeof(*data));
+}
+
 static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 72b4e76..d769d4a 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -63,6 +63,30 @@ void __init pxa168_init_irq(void)
 	pxa168_init_gpio();
 }
 
+static void sdhc_clk_enable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =  __raw_readl(clk->clk_rst);
+	clk_rst |= clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+static void sdhc_clk_disable(struct clk *clk)
+{
+	uint32_t clk_rst;
+
+	clk_rst  =  __raw_readl(clk->clk_rst);
+	clk_rst &= ~clk->enable_val;
+	__raw_writel(clk_rst, clk->clk_rst);
+}
+
+struct clkops sdhc_clk_ops = {
+	.enable		= sdhc_clk_enable,
+	.disable	= sdhc_clk_disable,
+};
+
+
 /* APB peripheral clocks */
 static APBC_CLK(uart1, PXA168_UART1, 1, 14745600);
 static APBC_CLK(uart2, PXA168_UART2, 1, 14745600);
@@ -81,6 +105,10 @@ static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
 
 static APMU_CLK(nand, NAND, 0x01db, 208000000);
 static APMU_CLK(lcd, LCD, 0x7f, 312000000);
+static APMU_CLK_OPS(sdh0, PXA168_SDH0, 0x1b, 48000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh1, PXA168_SDH1, 0x1b, 48000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh2, PXA168_SDH2, 0x1b, 48000000, &sdhc_clk_ops);
+static APMU_CLK_OPS(sdh3, PXA168_SDH3, 0x1b, 48000000, &sdhc_clk_ops);
 
 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
@@ -100,6 +128,10 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
+	INIT_CLKREG(&clk_sdh0, "sdhci-pxa.0", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh1, "sdhci-pxa.1", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh2, "sdhci-pxa.2", "PXA-SDHCLK"),
+	INIT_CLKREG(&clk_sdh3, "sdhci-pxa.3", "PXA-SDHCLK"),
 };
 
 static int __init pxa168_init(void)
@@ -163,3 +195,7 @@ PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
 PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
 PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
+PXA168_DEVICE(sdh0, "sdhci-pxa", 0, SDH1, 0xd4280000, 0x100);
+PXA168_DEVICE(sdh1, "sdhci-pxa", 1, SDH1, 0xd4281000, 0x100);
+PXA168_DEVICE(sdh2, "sdhci-pxa", 2, SDH2, 0xd427e000, 0x100);
+PXA168_DEVICE(sdh3, "sdhci-pxa", 3, SDH2, 0xd427f000, 0x100);
-- 
1.7.0.4


