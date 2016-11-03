From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 00/13] mmc: dw_mmc: cleans the codes for dwmmc controller
Date: Thu, 03 Nov 2016 15:21:22 +0900
Message-ID: <20161103062135.10697-1-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38216 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbcKCGVo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 02:21:44 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>

This patchset is modified the some minor fixing and cleaning code.
If needs to split the patches, i will re-send the patches.

* Major changes
- Use the cookie enum values like sdhci controller.
- Remove the unnecessary codes and use stop_abort() by default.
- Remove the obsoleted property "supports-highspeed"
- Remove the "clock-freq-min-max" property. Instead, use "max-frequency"
- Minimum clock value is set to 100K by default.

Jaehoon Chung (13):
  mmc: dw_mmc: display the real register value on debugfs
  mmc: dw_mmc: fix the debug message for checking card's present
  mmc: dw_mmc: change the DW_MCI_FREQ_MIN from 400K to 100K
  mmc: dw_mmc: use the hold register when send stop command
  mmc: dw_mmc: call the dw_mci_prep_stop_abort() by default
  mmc: core: move the cookie's enum values from sdhci.h to mmc.h
  mmc: dw_mmc: use the cookie's enum values for post/pre_req()
  mmc: dw_mmc: remove the unnecessary mmc_data structure
  mmc: dw_mmc: remove the "clock-freq-min-max" property
  ARM: dts: exynos: replace to "max-frequecy" instead of
    "clock-freq-min-max"
  ARM: dts: rockchip: replace to "max-frequency" instead of
    "clock-freq-min-max"
  ARM64: dts: rockchip: replace to "max-frequency" instead of
    "clock-freq-min-max"
  Documentation: synopsys-dw-mshc: remove the unused properties

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  8 --
 arch/arm/boot/dts/exynos3250-artik5-eval.dts       |  2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |  2 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |  2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  6 +-
 arch/arm/boot/dts/rk322x.dtsi                      |  2 +-
 arch/arm/boot/dts/rk3288.dtsi                      |  8 +-
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |  2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  6 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  4 +-
 drivers/mmc/host/dw_mmc.c                          | 99 ++++++++++------------
 drivers/mmc/host/sdhci.h                           |  6 --
 include/linux/mmc/core.h                           |  6 ++
 14 files changed, 68 insertions(+), 87 deletions(-)

-- 
2.10.1

