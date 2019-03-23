From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 00/24] arm64: mediatek: add support for Pumpkin MT8516 board
Date: Sat, 23 Mar 2019 22:15:48 +0100
Message-ID: <20190323211612.860-1-fparent@baylibre.com>
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
To: matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, ryder.lee@mediatek.com, linux-watchdog@vger.kernel.org, jjian.zhou@mediatek.com, wenzhen.yu@mediatek.com, stephane.leprovost@mediatek.com, sean.wang@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yong.mao@mediatek.com, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, hsin-hsiung.wang@mediatek.com, linux-serial@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, linux-clk@vger.kernel.org, chaotian.jing@mediatek.com, linux-i2c@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The pumpkin board is designed by Gossamer Engineering and is
using a MediaTek SoC. The board currently comes in two available
version: MT8516 SoC and MT8167 SoC.

The board provides the following IOs: eMMC, NAND, SD card, USB 2 type-A,
Ethernet, Wi-Fi, Bluetooth, Audio (jack out, 2 PDM port, 1 analog in),
serial over USB, and an expansion header.

This patch series adds the basic board support to be able to boot
on the eMMC of the MT8516 based Pumpkin board.

The board is using a MT6392 PMIC.

Fabien Parent (24):
  dt-bindings: regulator: add support for MT6392
  regulator: mt6392: Add support for MT6392 regulator
  dt-bindings: pwrap: mediatek: add pwrap support for MT8516
  soc: mediatek: pwrap: add missing check on rstc
  soc: mediatek: pwrap: add support for MT8516 pwrap
  mfd: mt6397: Add support for MT6397 pmic
  arm64: dts: mt6392: Add PMIC mt6392 dtsi
  dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
  mmc: mtk-sd: check for valid optional memory resource
  mmc: mtk-sd: add support for MT8516
  dt-bindings: mediatek: topckgen: add support for MT8516
  dt-bindings: mediatek: infracfg: add support for MT8516
  dt-bindings: mediatek: apmixedsys: add support for MT8516
  clk: mediatek: add clock driver for MT8516
  dt-bindings: pinctrl: pinctrl-mt65xx: add support for MT8516
  pinctrl: mediatek: Add MT8516 Pinctrl driver
  dt-bindings: wdog: mtk-wdt: add support for MT851
  dt-bindings: timer: mtk-timer: add support for MT8516
  dt-bindings: spi: spi-mt65xx: add support for MT8516
  dt-bindings: serial: mtk-uart: add support for MT8516
  dt-bindings: irq: mtk,sysirq: add support for MT8516
  dt-bindings: i2c: i2c-mtk: add support for MT8516
  arm64: dts: mediatek: add dtsi for MT8516
  arm64: dts: mediatek: add pumpkin board dts

 .../arm/mediatek/mediatek,apmixedsys.txt      |    1 +
 .../arm/mediatek/mediatek,infracfg.txt        |    1 +
 .../arm/mediatek/mediatek,topckgen.txt        |    1 +
 .../devicetree/bindings/i2c/i2c-mtk.txt       |    1 +
 .../interrupt-controller/mediatek,sysirq.txt  |    3 +-
 .../devicetree/bindings/mmc/mtk-sd.txt        |    1 +
 .../bindings/pinctrl/pinctrl-mt65xx.txt       |    1 +
 .../bindings/regulator/mt6392-regulator.txt   |  220 +++
 .../devicetree/bindings/serial/mtk-uart.txt   |    1 +
 .../bindings/soc/mediatek/pwrap.txt           |    1 +
 .../devicetree/bindings/spi/spi-mt65xx.txt    |    1 +
 .../bindings/timer/mediatek,mtk-timer.txt     |    1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt  |    1 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      |  208 +++
 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h |  663 +++++++++
 .../boot/dts/mediatek/mt8516-pumpkin.dts      |   19 +
 arch/arm64/boot/dts/mediatek/mt8516.dtsi      |  409 ++++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |  210 +++
 .../dts/mediatek/pumpkin-emmc-common.dtsi     |   75 ++
 drivers/clk/mediatek/Kconfig                  |    9 +
 drivers/clk/mediatek/Makefile                 |    1 +
 drivers/clk/mediatek/clk-mt8516.c             |  815 ++++++++++++
 drivers/mfd/mt6397-core.c                     |   96 ++
 drivers/mmc/host/mtk-sd.c                     |   19 +-
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     |  384 ++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8516.h | 1182 +++++++++++++++++
 drivers/regulator/Kconfig                     |    9 +
 drivers/regulator/Makefile                    |    1 +
 drivers/regulator/mt6392-regulator.c          |  490 +++++++
 drivers/soc/mediatek/mtk-pmic-wrap.c          |  109 +-
 include/dt-bindings/clock/mt8516-clk.h        |  211 +++
 include/linux/mfd/mt6392/core.h               |   42 +
 include/linux/mfd/mt6392/registers.h          |  487 +++++++
 include/linux/regulator/mt6392-regulator.h    |   40 +
 37 files changed, 5717 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6392-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-emmc-common.dtsi
 create mode 100644 drivers/clk/mediatek/clk-mt8516.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8516.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8516.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/clock/mt8516-clk.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.20.1
