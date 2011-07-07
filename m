From: Ido Yariv <ido@wizery.com>
Subject: [PATCH 5/5] arm: davinci: DA850: Add wl12xx expansion board support
Date: Fri,  8 Jul 2011 00:33:10 +0300
Message-ID: <1310074390-4277-6-git-send-email-ido@wizery.com>
References: <1310074390-4277-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41458 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab1GGVdd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2011 17:33:33 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so1362105wwe.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2011 14:33:33 -0700 (PDT)
In-Reply-To: <1310074390-4277-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

The DA850 supports an optional wl12xx based expansion board, adding WLAN
& BT capabilities. The wl12xx is a 4-wire, 1.8V, embedded SDIO WLAN
device with an external IRQ line and is power-controlled by a GPIO-based
fixed regulator.

This patch adds support for the WLAN capabilities of this expansion
board.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/Kconfig            |   31 +++++++
 arch/arm/mach-davinci/board-da850-evm.c  |  128 ++++++++++++++++++++++++++++++
 arch/arm/mach-davinci/da850.c            |    9 ++
 arch/arm/mach-davinci/include/mach/mux.h |   10 +++
 4 files changed, 178 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index c0deaca..1a9149c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -192,6 +192,37 @@ config DA850_UI_RMII
 
 endchoice
 
+config DA850_WL12XX
+	bool "DA850 wl12xx expansion board"
+	depends on MACH_DAVINCI_DA850_EVM
+	---help---
+	  Say Y if you want to use a wl12xx expansion board connected to the
+	  DA850 EVM.
+
+choice
+	prompt "FREF reference clock used by the wl12XX expansion board"
+	default DA850_WL12XX_FREF_38_4
+	depends on DA850_WL12XX
+	help
+	  There are currently two kinds of such daughter boards, one made by
+	  Mistral and another by LS Research. These (and perhaps others) use
+	  different FREF reference clocks. Select the correct one according to
+	  the daughter board's type.
+
+config DA850_WL12XX_FREF_19_2
+	bool "19.2MHz"
+config DA850_WL12XX_FREF_26
+	bool "26MHz"
+config DA850_WL12XX_FREF_38_4
+	bool "38.4MHz"
+config DA850_WL12XX_FREF_52
+	bool "52MHz"
+config DA850_WL12XX_FREF_XTAL_26
+	bool "XTAL 26MHz"
+config DA850_WL12XX_FREF_XTAL_38_4
+	bool "XTAL 38MHz"
+endchoice
+
 config GPIO_PCA953X
 	default MACH_DAVINCI_DA850_EVM
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..a567379 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -31,6 +31,8 @@
 #include <linux/input/tps6507x-ts.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
+#include <linux/delay.h>
+#include <linux/wl12xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -49,6 +51,9 @@
 #define DA850_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
 #define DA850_MMCSD_WP_PIN		GPIO_TO_PIN(4, 1)
 
