From: "Christian Daudt" <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] rename ARCH_BCM to ARCH_BCM_MOBILE
Date: Fri, 20 Sep 2013 16:04:20 -0700
Message-ID: <1379718260-24349-1-git-send-email-csd@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Domenico Andreoli <cavokz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Elder <alex.elder-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Currently ARCH_BCM has been used for Broadcom
Mobile V7 based SoCs. In order to allow other Broadcom
SoCs to also use mach-bcm directory and files, this patch
renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
uses ARCH_BCM to define any Broadcom chip residing
in mach-bcm directory.

Signed-off-by: Christian Daudt <csd-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc0f1fb..dd00e22 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -42,8 +42,6 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
 dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
 
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
-dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb \
-	bcm28155-ap.dtb
 dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
 	da850-evm.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
@@ -101,6 +99,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-openblocks_a6.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
+dtb-$(CONFIG_ARCH_BCM_MOBILE) += bcm11351-brt.dtb \
+	bcm28155-ap.dtb
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 6e49310..efb0132 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -27,6 +27,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_EFI_PARTITION=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_743622=y
 CONFIG_PREEMPT=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e572c6..89a5064 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM_MOBILE=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_KEYSTONE=y
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 69d67f7..af86cda 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -1,5 +1,17 @@
 config ARCH_BCM
-	bool "Broadcom SoC" if ARCH_MULTI_V7
+	bool "Broadcom SoC Support"
+	select ARCH_MULTIPLATFORM
+	help
+	  This enables support for Broadcom ARM based SoC
+          chips
+
+if ARCH_BCM
+
+menu "Broadcom SoC Selection"
+
+config ARCH_BCM_MOBILE
+	bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
+	default y
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
@@ -14,7 +26,11 @@ config ARCH_BCM
 	select TICK_ONESHOT
 	select CACHE_L2X0
 	help
-	  This enables support for system based on Broadcom SoCs.
+	  This enables support for systems based on Broadcom mobile SoCs.
 	  It currently supports the 'BCM281XX' family, which includes
 	  BCM11130, BCM11140, BCM11351, BCM28145 and
 	  BCM28155 variants.
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index e3d0303..c2ccd5a 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -10,6 +10,6 @@
 # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-obj-$(CONFIG_ARCH_BCM)		:= board_bcm281xx.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
+obj-$(CONFIG_ARCH_BCM_MOBILE)	:= board_bcm281xx.o bcm_kona_smc.o bcm_kona_smc_asm.o kona.o
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 704d6d3..4207ab4 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= zevio-timer.o
-obj-$(CONFIG_ARCH_BCM)		+= bcm_kona_timer.o
+obj-$(CONFIG_ARCH_BCM_MOBILE)	+= bcm_kona_timer.o
 obj-$(CONFIG_CADENCE_TTC_TIMER)	+= cadence_ttc_timer.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 obj-$(CONFIG_CLKSRC_SAMSUNG_PWM)	+= samsung_pwm_timer.o
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..7e89650 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -251,7 +251,7 @@ config MMC_SDHCI_S3C_DMA
 
 config MMC_SDHCI_BCM_KONA
 	tristate "SDHCI support on Broadcom KONA platform"
-	depends on ARCH_BCM
+	depends on ARCH_BCM_MOBILE
 	select MMC_SDHCI_PLTFM
 	help
 	  This selects the Broadcom Kona Secure Digital Host Controller
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
