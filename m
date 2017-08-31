From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 0/6] mmc: Add OMAP SDHCI driver
Date: Thu, 31 Aug 2017 15:48:43 +0530
Message-ID: <20170831101849.9489-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

This is the first step in deprecating omap_hsmmc driver completely
and moving to sdhci-omap driver which uses the sdhci library.

This patch that adds a new SDHCI quirk "MMC_RSP_136" has already been
merged and hence removed it in this revision.

Apart from the quirk, sdhci-omap has it's own callbacks
to set_clock (clock divider programming is different from generic sdhci)
, set_power, set_bus_width, set_bus_mode and platform_send_init_74_clocks.
These callback functions are implemented based on omap_hsmmc driver.
Since sdhci-omap driver requires pbias regulator fixes to be present, I've
sent them as part of this series.

The sdhci-omap driver supports only the high speed mode and UHS/HS200
mode will be added in a later series.

It has been tested only in boards having DRA7 SoCs like dra7-evm, dra72-evm,
am571x-idk, am572x-idk, am57xx-evm. (Tested only eMMC and SD.
SDIO support will be added later). The plan is to fully convert DRA7
SoC to use SDHCI driver and then convert other legacy platforms to use
SDHCI.

The first 3 patches have also been verified not to cause any regression.

Next Steps:
*) Add UHS support to sdhci-omap
*) Add SDIO support
*) Add support for older TI platforms

Changes from v2:
*) Rebased on git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
*) Included a couple of patches from Ravikumar to fix pbias-regulator driver
   to support max-voltage of 3.3V. This is required for sdhci-omap driver.
*) Create sdhci-omap as a new driver with MMC generic bindings and hence doesn't
   have bindings like ti,dual-volt added for omap-hsmmc. (Instead of
   ti,dual-volt, sdhci-omap driver uses the supported regulator voltage to
   set controller IO voltage capabilities).
   When omap-hsmmc driver is deprecated, support for these properties will
   be added to sdhci-omap.
*) Fixed minor comments from Adrian).

Changes from v1:
*) Remove the quirks and instead use sdhci_omap specific callbacks for
   set_power, set_busmode etc.
*) Add a patch from Adrian to tidy reading 136-bit responses

I've also pushed the entire series along with dependent dt patches @
https://github.com/kishon/linux-wip.git ulf_next (in case someone
wants to test)

Kishon Vijay Abraham I (4):
  mmc: host: omap_hsmmc: Remove setting PBIAS voltage
  dt-bindings: sdhci-omap: Add bindings for the sdhci-omap controller
  mmc: sdhci-omap: Add OMAP SDHCI driver
  MAINTAINERS: Add TI OMAP SDHCI Maintainer

Ravikumar Kattekola (2):
  regulator: pbias: Select voltage table based on max-voltage
  ARM: dts: dra7: Increase max-voltage of pbias regulator

 .../devicetree/bindings/mmc/sdhci-omap.txt         |  16 +
 MAINTAINERS                                        |   6 +
 arch/arm/boot/dts/dra7.dtsi                        |   2 +-
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/omap_hsmmc.c                      |  33 +-
 drivers/mmc/host/sdhci-omap.c                      | 604 +++++++++++++++++++++
 drivers/regulator/pbias-regulator.c                |  21 +-
 8 files changed, 666 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
 create mode 100644 drivers/mmc/host/sdhci-omap.c

-- 
2.11.0
