From: Frank Wang <frank.wang@rock-chips.com>
Subject: [RESEND PATCH v2 0/7] add some device nodes support for rk322x SoC
Date: Thu, 22 Jun 2017 18:29:55 +0800
Message-ID: <1498127402-6705-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:36979 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752755AbdFVKaT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jun 2017 06:30:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>

Resend these series for adding compatible changes of efuse in [PATCH v2 7/7].

These series add sdmmc, sdio, and other device nodes support for
rk322x SoCs, and also introduce rk3229 basic dtsi file specifically.

Changes from v1:
- Extracted cpu enable-method from rk3229.dtsi to rk322x.dtsi
- Amended compatible rk322x-efuse to rk3228-efuse in [PATCH v2 7/7].
- Updated the 'Reviewed-by' tag from Heiko Stuebner <heiko@sntech.de> for [PATCH v2 3/7].

The following patch on patchwork are required for this changes.
https://patchwork.kernel.org/patch/9803825/

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


