From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 2/3] ARM: S5PV210: Add support SDMMC WP through EXT_INT on SMDKV210
Date: Sat,  3 Jul 2010 10:00:43 +0900
Message-ID: <1278118844-21770-3-git-send-email-kgene.kim@samsung.com>
References: <1278118844-21770-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1278118844-21770-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, Hyuk Lee <hyuk1.lee@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

S5PV210 HSMMC host controller doesn't have the Write Protection pin which
should be connnected with SDMMC card WP pin. So send the allocated GPIO number
which is connected with WP pin of SD slot in order to implement get_ro function
in sdhci-s3c.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/mach-smdkv210.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index b08f376..89b469f 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -27,6 +28,7 @@
 #include <plat/cpu.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/sdhci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -91,6 +93,22 @@ static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.oversampling_shift	= 2,
 };
 
+static struct s3c_sdhci_platdata smdkv210_hsmmc0_pdata __initdata = {
+	.wp_gpio		= S5PV210_GPH0(7),
+};
+
+static struct s3c_sdhci_platdata smdkv210_hsmmc1_pdata __initdata = {
+	.wp_gpio		= S5PV210_GPH0(7),
+};
+
+static struct s3c_sdhci_platdata smdkv210_hsmmc2_pdata __initdata = {
+	.wp_gpio		= S5PV210_GPH3(1),
+};
+
+static struct s3c_sdhci_platdata smdkv210_hsmmc3_pdata __initdata = {
+	.wp_gpio		= S5PV210_GPH1(0),
+};
+
 static void __init smdkv210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -101,6 +119,10 @@ static void __init smdkv210_map_io(void)
 static void __init smdkv210_machine_init(void)
 {
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+	s3c_sdhci0_set_platdata(&smdkv210_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdkv210_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdkv210_hsmmc2_pdata);
+	s3c_sdhci3_set_platdata(&smdkv210_hsmmc3_pdata);
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
 }
 
-- 
1.6.2.5
