From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 0/4] mmc: renesas_sdhi: add R-Car Gen-3 DMA support
Date: Wed, 15 Jun 2016 13:01:53 +0900
Message-ID: <1465963317-28672-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this short series adds support for  R-Car Gen-3 DMA to the SDHI driver.

The approach taken is as follows:

1. Rename sh_mobile_sdhi.c as renesas_sdhi.c
2. Refactor the TMIO DMA code so that it is provided by a set of callbacks
   rather than compiled-in function calls; Refactor the DMA SDHI to use this.
3. Rename tmio_mmc_dma.c as renesas_sdhi_dma.c which reflects more closely
   what it is is, particularly after step 2.
4. Add Gen3 DMA code as a separate set of callbacks

Please note that currently the DMA callbacks used are determined based
on the SDHI compat string in effect.

Based on mmc/next

Provided as:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdhi-gen3-dma

Simon Horman (3):
  mmc: renesas_sdhi: rename sh_mobile_sdhi as renesas_sdhi
  mmc: renesas_sdhi, tmio: make dma more modular
  mmc: renesas_sdhi: rename DMA source file as renesas_sdhi_dma.c

Yoshihiro Shimoda (1):
  mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC

 drivers/mmc/host/Kconfig                           |  22 ++-
 drivers/mmc/host/Makefile                          |   5 +-
 .../mmc/host/{sh_mobile_sdhi.c => renesas_sdhi.c}  |  43 +++++
 .../host/{tmio_mmc_dma.c => renesas_sdhi_dma.c}    |  26 ++-
 drivers/mmc/host/renesas_sdhi_dma_gen3.c           | 190 +++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h                        |  39 +----
 drivers/mmc/host/tmio_mmc_pio.c                    |  47 +++++
 7 files changed, 333 insertions(+), 39 deletions(-)
 rename drivers/mmc/host/{sh_mobile_sdhi.c => renesas_sdhi.c} (93%)
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_dma.c} (92%)
 create mode 100644 drivers/mmc/host/renesas_sdhi_dma_gen3.c

-- 
2.1.4
