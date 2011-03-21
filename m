From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 5/5] mmc: sdhci: update Makefile/Kconfig for sdhci_pltfm change
Date: Mon, 21 Mar 2011 16:07:03 +0800
Message-ID: <1300694823-8300-6-git-send-email-shawn.guo@linaro.org>
References: <1300694823-8300-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1300694823-8300-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_pltfm.c becomes a file only having common support functions
than a driver with its registeration before.  The patch is to update
Makefile and Kconfig to let MMC_SDHCI_PLTFM be selected by specific
SDHCI device drivers.

Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/Kconfig  |   24 +++++++++++++-----------
 drivers/mmc/host/Makefile |   11 +++++------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index afe8c6f..1db9347 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -113,20 +113,17 @@ config MMC_SDHCI_OF_HLWD
 	  If unsure, say N.
 
 config MMC_SDHCI_PLTFM
-	tristate "SDHCI support on the platform specific bus"
+	bool
 	depends on MMC_SDHCI
 	help
-	  This selects the platform specific bus support for Secure Digital Host
-	  Controller Interface.
-
-	  If you have a controller with this interface, say Y or M here.
-
-	  If unsure, say N.
+	  This selects the platform common function support for Secure Digital
+	  Host Controller Interface.
 
 config MMC_SDHCI_CNS3XXX
 	bool "SDHCI support on the Cavium Networks CNS3xxx SoC"
 	depends on ARCH_CNS3XXX
-	depends on MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	help
 	  This selects the SDHCI support for CNS3xxx System-on-Chip devices.
 
@@ -134,7 +131,9 @@ config MMC_SDHCI_CNS3XXX
 
 config MMC_SDHCI_ESDHC_IMX
 	bool "SDHCI platform support for the Freescale eSDHC i.MX controller"
-	depends on MMC_SDHCI_PLTFM && (ARCH_MX25 || ARCH_MX35 || ARCH_MX5)
+	depends on ARCH_MX25 || ARCH_MX35 || ARCH_MX5
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Freescale eSDHC controller support on the platform
@@ -145,7 +144,8 @@ config MMC_SDHCI_ESDHC_IMX
 config MMC_SDHCI_DOVE
 	bool "SDHCI support on Marvell's Dove SoC"
 	depends on ARCH_DOVE
-	depends on MMC_SDHCI_PLTFM
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface in
@@ -155,7 +155,9 @@ config MMC_SDHCI_DOVE
 
 config MMC_SDHCI_TEGRA
 	tristate "SDHCI platform support for the Tegra SD/MMC Controller"
-	depends on MMC_SDHCI_PLTFM && ARCH_TEGRA
+	depends on ARCH_TEGRA
+	depends on MMC_SDHCI
+	select MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Tegra SD/MMC controller. If you have a Tegra
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index e834fb2..1d8e43d 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -36,12 +36,11 @@ obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_USHC)		+= ushc.o
 
-obj-$(CONFIG_MMC_SDHCI_PLTFM)			+= sdhci-platform.o
-sdhci-platform-y				:= sdhci-pltfm.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_CNS3XXX)	+= sdhci-cns3xxx.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
-sdhci-platform-$(CONFIG_MMC_SDHCI_TEGRA)	+= sdhci-tegra.o
+obj-$(CONFIG_MMC_SDHCI_PLTFM)		+= sdhci-pltfm.o
+obj-$(CONFIG_MMC_SDHCI_CNS3XXX)		+= sdhci-cns3xxx.o
+obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
+obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
+obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 
 obj-$(CONFIG_MMC_SDHCI_OF)	+= sdhci-of.o
 sdhci-of-y				:= sdhci-of-core.o
-- 
1.7.1
