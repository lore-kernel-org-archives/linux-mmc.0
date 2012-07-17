From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH v2 1/1] mmc: host: enable OMAP DMA engine support for omap hosts by default
Date: Tue, 17 Jul 2012 09:03:56 +0200
Message-ID: <1342508636-2782-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-mmc@vger.kernel.org

The OMAP MMC and OMAP High Speed MMC hosts now use entirely the DMA
engine API instead of the previous private DMA API implementation.

So, if the kernel is built with support for any of these hosts but it
doesn't support DMA devices nor OMAP DMA support, it fails when trying
to obtain a DMA channel which leads to the following error on an OMAP3
IGEPv2 Rev.C board (and probably on most OMAP boards with MMC support):

[    2.199981] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
[    2.215087] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62

selecting automatically CONFIG_DMADEVICES and CONFIG_DMA_OMAP solves it.

While being there, also update drivers/spi/spi-omap2-mcspi which has been
ported to DMA engine API too.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---

Changes since v1:

- Also include drivers/spi/spi-omap2-mcspi.c as suggested by Santosh Shilimkar.

 drivers/mmc/host/Kconfig |    4 ++++
 drivers/spi/Kconfig      |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index aa131b3..fcddbaf 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -233,6 +233,8 @@ config MMC_OMAP
 	tristate "TI OMAP Multimedia Card Interface support"
 	depends on ARCH_OMAP
 	select TPS65010 if MACH_OMAP_H2
+	select DMADEVICES
+	select DMA_OMAP
 	help
 	  This selects the TI OMAP Multimedia card Interface.
 	  If you have an OMAP board with a Multimedia Card slot,
@@ -243,6 +245,8 @@ config MMC_OMAP
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
 	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
+	select DMADEVICES
+	select DMA_OMAP
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
 	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cd2fe35..3b7ced3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -238,6 +238,8 @@ config SPI_OMAP_UWIRE
 config SPI_OMAP24XX
 	tristate "McSPI driver for OMAP"
 	depends on ARCH_OMAP2PLUS
+	select DMADEVICES
+	select DMA_OMAP
 	help
 	  SPI master controller for OMAP24XX and later Multichannel SPI
 	  (McSPI) modules.
-- 
1.7.7.6

