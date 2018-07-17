From: <cl@rock-chips.com>
Subject: [PATCH v1 0/7] arm64: dts: rockchip: add basic dts file for PX30 SoCs
Date: Tue, 17 Jul 2018 15:49:00 +0800
Message-ID: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, huibin.hong@rock-chips.com, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, klaus.goger@theobroma-systems.com, sugar.zhang@rock-chips.com, linux-rockchip@lists.infradead.org, jacob-chen@iotwrt.com, jagan@amarulasolutions.com, cl@rock-chips.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, arnd@arndb.de, frank.wang@rock-chips.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com, broonie@kernel.org, djw@t-chip.com.cn, sandy.huang@rock-chips.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, david.wu@rock-chips.com, william.wu@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Liang Chen (7):
  Documentation: usb: dwc2: add description for px30
  Documentation: rockchip-dw-mshc: add description for px30
  Documentation: spi-rockchip: add description for px30
  Documentation: rockchip-i2s: add description for px30
  Documentation: rockchip: grf: add grf and pmugrf description for px30
  arm64: dts: rockchip: add core dtsi file for PX30 SoCs
  arm64: dts: rockchip: add PX30 eavluation board devicetree

 Documentation/devicetree/bindings/arm/rockchip.txt |    4 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |    1 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 .../devicetree/bindings/sound/rockchip-i2s.txt     |    1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |    1 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  539 ++++++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2044 ++++++++++++++++++++
 9 files changed, 2594 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi

-- 
1.9.1
