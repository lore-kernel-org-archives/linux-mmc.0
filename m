From: Jeongbae Seo <jeongbae.seo@samsung.com>
Subject: [PATCH 2/5] ARM: S5PV310: Add HSMMC support into S5PV310 and S5PC210
Date: Thu, 16 Sep 2010 17:37:00 +0900
Message-ID: <1284626223-18944-3-git-send-email-jeongbae.seo@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, Jeongbae Seo <jeongbae.seo@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Hyuk Lee <hyuk1.lee@samsung.com>

This patch adds to use of HSMMC on S5PV310 and S5PC210.
The HSMMC platform data like card detect, data bus width
and capability is configured.

Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
---
 arch/arm/mach-s5pv310/cpu.c                |    7 +++
 arch/arm/mach-s5pv310/mach-smdkc210.c      |   50 ++++++++++++++++++++++++
 arch/arm/mach-s5pv310/mach-smdkv310.c      |   50 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   57 ++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv310/cpu.c b/arch/arm/mach-s5pv310/cpu.c
index 4add398..66beac4 100644
--- a/arch/arm/mach-s5pv310/cpu.c
+++ b/arch/arm/mach-s5pv310/cpu.c
@@ -19,6 +19,7 @@
 #include <plat/cpu.h>
 #include <plat/clock.h>
 #include <plat/s5pv310.h>
+#include <plat/sdhci.h>
 
 #include <mach/regs-irq.h>
 
@@ -83,6 +84,12 @@ static void s5pv310_idle(void)
 void __init s5pv310_map_io(void)
 {
 	iotable_init(s5pv310_iodesc, ARRAY_SIZE(s5pv310_iodesc));
+
+	/* initialize device information early */
+	s5pv310_default_sdhci0();
+	s5pv310_default_sdhci1();
+	s5pv310_default_sdhci2();
+	s5pv310_default_sdhci3();
 }
 
 void __init s5pv310_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
index 71a3bec..e6d789f 100644
--- a/arch/arm/mach-s5pv310/mach-smdkc210.c
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -9,6 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -17,6 +20,8 @@
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/sdhci.h>
 
 #include <mach/map.h>
 
@@ -65,6 +70,45 @@ static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
 	},
 };
 
+static struct s3c_sdhci_platdata smdkc210_hsmmc0_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkc210_hsmmc1_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct s3c_sdhci_platdata smdkc210_hsmmc2_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkc210_hsmmc3_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct platform_device *smdkc210_devices[] __initdata = {
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+	&s3c_device_hsmmc3,
+};
+
 static void __init smdkc210_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -74,9 +118,15 @@ static void __init smdkc210_map_io(void)
 
 static void __init smdkc210_machine_init(void)
 {
+	s3c_sdhci0_set_platdata(&smdkc210_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdkc210_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdkc210_hsmmc2_pdata);
+	s3c_sdhci3_set_platdata(&smdkc210_hsmmc3_pdata);
+
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
+	platform_add_devices(smdkc210_devices, ARRAY_SIZE(smdkc210_devices));
 }
 
 MACHINE_START(SMDKC210, "SMDKC210")
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
index 0d6ab77..c52b0c7 100644
--- a/arch/arm/mach-s5pv310/mach-smdkv310.c
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -9,6 +9,9 @@
 */
 
 #include <linux/serial_core.h>
+#include <linux/gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -17,6 +20,8 @@
 #include <plat/regs-serial.h>
 #include <plat/s5pv310.h>
 #include <plat/cpu.h>
+#include <plat/devs.h>
+#include <plat/sdhci.h>
 
 #include <mach/map.h>
 
@@ -65,6 +70,45 @@ static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
 	},
 };
 
