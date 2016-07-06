From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v3 0/6] mmc: renesas_sdhi: add R-Car Gen-3 DMA support
Date: Wed,  6 Jul 2016 22:23:24 +0200
Message-ID: <1467836610-18539-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

this short series adds support for R-Car Gen-3 Internal DMAC to the SDHI
driver.

The approach taken is as follows:

1. Refactor the TMIO DMA code so that it is provided by a set of callbacks
   rather than compiled-in function calls; Refactor the DMA SDHI to use
   this.
2. Rename tmio_mmc_dma.c as renesas_sdhi_sysc_dmac.c which better reflects
   what it is is, particularly after step 2.
3. Add max_segs restriction
4. Add Gen3 DMA code as a separate set of callbacks

Changes since v2:
* Correct discrepancies with BSP v3.2.2 in intermal DMAC implementation.
* Correctly set mmc->max_blk_count in accordance with max_segs.
  This appears to boost performance from ~4.7Mb/s to ~11Mb/s.
* Allow fallback to PIO
* Correct name of SYS DMAC

Changes since v1:
* Cleanup and more renaming as suggested by Wolfram Sang
* max_segs restriction

Testing:

As described on http://elinux.org/Tests:r-car-gen3-sdhi-dma

Previously performance of 4.7Mb/s was reported.
With this series performance of 11Mb/s has been achieved.
However, this is still lower than the 20Mb/s I originally expected.

Simon Horman (3):
  mmc: sh_mobile_sdhi, tmio: make dma more modular
  mmc: sh_mobile_sdhi: rename DMA source file as renesas_sdhi_sys_dmac.c
  arm64: defconfig: Enable SDHI SD/SDIO controller

Yoshihiro Shimoda (3):
  mmc: tmio: add max_segs and max_blk_count in tmio_mmc_data
  mmc: sh_mobile_sdhi: add some SoC specific data for R-Car Gen3
  mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC

 arch/arm64/configs/defconfig                       |   1 +
 drivers/mmc/host/Kconfig                           |  18 ++
 drivers/mmc/host/Makefile                          |   7 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      | 196 +++++++++++++++++++++
 .../{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c}    |  53 ++++--
 drivers/mmc/host/sh_mobile_sdhi.c                  |  41 +++++
 drivers/mmc/host/tmio_mmc.h                        |  39 +---
 drivers/mmc/host/tmio_mmc_pio.c                    |  53 +++++-
 include/linux/mfd/tmio.h                           |   2 +
 9 files changed, 357 insertions(+), 53 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c} (83%)

-- 
2.7.0.rc3.207.g0ac5344