+#define DA850_WLAN_EN			GPIO_TO_PIN(6, 9)
+#define DA850_WLAN_IRQ			GPIO_TO_PIN(6, 10)
+
 #define DA850_MII_MDIO_CLKEN_PIN	GPIO_TO_PIN(2, 6)
 
 static struct mtd_partition da850evm_spiflash_part[] = {
@@ -1117,6 +1122,127 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+#ifdef CONFIG_DA850_WL12XX
+
+static int da850_wl12xx_fref = -1;
+
+static int __init setup_da850_wl12xx_fref(char *fref)
+{
+	if (!strcmp(fref, "19.2"))
+		da850_wl12xx_fref = WL12XX_REFCLOCK_19;
+	else if (!strcmp(fref, "26"))
+		da850_wl12xx_fref = WL12XX_REFCLOCK_26;
+	else if (!strcmp(fref, "38.4"))
+		da850_wl12xx_fref = WL12XX_REFCLOCK_38;
+	else if (!strcmp(fref, "52"))
+		da850_wl12xx_fref = WL12XX_REFCLOCK_52;
+	else if (!strcmp(fref, "XTAL26"))
+		da850_wl12xx_fref = WL12XX_REFCLOCK_26_XTAL;
+	else if (!strcmp(fref, "XTAL38.4"))
+		da850_wl12xx_fref = WL12XX_REFCLOCK_38_XTAL;
+	else
+		pr_info("da850_wl12xx_fref is invalid. Valid options: "
+			"19.2, 26, 38.4, 52, XTAL26 or XTAL38.4\n");
+	return 0;
+}
+__setup("da850_wl12xx_fref=", setup_da850_wl12xx_fref);
+
+static void wl12xx_set_power(int slot, bool power_on)
+{
+	static bool power_state;
+
+	pr_debug("Powering %s wl12xx", (power_on ? "on" : "off"));
+
+	if (power_on == power_state)
+		return;
+	power_state = power_on;
+
+	if (power_on) {
+		/* Power up sequence required for wl127x devices */
+		gpio_set_value(DA850_WLAN_EN, 1);
+		mdelay(15);
+		gpio_set_value(DA850_WLAN_EN, 0);
+		mdelay(1);
+		gpio_set_value(DA850_WLAN_EN, 1);
+		mdelay(70);
+	} else {
+		gpio_set_value(DA850_WLAN_EN, 0);
+	}
+}
+
+static struct davinci_mmc_config da850_mmc_wl12xx_config = {
+	.get_ro		= NULL,
+	.get_cd		= NULL,
+	.set_power	= wl12xx_set_power,
+	.wires		= 4,
+	.max_freq	= 25000000,
+	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_NONREMOVABLE |
+			  MMC_CAP_POWER_OFF_CARD,
+	.version	= MMC_CTLR_VERSION_2,
+};
+
+static const short da850_evm_mmc_wl12xx_pins[] __initconst = {
+	DA850_MMCSD1_DAT_0, DA850_MMCSD1_DAT_1, DA850_MMCSD1_DAT_2,
+	DA850_MMCSD1_DAT_3, DA850_MMCSD1_CLK, DA850_MMCSD1_CMD,
+	DA850_GPIO6_9, DA850_GPIO6_10,
+	-1
+};
+
+static struct wl12xx_platform_data da850_wl12xx_wlan_data __initdata = {
+	.irq			= -1,
+#ifdef CONFIG_DA850_WL12XX_FREF_19_2
+	.board_ref_clock	= WL12XX_REFCLOCK_19,
+#elif defined CONFIG_DA850_WL12XX_FREF_26
+	.board_ref_clock	= WL12XX_REFCLOCK_26,
+#elif defined CONFIG_DA850_WL12XX_FREF_38_4
+	.board_ref_clock	= WL12XX_REFCLOCK_38,
+#elif defined CONFIG_DA850_WL12XX_FREF_52
+	.board_ref_clock	= WL12XX_REFCLOCK_52,
+#elif defined CONFIG_DA850_WL12XX_FREF_XTAL_26
+	.board_ref_clock	= WL12XX_REFCLOCK_26_XTAL,
+#elif defined CONFIG_DA850_WL12XX_FREF_XTAL_38_4
+	.board_ref_clock	= WL12XX_REFCLOCK_38_XTAL,
+#endif
+	.platform_quirks	= WL12XX_PLATFORM_QUIRK_EDGE_IRQ,
+};
+
+static void da850_wl12xx_init(void)
+{
+	int ret;
+
+	ret = davinci_cfg_reg_list(da850_evm_mmc_wl12xx_pins);
+	if (ret)
+		pr_warning("da850_evm_init: wl12xx/mmc mux setup failed:"
+			   " %d\n", ret);
+
+	ret = da850_register_mmcsd1(&da850_mmc_wl12xx_config);
+	if (ret)
+		pr_warning("da850_evm_init: wl12xx/mmc registration failed:"
+			   " %d\n", ret);
+
+	if (gpio_request(DA850_WLAN_EN, "wl12xx_en") ||
+	    gpio_direction_output(DA850_WLAN_EN, 0))
+		pr_err("Error initializing the wl12xx enable gpio\n");
+
+	if (gpio_request(DA850_WLAN_IRQ, "wl12xx_irq") ||
+	    gpio_direction_input(DA850_WLAN_IRQ))
+		pr_err("Error initializing the wl12xx irq gpio\n");
+	else
+		da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
+
+	if (da850_wl12xx_fref != -1)
+		da850_wl12xx_wlan_data.board_ref_clock = da850_wl12xx_fref;
+
+	if (wl12xx_set_platform_data(&da850_wl12xx_wlan_data))
+		pr_err("Error setting wl12xx data\n");
+}
+
+#else /* CONFIG_DA850_WL12XX */
+
+static void da850_wl12xx_init(void) { }
+
+#endif /* CONFIG_DA850_WL12XX */
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -1169,6 +1295,8 @@ static __init void da850_evm_init(void)
 		if (ret)
 			pr_warning("da850_evm_init: mmcsd0 registration failed:"
 					" %d\n", ret);
+
+		da850_wl12xx_init();
 	}
 
 	davinci_serial_init(&da850_evm_uart_config);
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 133aac4..bfe9b71 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -525,6 +525,13 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, MMCSD0_DAT_3,	10,	20,	15,	2,	false)
 	MUX_CFG(DA850, MMCSD0_CLK,	10,	0,	15,	2,	false)
 	MUX_CFG(DA850, MMCSD0_CMD,	10,	4,	15,	2,	false)
