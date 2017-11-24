From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 00/22] mmc: tmio: various fixes and cleanups
Date: Sat, 25 Nov 2017 01:24:35 +0900
Message-ID: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


I am working on this IP for Socionext SoCs.

I was hit by several issues, and noticed various
clean-up candidates.

 - Fix and clean-up Kconfig
 - Fix various card detection problems
 - Move Renesas private data out of TMIO core
 - Allow to perform platform-specific settings before MMC host starts
 - Fix weird IRQ handling

I am getting more and more patches for TMIO.
I put all in a single series to clarify the patch order.

1, 2, 4, 5, 6, 7 were already acked or reviewed by Wolfram Sang.


Masahiro Yamada (22):
  mmc: renesas_sdhi: consolidate DMAC CONFIG options
  mmc: renesas_sdhi: remove wrong depends on to enable compile test
  mmc: renesas_sdhi: remove eprobe jump label
  mmc: tmio: set tmio_mmc_host to driver data
  mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
  mmc: tmio: move mmc_host_ops to struct tmio_mmc_host from static data
  mmc: tmio, renesas_sdhi: set mmc_host_ops hooks directly
  mmc: tmio: move mmc_gpio_request_cd() before mmc_add_host()
  mmc: tmio: use mmc_can_gpio_cd() instead of checking
    TMIO_MMC_USE_GPIO_CD
  mmc: tmio: support IP-builtin card detection logic
  mmc: renesas_sdhi: remove always false condition
  mmc: tmio,renesas_sdhi: move struct tmio_mmc_dma to renesas_sdhi.h
  mmc: tmio,renesas_sdhi: move Renesas-specific DMA data to
    renesas_sdhi.h
  mmc: tmio,renesas_sdhi: move ssc_tappos to renesas_sdhi.h
  mmc: tmio: change bus_shift to unsigned int
  mmc: tmio: fix never-detected card insertion bug
  mmc: tmio: move TMIO_MASK_{READOP,WRITEOP} handling to correct place
  mmc: tmio: remove useless TMIO_MASK_CMD handling in
    tmio_mmc_host_probe()
  mmc: tmio: ioremap memory resource in tmio_mmc_host_alloc()
  mmc: tmio: move clk_enable/disable out of tmio_mmc_host_probe()
  mmc: tmio: move {tmio_}mmc_of_parse() to tmio_mmc_host_alloc()
  mmc: tmio: remove dma_ops from tmio_mmc_host_probe() argument

 drivers/mmc/host/Kconfig                      |   5 +-
 drivers/mmc/host/Makefile                     |   8 +-
 drivers/mmc/host/renesas_sdhi.h               |  22 ++++
 drivers/mmc/host/renesas_sdhi_core.c          |  49 ++++-----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  14 ++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  35 +++---
 drivers/mmc/host/tmio_mmc.c                   |  23 ++--
 drivers/mmc/host/tmio_mmc.h                   |  23 +---
 drivers/mmc/host/tmio_mmc_core.c              | 149 +++++++++++++-------------
 9 files changed, 170 insertions(+), 158 deletions(-)

-- 
2.7.4
