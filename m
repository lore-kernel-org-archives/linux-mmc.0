From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 00/22] omap_hsmmc patches
Date: Thu,  5 May 2011 14:51:00 +0300
Message-ID: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>
List-Id: linux-mmc@vger.kernel.org

Hi

Here are some patches for omap_hsmmc.

Adrian Hunter (10):
      OMAP: DMA: add omap_dma_has_sglist()
      OMAP: DMA: Ensure the sglist registers are cleared
      mmc: omap_hsmmc: fix dma sglist use
      mmc: omap_hsmmc: limit scatterlist size for sDMA autoloading
      mmc: omap_hsmmc: correct debug report error status mnemonics
      OMAP: board-rm680: set MMC nomux flag
      mmc: omap_hsmmc: ensure pbias configuration is always done
      mmc: omap_hsmmc: fix oops in omap_hsmmc_dma_cb
      OMAP: hsmmc: add platform data for eMMC hardware reset gpio
      mmc: omap_hsmmc: add a hardware reset before initialization

Andy Shevchenko (8):
      mmc: omap_hsmmc: move hardcoded frequency constants to definition block
      mmc: omap_hsmmc: reduce a bit the error handlers in probe()
      mmc: omap_hsmmc: split duplicate code to calc_divisor() function
      mmc: omap_hsmmc: introduce start_clock and re-use stop_clock
      mmc: omap_hsmmc: fix few bugs when set the clock divisor
      mmc: omap_hsmmc: split same pieces of code to separate functions
      OMAP: hsmmc: implement clock switcher
      mmc: omap_hsmmc: adjust host controller clock in regard to current OPP

Jarkko Lavinen (1):
      OMAP: hsmmc: Do not mux the slot if non default muxing is already done

Sudhir Bera (1):
      mmc: omap_hsmmc: fix missing mmc_release_host() in no_off case

Venkatraman S (2):
      OMAP: sDMA: descriptor autoloading feature
      mmc: omap hsmmc: adaptation of sdma descriptor

 arch/arm/mach-omap2/board-rm680.c     |    1 +
 arch/arm/mach-omap2/hsmmc.c           |  188 ++++++++++++-
 arch/arm/mach-omap2/hsmmc.h           |    2 +
 arch/arm/plat-omap/dma.c              |  285 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/dma.h |  176 +++++++++++
 arch/arm/plat-omap/include/plat/mmc.h |    9 +
 drivers/mmc/host/omap_hsmmc.c         |  514 ++++++++++++++++++++++----------
 7 files changed, 1012 insertions(+), 163 deletions(-)
 
Regards
Adrian

