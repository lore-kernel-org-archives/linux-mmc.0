From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 0/8] mmc: dw_mmc: allow tuning using the clk-phase api
Date: Mon, 31 Aug 2015 20:23:58 +0200
Message-ID: <1441045446-30858-1-git-send-email-heiko@sntech.de>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: ulf.hansson@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, tgih.jun@samsung.com, jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
List-Id: linux-mmc@vger.kernel.org

This series resurrects and adapts some individual patches whose sum
enable the dw_mmc hosts on Rockchip socs to tune clock phases using
the generic phase api (rk3288 and following have this capability).

The changes to the original mmc-phase clocks are expanded by further
findings resulting from devices being used in the field.

Similarly the regulator handling changes do use the brand new
regulator_set_voltage_triplet call to allow specifying lower and upper
limits. One possible point of discussion are the two voltage ranges
that are tried for the 3.3V signal level. Trying to stay near vmmc
at first and only then opening the range to the full 2.7-3.6V.

This mainly circumvents a shortcoming of the regulator voltage
setting, in that even with regulator_set_voltage_triplet the regulator
framework will take the lowest possible voltage when the possible
voltages are below the target voltage. While it may be ideal to solve
this on the regulator side, I'm not seeing this appearing in the short
term, mainly because all regulator parts (including regulator drivers)
are keyed to selecting the lowest voltage from the range, while on the
mmc side we know which voltages may work and trying this in two steps
does not create to much overhead, as unsupported voltages are already
filtered out by the regulator_is_voltage_selected calls.


Alexandru M Stan (3):
  mmc: dw_mmc: dt-binding: Add tuning related things
  mmc: dw_mmc: Generic MMC tuning with the clock phase framework
  ARM: dts: rockchip: Add drive/sample clocks for rk3288 dw_mmc devices

Douglas Anderson (4):
  clk: rockchip: Allow more precision for some mmc clock phases
  clk: rockchip: Make calculations use rounding
  mmc: core: Add mmc_regulator_set_vqmmc()
  mmc: dw_mmc: Use mmc_regulator_set_vqmmc in
    start_signal_voltage_switch

Heiko Stuebner (1):
  ARM: dts: rockchip: add tuning related settings to veyron devices

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  14 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi         |   7 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   6 +
 arch/arm/boot/dts/rk3288.dtsi                      |  20 +--
 drivers/clk/rockchip/clk-mmc-phase.c               |  54 ++++---
 drivers/mmc/core/core.c                            |  68 +++++++++
 drivers/mmc/host/dw_mmc.c                          | 159 +++++++++++++++++++--
 include/linux/mmc/dw_mmc.h                         |   3 +
 include/linux/mmc/host.h                           |   7 +
 9 files changed, 295 insertions(+), 43 deletions(-)

-- 
2.1.4

