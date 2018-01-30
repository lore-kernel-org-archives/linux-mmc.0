From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: MMC_SDHI_{SYS,INTERNAL}_DMAC should depend on HAS_DMA
Date: Tue, 30 Jan 2018 14:24:40 +0100
Message-ID: <1517318680-14918-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/mmc/host/renesas_sdhi_sys_dmac.ko] undefined!
    ERROR: "bad_dma_ops" [drivers/mmc/host/renesas_sdhi_internal_dmac.ko] undefined!

Add dependencies on HAS_DMA to fix this.

Fixes: e578afab6e5f57e7 ("mmc: renesas_sdhi: remove wrong depends on to enable compile test")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 67bd3344dd03a1ae..0eae619419d9ddeb 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -605,7 +605,7 @@ config MMC_SDHI
 
 config MMC_SDHI_SYS_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
-	depends on MMC_SDHI
+	depends on MMC_SDHI && HAS_DMA
 	default MMC_SDHI if (SUPERH || ARM)
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
@@ -615,7 +615,7 @@ config MMC_SDHI_SYS_DMAC
 config MMC_SDHI_INTERNAL_DMAC
 	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
 	depends on ARM64 || COMPILE_TEST
-	depends on MMC_SDHI
+	depends on MMC_SDHI && HAS_DMA
 	default MMC_SDHI if ARM64
 	help
 	  This provides DMA support for SDHI SD/SDIO controllers
-- 
2.7.4
