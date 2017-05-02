From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 0/5] mmc: renesas-sdhi: refactor DMA support
Date: Tue,  2 May 2017 13:15:38 +0200
Message-ID: <1493723743-22821-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54536 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdEBLQC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2017 07:16:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>

Hi Wolfram, Hi Arnd, Hi all,

the intention of this patch-set is to refactor the DMA support in
the Renesas SDHI driver in order to make it easier to add support
for using the SDHI hardware with different DMA implementations.

This is based on earlier work, posted as "[PATCH/RFC v3 0/6] mmc:
renesas_sdhi: add R-Car Gen-3 DMA support". It attempts to implement
the reworking of the driver proposed by Arnd[1] in his review of that
patch-set.

[1] http://www.spinics.net/lists/linux-mmc/msg38004.html

Unlike that patch-set this patch-set does not add support for
R-Car Gen-3 DMA. Rather it focuses on refactoring the code.


Simon Horman (5):
  mmc: renesas-sdhi, tmio: make dma more modular
  mmc: tmio: rename tmio_mmc_{pio => core}.c
  mmc: renesas-sdhi: rename tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
  mmc: renesas-sdhi: rename sh_mobile_sdhi.c => renesas_sdhi_core.c
  mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file

 drivers/mmc/host/Kconfig                           |   4 +-
 drivers/mmc/host/Makefile                          |   4 +-
 drivers/mmc/host/renesas_sdhi.h                    |  39 ++++
 .../host/{sh_mobile_sdhi.c => renesas_sdhi_core.c} | 229 +++++----------------
 .../{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c}    | 162 +++++++++++++--
 drivers/mmc/host/tmio_mmc.c                        |   2 +-
 drivers/mmc/host/tmio_mmc.h                        |  46 ++---
 .../mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c}   |  45 +++-
 8 files changed, 296 insertions(+), 235 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 rename drivers/mmc/host/{sh_mobile_sdhi.c => renesas_sdhi_core.c} (68%)
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c} (58%)
 rename drivers/mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c} (97%)

-- 
2.1.4

