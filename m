From: Ido Yariv <ido@wizery.com>
Subject: [PATCH v2 6/6] arm: davinci: DA850: Add wl1271/wlan support
Date: Sun, 10 Jul 2011 16:14:39 +0300
Message-ID: <1310303679-17936-7-git-send-email-ido@wizery.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:37916 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1GJNPF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Jul 2011 09:15:05 -0400
Received: by mail-ww0-f42.google.com with SMTP id 11so1595481wwg.1
        for <linux-mmc@vger.kernel.org>; Sun, 10 Jul 2011 06:15:04 -0700 (PDT)
In-Reply-To: <1310303679-17936-1-git-send-email-ido@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>

The wl1271 daughter card for AM18x EVMs is a combo wireless connectivity
add-on card, based on the LS Research TiWi module with Texas
Instruments' wl1271 solution.
It is a 4-wire, 1.8V, embedded SDIO WLAN device with an external IRQ
line and is power-controlled by a GPIO-based fixed regulator.

This patch adds support for the WLAN capabilities of this expansion
board.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 arch/arm/mach-davinci/Kconfig           |   10 +++
 arch/arm/mach-davinci/board-da850-evm.c |  127 +++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index c0deaca..32d837d 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -192,6 +192,16 @@ config DA850_UI_RMII
 
 endchoice
 
+config DA850_WL12XX
+	bool "AM18x wl1271 daughter board"
+	depends on MACH_DAVINCI_DA850_EVM
+	help
+	  The wl1271 daughter card for AM18x EVMs is a combo wireless
+	  connectivity add-on card, based on the LS Research TiWi module with
+	  Texas Instruments' wl1271 solution.
+	  Say Y if you want to use a wl1271 expansion card connected to the
+	  AM18x EVM.
+
 config GPIO_PCA953X
 	default MACH_DAVINCI_DA850_EVM
 
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index a7b41bf..2dae1a1 100644
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
@@ -1117,6 +1122,126 @@ static __init int da850_evm_init_cpufreq(void)
 static __init int da850_evm_init_cpufreq(void) { return 0; }
 #endif
 
+#ifdef CONFIG_DA850_WL12XX
+
+static int da850_wl12xx_fref = WL12XX_REFCLOCK_38;
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
+	pr_debug("Powering %s wl12xx", power_on ? "on" : "off");
+
+	if (power_on == power_state)
+		return;
+	power_state = power_on;
+
+	if (power_on) {
+		/* Power up sequence required for wl127x devices */
+		gpio_set_value(DA850_WLAN_EN, 1);
+		usleep_range(15000, 15000);
+		gpio_set_value(DA850_WLAN_EN, 0);
+		usleep_range(1000, 1000);
+		gpio_set_value(DA850_WLAN_EN, 1);
+		msleep(70);
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
+	.board_ref_clock	= -1,
+	.platform_quirks	= WL12XX_PLATFORM_QUIRK_EDGE_IRQ,
+};
+
+static void da850_wl12xx_init(void)
+{
+	int ret;
+
+	ret = davinci_cfg_reg_list(da850_evm_mmc_wl12xx_pins);
+	if (ret) {
+		pr_warning("da850_evm_init: wl12xx/mmc mux setup failed:"
+			   " %d\n", ret);
+		return;
+	}
+
+	ret = da850_register_mmcsd1(&da850_mmc_wl12xx_config);
+	if (ret) {
+		pr_warning("da850_evm_init: wl12xx/mmc registration failed:"
+			   " %d\n", ret);
+		return;
+	}
+
+	ret = gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW, "wl12xx_en");
+	if (ret) {
+		pr_err("Error initializing the wl12xx enable gpio: %d\n", ret);
+		return;
+	}
+
+	ret = gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl12xx_irq");
+	if (ret) {
+		pr_err("Error initializing the wl12xx irq gpio: %d\n", ret);
+		gpio_free(DA850_WLAN_EN);
+		return;
+	}
+
+	da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
+	da850_wl12xx_wlan_data.board_ref_clock = da850_wl12xx_fref;
+
+	ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
+	if (ret) {
+		pr_err("Error setting wl12xx data: %d\n", ret);
+		gpio_free(DA850_WLAN_IRQ);
+		gpio_free(DA850_WLAN_EN);
+	}
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
@@ -1169,6 +1294,8 @@ static __init void da850_evm_init(void)
 		if (ret)
 			pr_warning("da850_evm_init: mmcsd0 registration failed:"
 					" %d\n", ret);
+
+		da850_wl12xx_init();
 	}
 
 	davinci_serial_init(&da850_evm_uart_config);
-- 
1.7.4.1

