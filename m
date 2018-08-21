From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 00/11] tree-wide: use SPDX identifier for Renesas drivers
Date: Wed, 22 Aug 2018 00:02:13 +0200
Message-ID: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, dmaengine@vger.kernel.org, linux-can@vger.kernel.org, linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Here is my first batch of SPDX conversion patches. Mostly low hanging fruits,
only a handful of drivers needed corrections in MODULE_LICENSE, too.

checkpatch is happy as well.

I think an ack from Morimoto-san with his Renesas email address would be nice
to make it more official? Still, I *am* contracted by Renesas.

Thanks,

   Wolfram

Wolfram Sang (11):
  clk: renesas: use SPDX identifier for Renesas drivers
  dmaengine: use SPDX identifier for Renesas drivers
  i2c: use SPDX identifier for Renesas drivers
  mmc: use SPDX identifier for Renesas drivers
  can: rcar: use SPDX identifier for Renesas drivers
  net: ethernet: renesas: use SPDX identifier for Renesas drivers
  phy: renesas: use SPDX identifier for Renesas drivers
  pwm: use SPDX identifier for Renesas drivers
  soc: renesas: use SPDX identifier for Renesas drivers
  spi: use SPDX identifier for Renesas drivers
  watchdog: use SPDX identifier for Renesas drivers

 drivers/clk/renesas/clk-div6.c                |  5 +----
 drivers/clk/renesas/r8a7795-cpg-mssr.c        |  5 +----
 drivers/clk/renesas/r8a7796-cpg-mssr.c        |  5 +----
 drivers/clk/renesas/r8a77995-cpg-mssr.c       |  5 +----
 drivers/clk/renesas/rcar-gen3-cpg.c           |  5 +----
 drivers/clk/renesas/rcar-usb2-clock-sel.c     |  5 +----
 drivers/clk/renesas/renesas-cpg-mssr.c        |  5 +----
 drivers/clk/renesas/renesas-cpg-mssr.h        |  5 +----
 drivers/dma/nbpfaxi.c                         |  5 +----
 drivers/dma/sh/shdma-arm.h                    |  5 +----
 drivers/dma/sh/shdma-base.c                   |  5 +----
 drivers/dma/sh/shdma-of.c                     |  5 +----
 drivers/dma/sh/shdma-r8a73a4.c                |  5 +----
 drivers/dma/sh/shdma.h                        |  6 +-----
 drivers/dma/sh/shdmac.c                       |  6 +-----
 drivers/dma/sh/sudmac.c                       |  5 +----
 drivers/dma/sh/usb-dmac.c                     |  5 +----
 drivers/i2c/busses/i2c-emev2.c                |  5 +----
 drivers/i2c/busses/i2c-highlander.c           |  5 +----
 drivers/i2c/busses/i2c-rcar.c                 | 10 +---------
 drivers/i2c/busses/i2c-riic.c                 |  5 +----
 drivers/i2c/busses/i2c-sh_mobile.c            | 10 +---------
 drivers/mmc/host/renesas_sdhi.h               |  5 +----
 drivers/mmc/host/renesas_sdhi_core.c          |  5 +----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  5 +----
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  5 +----
 drivers/mmc/host/sh_mmcif.c                   |  7 ++-----
 drivers/mmc/host/tmio_mmc.c                   |  5 +----
 drivers/mmc/host/tmio_mmc.h                   |  6 +-----
 drivers/mmc/host/tmio_mmc_core.c              |  5 +----
 drivers/mmc/host/usdhi6rol0.c                 |  5 +----
 drivers/net/can/rcar/rcar_can.c               |  6 +-----
 drivers/net/can/rcar/rcar_canfd.c             |  6 +-----
 drivers/net/ethernet/renesas/ravb.h           |  5 +----
 drivers/net/ethernet/renesas/ravb_main.c      |  5 +----
 drivers/net/ethernet/renesas/sh_eth.c         | 13 +------------
 drivers/net/ethernet/renesas/sh_eth.h         | 13 +------------
 drivers/phy/renesas/phy-rcar-gen2.c           |  5 +----
 drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  5 +----
 drivers/phy/renesas/phy-rcar-gen3-usb3.c      |  5 +----
 drivers/pwm/pwm-rcar.c                        |  5 +----
 drivers/pwm/pwm-renesas-tpu.c                 | 10 +---------
 drivers/soc/renesas/r8a7743-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7745-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7779-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7790-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7791-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7792-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7794-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7795-sysc.c            |  5 +----
 drivers/soc/renesas/r8a7796-sysc.c            |  5 +----
 drivers/soc/renesas/r8a77970-sysc.c           |  5 +----
 drivers/soc/renesas/r8a77995-sysc.c           |  5 +----
 drivers/soc/renesas/rcar-sysc.h               |  5 +----
 drivers/soc/renesas/renesas-soc.c             | 10 +---------
 drivers/spi/spi-rspi.c                        | 10 +---------
 drivers/spi/spi-sh-hspi.c                     | 12 ++----------
 drivers/spi/spi-sh-msiof.c                    |  6 +-----
 drivers/spi/spi-sh.c                          | 12 ++----------
 drivers/watchdog/renesas_wdt.c                |  5 +----
 60 files changed, 63 insertions(+), 300 deletions(-)

-- 
2.11.0
