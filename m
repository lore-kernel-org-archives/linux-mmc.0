From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 0/7] add some device nodes support for rk322x SoC
Date: Thu, 22 Jun 2017 15:20:48 +0800
Message-ID: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, chenjh@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

These series add sdmmc, sdio, and other device nodes support for
rk322x SoCs, and also introduce rk3229 basic dtsi file specifically.

Changes from v1:
- Extracted cpu enable-method from rk3229.dtsi to rk322x.dtsi
- Updated the 'Reviewed-by' tag from Heiko Stuebner <heiko@sntech.de> for [PATCH v2 3/7].

David Wu (1):
  ARM: dts: rockchip: Add io-domain node for rk3228

Finley Xiao (1):
  ARM: dts: rockchip: add efuse device node for rk3228

Frank Wang (2):
  ARM: dts: rockchip: add cpu enable method for rk3228 SoC
  ARM: dts: rockchip: add basic dtsi file for RK3229 SoC

Shawn Lin (3):
  Documentation: rockchip-dw-mshc: add description for rk3228
  ARM: dts: rockchip: fix compatible string for eMMC node of rk3228 SoC
  ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  1 +
 arch/arm/boot/dts/rk3229-evb.dts                   |  2 +-
 arch/arm/boot/dts/rk3229.dtsi                      | 89 +++++++++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi                      | 93 +++++++++++++++++++++-
 4 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229.dtsi

-- 
2.0.0
