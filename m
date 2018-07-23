From: <cl@rock-chips.com>
Subject: [PATCH v2 0/6] arm64: dts: rockchip: add basic dts file for PX30 SoCs
Date: Mon, 23 Jul 2018 17:25:18 +0800
Message-ID: <1532337924-4185-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, klaus.goger@theobroma-systems.com, hjc@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, yamada.masahiro@socionext.com, arnd@arndb.de, zhangqing@rock-chips.com, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, david.wu@rock-chips.com, huangtao@rock-chips.com, tony.xie@rock-chips.com, sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Changes in V2:
1. change the subject to format "dt-bindings: module: ..." for the documents. 
2. use new property <num-interpolated-steps> for backlight.
3. remove pinctrl of rk809, because the driver is not ready.

Liang Chen (6):
  dt-bindings: usb: dwc2: add description for px30
  dt-bindings: mmc: rockchip-dw-mshc: add description for px30
  dt-bindings: sound: rockchip-i2s: add description for px30
  dt-bindings: rockchip: grf: add grf and pmugrf description for px30
  arm64: dts: rockchip: add core dtsi file for PX30 SoCs
  arm64: dts: rockchip: add PX30 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  473 +++++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2043 ++++++++++++++++++++
 8 files changed, 2526 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi

-- 
1.9.1