+	/* MMC/SD1 function */
+	MUX_CFG(DA850, MMCSD1_DAT_0,	18,	8,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_1,	19,	16,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_2,	19,	12,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_DAT_3,	19,	8,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_CLK,	18,	12,	15,	2,	false)
+	MUX_CFG(DA850, MMCSD1_CMD,	18,	16,	15,	2,	false)
 	/* EMIF2.5/EMIFA function */
 	MUX_CFG(DA850, EMA_D_7,		9,	0,	15,	1,	false)
 	MUX_CFG(DA850, EMA_D_6,		9,	4,	15,	1,	false)
@@ -583,6 +590,8 @@ static const struct mux_config da850_pins[] = {
 	MUX_CFG(DA850, GPIO3_13,	7,	8,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_0,		10,	28,	15,	8,	false)
 	MUX_CFG(DA850, GPIO4_1,		10,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_9,		13,	24,	15,	8,	false)
+	MUX_CFG(DA850, GPIO6_10,	13,	20,	15,	8,	false)
 	MUX_CFG(DA850, GPIO6_13,	13,	8,	15,	8,	false)
 	MUX_CFG(DA850, RTC_ALARM,	0,	28,	15,	2,	false)
 #endif
diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
index 5d4e0fe..a7e92fc 100644
--- a/arch/arm/mach-davinci/include/mach/mux.h
+++ b/arch/arm/mach-davinci/include/mach/mux.h
@@ -857,6 +857,14 @@ enum davinci_da850_index {
 	DA850_MMCSD0_CLK,
 	DA850_MMCSD0_CMD,
 
+	/* MMC/SD1 function */
+	DA850_MMCSD1_DAT_0,
+	DA850_MMCSD1_DAT_1,
+	DA850_MMCSD1_DAT_2,
+	DA850_MMCSD1_DAT_3,
+	DA850_MMCSD1_CLK,
+	DA850_MMCSD1_CMD,
+
 	/* EMIF2.5/EMIFA function */
 	DA850_EMA_D_7,
 	DA850_EMA_D_6,
@@ -916,6 +924,8 @@ enum davinci_da850_index {
 	DA850_GPIO3_13,
 	DA850_GPIO4_0,
 	DA850_GPIO4_1,
+	DA850_GPIO6_9,
+	DA850_GPIO6_10,
 	DA850_GPIO6_13,
 	DA850_RTC_ALARM,
 };
-- 
1.7.4.1

