From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 0/7] mmc: Add OMAP SDHCI driver
Date: Mon, 7 Aug 2017 21:31:35 +0530
Message-ID: <20170807160142.12134-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is the first step in deprecating omap_hsmmc driver completely
and moving to sdhci-omap driver which uses the sdhci library.

This series adds 3 new quirks to sdhci library in order to support
MMC in OMAP.
  *) to avoid CRC stripping in MMC_RSP_136
  *) to indicate controller supports ADMA2
  *) to indicate broken POWER_CONTROL (POWER_CONTROL in TI's SOC
     controls IO voltage instead of Vdd).

Apart from the above mentioned quirks, sdhci-omap has it's own callbacks
to set_clock (clock divider programming is different from generic sdhci)
, set_bus_width, set_bus_mode and platform_send_init_74_clocks. These
callback functions are implemented based on omap_hsmmc driver.

The sdhci-omap driver supports only the high speed mode and UHS/HS200
mode will be added in a later series.

It has been tested only in boards having DRA7 SoCs like dra7-evm, dra72-evm,
am571x-idk, am572x-idk, am57xx-evm. (Tested only eMMC and SD.
SDIO support will be added later). The plan is to fully convert DRA7
SoC to use SDHCI driver and then convert other legacy platforms to use
SDHCI.

dts patches will be sent as a separate series.

I've also pushed the entire series along with dependent dt patches @
https://github.com/kishon/linux-wip.git sdhci_omap_v1 (in case someone
wants to test)

Kishon Vijay Abraham I (7):
  mmc: sdhci: Add quirk to indicate no CRC stripping in MMC_RSP_136
  mmc: sdhci: Add quirk to indicate controller supports ADMA2
  mmc: sdhci: Add callback to set bus mode
  mmc: sdhci: Add quirk to indicate broken POWER_CONTROL
  dt-bindings: ti-omap-hsmmc: Document new compatible for sdhci omap
  mmc: sdhci-omap: Add OMAP SDHCI driver
  MAINTAINERS: Add TI OMAP SDHCI Maintainer

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   1 +
 MAINTAINERS                                        |   6 +
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-omap.c                      | 593 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |  39 +-
 drivers/mmc/host/sdhci.h                           |   7 +
 7 files changed, 650 insertions(+), 9 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-omap.c

-- 
2.11.0
