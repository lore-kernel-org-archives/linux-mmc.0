From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v3 7/9] omap: zoom: add fixed regulator device for wlan
Date: Wed, 11 Aug 2010 01:12:26 +0300
Message-ID: <1281478348-24833-8-git-send-email-ohad@wizery.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1281478348-24833-1-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Kalle Valo <kalle.valo@iki.fi>, Ohad Ben-Cohen <ohad@wizery.com>, Pandita Vikram <vikram.pandita@ti.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Roger Quadros <roger.quadros@nokia.com>, San Mehat <san@google.com>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, Luciano Coelho <luciano.coelho@nokia.com>, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add a fixed regulator vmmc device to enable power control
of the wl1271 wlan device.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   35 ++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..de88635 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -27,6 +28,8 @@
 #include "mux.h"
 #include "hsmmc.h"
 
+#define OMAP_ZOOM_WLAN_PMENA_GPIO	(101)
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -106,6 +109,11 @@ static struct regulator_consumer_supply zoom_vmmc2_supply = {
 	.supply		= "vmmc",
 };
 
+static struct regulator_consumer_supply zoom_vmmc3_supply = {
+	.supply		= "vmmc",
+	.dev_name	= "mmci-omap-hs.2",
+};
+
 /* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
 static struct regulator_init_data zoom_vmmc1 = {
 	.constraints = {
@@ -151,6 +159,32 @@ static struct regulator_init_data zoom_vsim = {
 	.consumer_supplies      = &zoom_vsim_supply,
 };
 
+static struct regulator_init_data zoom_vmmc3 = {
+	.constraints = {
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &zoom_vmmc3_supply,
+};
+
+static struct fixed_voltage_config zoom_vwlan = {
+	.supply_name = "vwl1271",
+	.microvolts = 1800000, /* 1.8V */
+	.gpio = OMAP_ZOOM_WLAN_PMENA_GPIO,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+	.init_data = &zoom_vmmc3,
+};
+
+static struct platform_device omap_vwlan_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data = &zoom_vwlan,
+	},
+};
+
 static struct omap2_hsmmc_info mmc[] __initdata = {
 	{
 		.name		= "external",
@@ -280,6 +314,7 @@ static void enable_board_wakeup_source(void)
 void __init zoom_peripherals_init(void)
 {
 	omap_i2c_init();
+	platform_device_register(&omap_vwlan_device);
 	usb_musb_init(&musb_board_data);
 	enable_board_wakeup_source();
 }
-- 
1.7.0.4