+static struct s3c_sdhci_platdata smdkv310_hsmmc0_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH0_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc1_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK0(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc2_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+#ifdef CONFIG_S5PV310_SDHCI_CH2_8BIT
+	.max_width		= 8,
+	.host_caps		= MMC_CAP_8_BIT_DATA,
+#endif
+};
+
+static struct s3c_sdhci_platdata smdkv310_hsmmc3_pdata __initdata = {
+	.cd_type		= S3C_SDHCI_CD_GPIO,
+	.ext_cd_gpio		= S5PV310_GPK2(2),
+	.ext_cd_gpio_invert	= 1,
+};
+
+static struct platform_device *smdkv310_devices[] __initdata = {
+	&s3c_device_hsmmc0,
+	&s3c_device_hsmmc1,
+	&s3c_device_hsmmc2,
+	&s3c_device_hsmmc3,
+};
+
 static void __init smdkv310_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -74,9 +118,15 @@ static void __init smdkv310_map_io(void)
 
 static void __init smdkv310_machine_init(void)
 {
+	s3c_sdhci0_set_platdata(&smdkv310_hsmmc0_pdata);
+	s3c_sdhci1_set_platdata(&smdkv310_hsmmc1_pdata);
+	s3c_sdhci2_set_platdata(&smdkv310_hsmmc2_pdata);
+	s3c_sdhci3_set_platdata(&smdkv310_hsmmc3_pdata);
+
 #ifdef CONFIG_CACHE_L2X0
 	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
 #endif
+	platform_add_devices(smdkv310_devices, ARRAY_SIZE(smdkv310_devices));
 }
 
 MACHINE_START(SMDKV310, "SMDKV310")
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index 30844c2..d92670a 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -110,6 +110,10 @@ extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 extern void s5pv210_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
+extern void s5pv310_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
+extern void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
+extern void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
+extern void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *, int w);
 
 /* S3C64XX SDHCI setup */
 
@@ -288,4 +292,57 @@ static inline void s5pv210_default_sdhci3(void) { }
 
 #endif /* CONFIG_S5PV210_SETUP_SDHCI */
 
+/* S5PV310 SDHCI setup */
+#ifdef CONFIG_S5PV310_SETUP_SDHCI
+extern char *s5pv310_hsmmc_clksrcs[4];
+
+extern void s5pv310_setup_sdhci_cfg_card(struct platform_device *dev,
+					   void __iomem *r,
+					   struct mmc_ios *ios,
+					   struct mmc_card *card);
+
+static inline void s5pv310_default_sdhci0(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC
+	s3c_hsmmc0_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
+	s3c_hsmmc0_def_platdata.cfg_gpio = s5pv310_setup_sdhci0_cfg_gpio;
+	s3c_hsmmc0_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+#endif
+}
+
+static inline void s5pv310_default_sdhci1(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC1
+	s3c_hsmmc1_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
+	s3c_hsmmc1_def_platdata.cfg_gpio = s5pv310_setup_sdhci1_cfg_gpio;
+	s3c_hsmmc1_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+#endif
+}
+
+static inline void s5pv310_default_sdhci2(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC2
+	s3c_hsmmc2_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
+	s3c_hsmmc2_def_platdata.cfg_gpio = s5pv310_setup_sdhci2_cfg_gpio;
+	s3c_hsmmc2_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+#endif
+}
+
+static inline void s5pv310_default_sdhci3(void)
+{
+#ifdef CONFIG_S3C_DEV_HSMMC3
+	s3c_hsmmc3_def_platdata.clocks = s5pv310_hsmmc_clksrcs;
+	s3c_hsmmc3_def_platdata.cfg_gpio = s5pv310_setup_sdhci3_cfg_gpio;
+	s3c_hsmmc3_def_platdata.cfg_card = s5pv310_setup_sdhci_cfg_card;
+#endif
+}
+
+#else
+static inline void s5pv310_default_sdhci0(void) { }
+static inline void s5pv310_default_sdhci1(void) { }
+static inline void s5pv310_default_sdhci2(void) { }
+static inline void s5pv310_default_sdhci3(void) { }
+
+#endif /* CONFIG_S5PV310_SETUP_SDHCI */
+
 #endif /* __PLAT_S3C_SDHCI_H */
-- 
1.6.2.5
