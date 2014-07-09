From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/3] mmc: MMC_USDHI6ROL0 should depend on HAS_DMA
Date: Wed,  9 Jul 2014 20:52:42 +0200
Message-ID: <1404931962-25917-3-git-send-email-geert@linux-m68k.org>
References: <1404931962-25917-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404931962-25917-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-mmc@vger.kernel.org

If NO_DMA=y:

    drivers/built-in.o: In function `usdhi6_dma_setup':
    usdhi6rol0.c:(.text+0x5c35fc): undefined reference to `dma_map_sg'
    drivers/built-in.o: In function `usdhi6_dma_stop_unmap':
    usdhi6rol0.c:(.text+0x5c3738): undefined reference to `dma_unmap_sg'

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - New
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 9ac9d8387df0..5ccde78e0110 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -698,6 +698,7 @@ config MMC_WMT
 
 config MMC_USDHI6ROL0
 	tristate "Renesas USDHI6ROL0 SD/SDIO Host Controller support"
+	depends on HAS_DMA
 	help
 	  This selects support for the Renesas USDHI6ROL0 SD/SDIO
 	  Host Controller
-- 
1.9.1
