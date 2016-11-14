From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 00/10] Add basic support for Rockchip RK1108 SOC
Date: Mon, 14 Nov 2016 19:55:50 +0800
Message-ID: <1479124550-24037-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: heiko@sntech.de
Cc: shawn.lin@rock-chips.com, linus.walleij@linaro.org, robh+dt@kernel.org, linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-gpio@vger.kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org


RK1108 is embedded with an ARM Cortex-A7 single core and a DSP core.
It is designed for varies application scenario such as car DVR, sports
DV, secure camera and UAV camera.
This patch series add basic support for it, which can boot a board with
initramfs into shell.
More new feathers will come soon.

Changes in v2:
- split dt-binding header from clk driver
- fix some CodingStyle issues
- add dt-binding documentation for pinctrl
- add pull and drive-strength functionality for pinctrl
- fix timer and gic dt description
- ordering devices by register address
- move the board in the rockchip.txt to the block of Rockchip boards

Andy Yan (6):
  dt-bindings: add documentation for rk1108 pinctrl
  pinctrl: rockchip: add support for rk1108
  ARM: add low level debug uart for rk1108
  ARM: dts: add basic support for Rockchip RK1108 SOC
  ARM: rockchip: enable support for RK1108 SoC
  ARM: dts: rockchip: add rockchip RK1108 Evaluation board

Shawn Lin (4):
  dt-bindings: rockchip-dw-mshc: add RK1108 dw-mshc description
  dt-bindings: add documentation for rk1108 cru
  clk: rockchip: add dt-binding header for rk1108
  clk: rockchip: add clock controller for rk1108

 Documentation/devicetree/bindings/arm/rockchip.txt |   5 +-
 .../bindings/clock/rockchip,rk1108-cru.txt         |  60 +++
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 .../bindings/pinctrl/rockchip,pinctrl.txt          |   9 +-
 arch/arm/Kconfig.debug                             |  30 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk1108-evb.dts                   |  69 ++++
 arch/arm/boot/dts/rk1108.dtsi                      | 428 +++++++++++++++++++
 arch/arm/mach-rockchip/rockchip.c                  |   1 +
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-rk1108.c                  | 451 +++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |  14 +
 drivers/pinctrl/pinctrl-rockchip.c                 |  87 +++-
 include/dt-bindings/clock/rk1108-cru.h             | 270 ++++++++++++
 14 files changed, 1421 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk1108-cru.txt
 create mode 100644 arch/arm/boot/dts/rk1108-evb.dts
 create mode 100644 arch/arm/boot/dts/rk1108.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk1108.c
 create mode 100644 include/dt-bindings/clock/rk1108-cru.h

-- 
2.7.4


