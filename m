From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC v2 0/5] mmc: renesas_sdhi: add R-Car Gen-3 DMA support
Date: Thu, 30 Jun 2016 00:05:35 +0200
Message-ID: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55002 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbcF2WGE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2016 18:06:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

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

Changes since v3:
* Cleanup and more renaming as suggested by Wolfram Sang
* max_segs restriction

Testing:

As described on http://elinux.org/Tests:r-car-gen3-sdhi-dma

Performance appears to be less than expected,
4.7Mb/s read for a card observed to read at 20Mb/s on r8a7790/Koelsch.

I will inviestigate this further.


Simon Horman (2):
  mmc: sh_mobile_sdhi, tmio: make dma more modular
  mmc: sh_mobile_sdhi: rename DMA source file as
    renesas_sdhi_sysc_dmac.c

Yoshihiro Shimoda (3):
  mmc: tmio: add max_segs and max_blk_count in tmio_mmc_data
  mmc: sh_mobile_sdhi: add some SoC specific data for R-Car Gen3
  mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC

 drivers/mmc/host/Kconfig                           |  18 ++
 drivers/mmc/host/Makefile                          |   7 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      | 192 +++++++++++++++++++++
 .../{tmio_mmc_dma.c => renesas_sdhi_sysc_dmac.c}   |  55 ++++--
 drivers/mmc/host/sh_mobile_sdhi.c                  |  49 ++++++
 drivers/mmc/host/tmio_mmc.h                        |  39 +----
 drivers/mmc/host/tmio_mmc_pio.c                    |  49 +++++-
 include/linux/mfd/tmio.h                           |   2 +
 8 files changed, 360 insertions(+), 51 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_sysc_dmac.c} (83%)

-- 
2.7.0.rc3.207.g0ac5344

