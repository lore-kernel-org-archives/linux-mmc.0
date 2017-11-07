From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] mmc: renesas_sdhi: consilidate DMAC CONFIG options
Date: Tue,  7 Nov 2017 16:57:21 +0900
Message-ID: <1510041442-15176-2-git-send-email-yamada.masahiro@socionext.com>
References: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510041442-15176-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The description in the Makefile is odd.  Fix the CONFIG selection
in a cleaner way.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/Kconfig  | 4 ++--
 drivers/mmc/host/Makefile | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d371e37..5420da5 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -584,8 +584,6 @@ config MMC_SDHI
 	depends on SUPERH || ARM || ARM64
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 	select MMC_TMIO_CORE
-	select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
-	select MMC_SDHI_INTERNAL_DMAC if ARM64
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
@@ -593,6 +591,7 @@ config MMC_SDHI
 config MMC_SDHI_SYS_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
 	depends on MMC_SDHI
+	default MMC_SDHI if (SUPERH || ARM)
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using SYS-DMAC via DMA Engine. This supports the controllers
@@ -602,6 +601,7 @@ config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
 	depends on ARM64 || COMPILE_TEST
 	depends on MMC_SDHI
+	default MMC_SDHI if ARM64
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
 	  using on-chip bus mastering. This supports the controllers
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 5a548cb..e165d2e 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -39,12 +39,8 @@ obj-$(CONFIG_MMC_SDRICOH_CS)	+= sdricoh_cs.o
 obj-$(CONFIG_MMC_TMIO)		+= tmio_mmc.o
 obj-$(CONFIG_MMC_TMIO_CORE)	+= tmio_mmc_core.o
 obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_core.o
-ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYS_DMAC)),y)
-obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_sys_dmac.o
-endif
-ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_INTERNAL_DMAC)),y)
-obj-$(CONFIG_MMC_SDHI)		+= renesas_sdhi_internal_dmac.o
-endif
+obj-$(CONFIG_MMC_SDHI_SYS_DMAC)		+= renesas_sdhi_sys_dmac.o
+obj-$(CONFIG_MMC_SDHI_INTERNAL_DMAC)	+= renesas_sdhi_internal_dmac.o
 obj-$(CONFIG_MMC_CB710)		+= cb710-mmc.o
 obj-$(CONFIG_MMC_VIA_SDMMC)	+= via-sdmmc.o
 obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
-- 
2.7.4
