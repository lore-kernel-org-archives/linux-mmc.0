From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 00/18] ARM: Add minimal Raspberry Pi 4 support
Date: Mon, 22 Jul 2019 07:54:31 +0200
Message-ID: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
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
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Stefan Wahren <wahrenst@gmx.net>
List-Id: linux-mmc@vger.kernel.org

This series adds minimal support for the new Raspberry Pi 4, so we are able
to login via debug UART.

Patch 1-5:   Prepare platform and DTS for the new SoC BMC2711
Patch 6-10:  Enable support for emmc2 on BCM2711
Patch 11-12: Enable pinctrl for BCM2711
Patch 13-17: Add Raspberry Pi 4 DTS support
Patch 18:    Update MAINTAINERS

Unfortunately the Raspberry Pi Foundation didn't released a
peripheral documentation for the new SoC yet. So we only have a preliminary
datasheet [1] and reduced schematics [2].

Changes since RFC:
- change BCM2838 -> BCM2711 as discussed in RFC
- update MAINTAINERS accordingly
- drop "spi: bcm2835: enable shared interrupt support" from series
- squash all pinctrl-bcm2835 changes into one patch
- introduce SoC specific clock registration as suggested by Florian
- fix watchdog probing for Raspberry Pi 4
- convert brcm,bcm2835.txt to json-schema
- move VC4 node to bcm2835-common.dtsi
- fallback to legacy pull config for Raspberry Pi 4
- revert unintended change of mailbox in bcm283x.dtsi
- add reference for arm64

[1] - https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711/rpi_DATA_2711_1p0_preliminary.pdf
[2] - https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_4b_4p0_reduced.pdf

Phil Elwell (1):
  ARM: bcm2835: DMA can only address 1GB

Stefan Wahren (17):
  ARM: bcm283x: Reduce register ranges for UART, SPI and I2C
  ARM: dts: bcm283x: Move BCM2835/6/7 specific to bcm2835-common.dtsi
  ARM: dts: bcm283x: Define MMC interfaces at board level
  ARM: dts: bcm283x: Define memory at board level
  dt-bindings: bcm2835-cprman: Add bcm2711 support
  clk: bcm2835: Introduce SoC specific clock registration
  clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support
  dt-bindings: sdhci-iproc: Add brcm,bcm2711-emmc2
  mmc: sdhci-iproc: Add support for emmc2 of the BCM2711
  dt-bindings: pinctrl: bcm2835: Add brcm,bcm2711 compatible
  pinctrl: bcm2835: Add support for BCM2711 pull-up functionality
  dt-bindings: arm: Convert BCM2835 board/soc bindings to json-schema
  dt-bindings: arm: bcm2835: Add Raspberry Pi 4 to DT schema
  ARM: bcm2835: Add bcm2711 compatible string
  ARM: dts: Add minimal Raspberry Pi 4 support
  arm64: dts: broadcom: Add reference to RPi 4 B
  MAINTAINERS: Add BCM2711 to BCM2835 ARCH

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |  51 ++
 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |  67 ---
 .../bindings/clock/brcm,bcm2835-cprman.txt         |   4 +-
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |   4 +-
 .../bindings/pinctrl/brcm,bcm2835-gpio.txt         |   1 +
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              | 120 ++++
 arch/arm/boot/dts/bcm2711.dtsi                     | 667 +++++++++++++++++++++
 arch/arm/boot/dts/bcm2835-common.dtsi              | 177 ++++++
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |  12 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts                |  12 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts           |  12 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |  12 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |  12 +
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts          |   7 +
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi             |   5 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  12 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |  12 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  18 -
 arch/arm/boot/dts/bcm2835.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts              |   8 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   1 +
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          |   7 +
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |   1 +
 arch/arm/boot/dts/bcm2837.dtsi                     |   1 +
 arch/arm/boot/dts/bcm283x.dtsi                     | 160 +----
 arch/arm/mach-bcm/board_bcm2835.c                  |   2 +
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts   |   2 +
 drivers/clk/bcm/clk-bcm2835.c                      | 117 +++-
 drivers/mmc/host/sdhci-iproc.c                     |   9 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              | 105 +++-
 include/dt-bindings/clock/bcm2835.h                |   2 +
 37 files changed, 1365 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
 create mode 100644 arch/arm/boot/dts/bcm2711-rpi-4-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2711.dtsi
 create mode 100644 arch/arm/boot/dts/bcm2835-common.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dts

--
2.7.4
