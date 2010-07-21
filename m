From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 13/20] omap: zoom: add mmc3/wl1271 device support
Date: Wed, 21 Jul 2010 20:33:47 +0300
Message-ID: <1279733634-21974-14-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1279733634-21974-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add MMC3 support on ZOOM, which has the wl1271 device hardwired to.

The wl1271 is a 4-wire, 1.8V, embedded SDIO WLAN device with an
external IRQ line, and power-controlled by a GPIO-based fixed regulator.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 2fc0f4a..3230801 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -17,6 +17,8 @@
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
+#include <linux/mmc/host.h>
+#include <linux/wl12xx.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -29,6 +31,7 @@
 #include "hsmmc.h"
 
 #define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
+#define OMAP_ZOOM_WLAN_IRQ_GPIO		(162)
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -184,6 +187,12 @@ static struct platform_device omap_vwlan_device = {
 	},
 };
 
+struct wl12xx_platform_data omap_zoom_wlan_data = {
+	.irq = OMAP_GPIO_IRQ(OMAP_ZOOM_WLAN_IRQ_GPIO),
+	/* ZOOM ref clock is 26 MHz */
+	.board_ref_clock = 1,
+};
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -201,6 +210,15 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.nonremovable	= true,
 		.power_saving	= true,
 	},
+	{
+		.name		= "wl1271",
+		.mmc		= 3,
+		.wires		= 4,
+		.gpio_wp	= -EINVAL,
+		.gpio_cd	= -EINVAL,
+		.ocr_mask	= MMC_VDD_165_195,
+		.priv_data	= &omap_zoom_wlan_data,
+	},
 	{}      /* Terminator */
 };
 
@@ -217,6 +235,7 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	zoom_vmmc1_supply.dev = mmc[0].dev;
 	zoom_vsim_supply.dev = mmc[0].dev;
 	zoom_vmmc2_supply.dev = mmc[1].dev;
+	zoom_vmmc3_supply.dev = mmc[2].dev;
 
 	return 0;
 }
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
