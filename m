From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/41] omap_hsmmc: Add ADMA support and UHS/HS200/DDR support
Date: Fri, 19 May 2017 13:45:00 +0530
Message-ID: <20170519081541.26753-1-kishon@ti.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, nsekhar@ti.com, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series adds UHS, HS200, DDR mode and ADMA support to
omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
SoCs.

The functionality implemented in this series was sent before ([1]) but
was never followed up since supporting high speed modes in dra7 required
IODelay values to be configured. With IODelay driver being merged into
kernel, sending it as a fresh series with support for configuring IODelay
values.

Suggestions of migrating to sdhci driver (from omap_hsmmc driver) is not
addressed since
*) tuning ratio of MMC in dra7 is different from sdhci
*) IOdelay is required for dra7
*) GPIO based card detect is not supported in sdhci
*) Some of the registers don't always have correct values as in sdhci
   (like PSTATE).
Supporting all of these in sdhci will result in adding lot of quirks in
sdhci driver.

This series has been tested on beagleboard, pandaboard, beaglebone-black,
beaglebone, am335x-evm, am437x-evm, dra7xx-evm, dra72x-evm, am571x-idk
and am572x-idk.

I can split the series to go into Ulf Hansson's tree and Tony's tree 
separately if that is required.

[1] -> https://lkml.org/lkml/2015/8/25/213

Balaji T K (1):
  mmc: host: omap_hsmmc: Add voltage switch support for UHS SD card

Kishon Vijay Abraham I (30):
  mmc: host: omap_hsmmc: Support pbias and vmmc_aux to switch to 1.8v
  mmc: host: omap_hsmmc: Separate setting voltage capabilities from bus
    power
  mmc: host: omap_hsmmc: Program HCTL based on signal_voltage set by mmc
    core
  mmc: host: omap_hsmmc: Set clk rate to the max frequency
  mmc: host: omap_hsmmc: Add tuning support
  mmc: host: omap_hsmmc: Allow io voltage switch even for fixed vdd
  mmc: host: omap_hsmmc: Remove incorrect voltage switch  sequence
  mmc: host: omap_hsmmc: Prepare *set_timing() to be used for iodelay
    setting
  mmc: host: omap_hsmmc: Add new compatible string to support dra7
  mmc: host: omap_hsmmc: Fix error path sequence
  mmc: host: omap_hsmmc: Add support to set IODELAY values
  mmc: host: omap_hsmmc: Remove *use_dma* member
  mmc: host: omap_hsmmc: Enable ADMA2
  ARM: dts: dra72-evm: Add vmmc_aux supply to mmc1
  ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
  ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO
    lines
  ARM: dts: dra7-evm: Add pinmux configuration for MMC
  ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
  ARM: dts: am571x-idk: Add pinmux configuration for MMC
  ARM: dts: am572x-idk: Add pinmux configuration for MMC
  ARM: dts: dra72-evm: Add pinmux configuration for MMC
  ARM: dts: dra72-evm-revc: Add pinmux configuration for MMC
  ARM: dts: dra71-evm: Add pinmux configuration for MMC
  ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
  ARM: dts: dra7: Use new dra7-specific compatible string
  ARM: dts: dra7: Add supported MMC/SD modes in MMC dt nodes
  ARM: dts: am57xx-beagle-x15-common: Set MMC2 IO voltage to 3.3V
  ARM: omap2plus_defconfig: Enable PINCTRL_TI_IODELAY
  ARM: multi_v7_defconfig: Enable PINCTRL_TI_IODELAY
  Documentation: ARM: Document new dependencies for MMC on DRA7

Mugunthan V N (1):
  mmc: host: omap_hsmmc: Add software timer when timeout greater than
    hardware capablility

Ravikumar Kattekola (2):
  ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
  ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2

Sekhar Nori (6):
  mmc: omap_hsmmc: Support non-1.8V IO controllers
  ARM: dts: dra72x: Create a common file with MMC/SD IOdelay data
  ARM: dts: dra74x: Create a common file with MMC/SD IOdelay data
  ARM: dts: am57xx-idk: Move common MMC/SD properties to common file
  ARM: dts: am57xx-idk: Set MMC2 IO voltage to 3.3V
  ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM

Tony Lindgren (1):
  ARM: dts: Add dra7 iodelay configuration

 Documentation/arm/OMAP/README                      |    4 +
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    6 +
 arch/arm/boot/dts/am571x-idk.dts                   |   27 +-
 arch/arm/boot/dts/am572x-idk.dts                   |   27 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   30 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |   18 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |   17 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   10 +
 arch/arm/boot/dts/dra7-evm.dts                     |   28 +-
 arch/arm/boot/dts/dra7.dtsi                        |   35 +-
 arch/arm/boot/dts/dra71-evm.dts                    |   28 +
 arch/arm/boot/dts/dra72-evm-common.dtsi            |    2 -
 arch/arm/boot/dts/dra72-evm-revc.dts               |   32 +
 arch/arm/boot/dts/dra72-evm.dts                    |   32 +
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi          |  350 ++++++
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi          |  648 +++++++++++
 arch/arm/configs/multi_v7_defconfig                |    1 +
 arch/arm/configs/omap2plus_defconfig               |    1 +
 arch/arm/mach-omap2/pdata-quirks.c                 |   31 +
 drivers/mmc/host/omap_hsmmc.c                      | 1158 ++++++++++++++++----
 include/dt-bindings/pinctrl/dra.h                  |    3 +
 include/linux/platform_data/hsmmc-omap.h           |   10 +
 22 files changed, 2256 insertions(+), 242 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi

-- 
2.11.0
