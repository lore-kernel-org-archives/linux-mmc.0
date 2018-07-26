From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/2] mmc: tmio: rename variants to have consistent prefix
Date: Thu, 26 Jul 2018 12:28:54 +0900
Message-ID: <1532575736-20138-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-mmc@vger.kernel.org


Based on the former discussion:
https://www.spinics.net/lists/linux-mmc/msg46952.html



Masahiro Yamada (2):
  mmc: tmio: rename files and CONFIG options to have the same prefix
  dt-binding: mmc: rename tmio_mmc.txt to renesas_sdhi.txt

 .../mmc/{tmio_mmc.txt => renesas_sdhi.txt}         |   11 +-
 MAINTAINERS                                        |    1 -
 arch/arm/configs/eseries_pxa_defconfig             |    2 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 drivers/mmc/host/Kconfig                           |   25 +-
 drivers/mmc/host/Makefile                          |    8 +-
 drivers/mmc/host/tmio_mmc.c                        | 1415 ++++++++++++++++++--
 drivers/mmc/host/tmio_mmc_core.c                   | 1394 -------------------
 drivers/mmc/host/tmio_mmc_original.c               |  167 +++
 .../host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c}  |    2 +-
 .../mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h}   |    0
 ...ternal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} |    2 +-
 ...as_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} |    2 +-
 13 files changed, 1519 insertions(+), 1512 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{tmio_mmc.txt => renesas_sdhi.txt} (86%)
 delete mode 100644 drivers/mmc/host/tmio_mmc_core.c
 create mode 100644 drivers/mmc/host/tmio_mmc_original.c
 rename drivers/mmc/host/{renesas_sdhi_core.c => tmio_mmc_sdhi.c} (99%)
 rename drivers/mmc/host/{renesas_sdhi.h => tmio_mmc_sdhi.h} (100%)
 rename drivers/mmc/host/{renesas_sdhi_internal_dmac.c => tmio_mmc_sdhi_internal_dmac.c} (99%)
 rename drivers/mmc/host/{renesas_sdhi_sys_dmac.c => tmio_mmc_sdhi_sys_dmac.c} (99%)

-- 
2.7.4
