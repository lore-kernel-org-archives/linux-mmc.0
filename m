From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 0/4] mmc: fixed the mmc_of_parse for dwmmc
Date: Wed, 28 May 2014 14:35:47 +0900
Message-ID: <1401255351-17653-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, ludovic.desroches@atmel.com, tgih.jun@samsung.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch-set is fixed the dw-mmc controller problem.
dw-mmc controller have the slot, but mmc_of_parse didn't parse the slot sub-node.
So dw-mmc controller didn't work correctly.

Jaehoon Chung (3):
  mmc: dw_mmc: use the __mmc_of_parse to parse the slot node
  mmc: dw_mmc: remove the "supports-highspeed" property.
  ARM: dts: replace the slot property into slot sub-node for dwmmc.

Ludovic Desroches (1):
  mmc: host: add slot argument to mmc_of_parse

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    5 +++--
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |    3 ++-
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    6 ++++--
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    4 ++--
 arch/arm/boot/dts/exynos4412-origen.dts            |    4 ++--
 arch/arm/boot/dts/exynos4412-trats2.dts            |    6 +++---
 arch/arm/boot/dts/exynos5250-arndale.dts           |    6 +++---
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   10 +++++-----
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    6 +++---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    6 +++---
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 ++--
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |    2 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |    5 +++--
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    5 +++--
 arch/arm/boot/dts/socfpga_vt.dts                   |    5 +++--
 drivers/mmc/core/host.c                            |   13 +++++++++----
 drivers/mmc/host/dw_mmc.c                          |   18 ++++++------------
 include/linux/mmc/host.h                           |   10 +++++++++-
 18 files changed, 66 insertions(+), 52 deletions(-)

-- 
1.7.9.5
