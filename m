From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/36] ARM: exynos: stop selecting PLAT_SAMSUNG
Date: Thu, 10 Oct 2019 22:29:52 +0200
Message-ID: <20191010203043.1241612-8-arnd@arndb.de>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010203043.1241612-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Now that no code in arch/arm is shared between mach-exynos and the
others, make the split formal.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug        | 8 ++++----
 arch/arm/Makefile             | 1 -
 arch/arm/mach-exynos/Makefile | 4 ----
 arch/arm/plat-samsung/Kconfig | 4 ++--
 drivers/mmc/host/Kconfig      | 2 +-
 5 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d05b836dfeb2..9c4f2d6deb06 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -998,7 +998,7 @@ choice
 		  via SCIFA4 on Renesas SH-Mobile AG5 (SH73A0).
 
 	config DEBUG_S3C_UART0
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1010,7 +1010,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART1
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1022,7 +1022,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART2
-		depends on PLAT_SAMSUNG
+		depends on PLAT_SAMSUNG || ARCH_EXYNOS
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C24XX_UART if ARCH_S3C24XX
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
@@ -1034,7 +1034,7 @@ choice
 		  by the boot-loader before use.
 
 	config DEBUG_S3C_UART3
-		depends on PLAT_SAMSUNG && (ARCH_EXYNOS || ARCH_S5PV210)
+		depends on ARCH_EXYNOS || ARCH_S5PV210
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
 		select DEBUG_S3C64XX_UART if ARCH_S3C64XX
 		select DEBUG_S5PV210_UART if ARCH_S5PV210
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index db857d07114f..f492d7c338fe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -233,7 +233,6 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-plat-$(CONFIG_ARCH_EXYNOS)	+= samsung
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_ARCH_S5PV210)	+= samsung
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 0fd3fcf8bfb0..53fa363c8e44 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -3,10 +3,6 @@
 # Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
-
-# Core
-
 obj-$(CONFIG_ARCH_EXYNOS)	+= exynos.o exynos-smc.o firmware.o
 
 obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 832ab0e6cd72..e31a156a27df 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -4,7 +4,7 @@
 
 config PLAT_SAMSUNG
 	bool
-	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_EXYNOS || ARCH_S5PV210
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default y
 	select GENERIC_IRQ_CHIP
 	select NO_IOPORT_MAP
@@ -240,7 +240,7 @@ config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
 	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
-	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
+	depends on DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
 	  Resume code. See <file:Documentation/arm/samsung-s3c24xx/suspend.rst>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 49ea02c467bf..400a581c918c 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -275,7 +275,7 @@ config MMC_SDHCI_TEGRA
 
 config MMC_SDHCI_S3C
 	tristate "SDHCI support on Samsung S3C SoC"
-	depends on MMC_SDHCI && PLAT_SAMSUNG
+	depends on MMC_SDHCI && (PLAT_SAMSUNG || ARCH_EXYNOS)
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-- 
2.20.0
