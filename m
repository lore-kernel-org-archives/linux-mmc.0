From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 3/4] arm64: dts: rockchip: add core dtsi file for PX30 SoCs
Date: Thu, 02 Aug 2018 13:58:51 +0200
Message-ID: <5420010.G1GNdo6K2G@phil>
References: <1533113116-8820-1-git-send-email-cl@rock-chips.com> <1533113116-8820-4-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533113116-8820-4-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cl@rock-chips.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, klaus.goger@theobroma-systems.com, hjc@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, yamada.masahiro@socionext.com, arnd@arndb.de, zhangqing@rock-chips.com, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, david.wu@rock-chips.com, huangtao@rock-chips.com, tony.xie@rock-chips.com, sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi,

Am Mittwoch, 1. August 2018, 10:45:15 CEST schrieb cl@rock-chips.com:
> From: Liang Chen <cl@rock-chips.com>
> 
> This patch adds core dtsi file for Rockchip PX30 SoCs.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>

applied with the following changes:
- some reordering
- cpu properties should be present in all cpu nodes (clocks etc)
- added dma-names to uarts
- dropped #dma-cells from uarts+spi (only for dma-controllers)
- dropped phy-names from usb nodes without actual phys
  (please readd once you have phy support)
- dropped the gamma_lut + reg-names and spanned the
  registers till below the iommu, similar to all other socs we have
- dropped the high_speed pinctrl state from the spi nodes
  (not part of mainline dt-binding)
- dropped peripherals-req-type-burst from the dmac
  (not part of mainline dt-binding)
- split out dwc2 into separate patch to be applied once the binding lands
- set #sound-dai-cells in px30.dtsi ... property of the i2s controller
  and doesn't change per board


Heiko
