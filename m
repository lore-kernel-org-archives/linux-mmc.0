From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v5 00/11] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Tue, 30 Aug 2016 23:09:48 +0200
Message-ID: <1472591399-13907-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
SDR-50 support to the same driver.

This series enables:
* UHS-I SDR-104 on the r8a7790/Lager where UHS-I SDR-50 is already enabled.
* Both UHS-1 SDR-50 and SDR-104 on the r8a7796/Salvator-X

It is based on the next branch of the mmc tree

The "mmc:" patches are targeted at the next branch of the mmc
tree. The "ARM:" and "arm64:" patches are targeted at the next branch of
the renesas tree.

To aid review the following git branches have been provided:
* topic/sdr104-v4 branch: This patchset
* topic/sdr104-v5+sdhi-dma-v3: This patchset merged with a rebase of
                               prototype DMA support for SDHI on R-Car Gen 3

Overview of changes since v4:
* Addressed review from Ulf Hansen
* Add Gen 3 support and enable on r8a7796/Salvator-X

TODO:
* Continue investigation of using saved tap values on resume
  from suspend

Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
results.

Ai Kyuse (3):
  mmc: tmio: enhance illegal sequence handling
  mmc: tmio: Add hw reset support
  mmc: tmio: Add tuning support

Simon Horman (7):
  mmc: tmio: document mandatory and optional callbacks
  mmc: sh_mobile_sdhi: Add tuning support
  ARM: dts: lager: Enable UHS-I SDR-104
  arm64: dts: r8a7795: remove unnecessary cap-mmc-highspeed property
  arm64: r8a7795: Set maximum frequencies for SDHI clocks
  arm64: dts: r8a7795: salvator-x: Enable UHS-I SDR-104
  arm64: defconfig: Enable SDHI and GPIO_REGULATOR

Wolfram Sang (1):
  arm64: dts: r8a7795: salvator: enable UHS for SDHI 0 & 3

 arch/arm/boot/dts/r8a7790-lager.dts                |   1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  24 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   6 +-
 arch/arm64/configs/defconfig                       |   2 +
 drivers/mmc/host/sh_mobile_sdhi.c                  | 275 ++++++++++++++++++++-
 drivers/mmc/host/tmio_mmc.h                        |  15 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |  85 ++++++-
 7 files changed, 396 insertions(+), 12 deletions(-)

-- 
2.7.0.rc3.207.g0ac5344
