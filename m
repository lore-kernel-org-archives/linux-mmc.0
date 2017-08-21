From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/5] mmc: Add OMAP SDHCI driver
Date: Mon, 21 Aug 2017 13:11:27 +0530
Message-ID: <20170821074132.4622-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:35913 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdHUHm0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 03:42:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>

This is the first step in deprecating omap_hsmmc driver completely
and moving to sdhci-omap driver which uses the sdhci library.

This series adds a new SDHCI quirk to indicate MMC_RSP_136 has CRC (since
sdhci in OMAP has CRC)

Apart from the quirk, sdhci-omap has it's own callbacks
to set_clock (clock divider programming is different from generic sdhci)
, set_power, set_bus_width, set_bus_mode and platform_send_init_74_clocks.
These callback functions are implemented based on omap_hsmmc driver.

The sdhci-omap driver supports only the high speed mode and UHS/HS200
mode will be added in a later series.

It has been tested only in boards having DRA7 SoCs like dra7-evm, dra72-evm,
am571x-idk, am572x-idk, am57xx-evm. (Tested only eMMC and SD.
SDIO support will be added later). The plan is to fully convert DRA7
SoC to use SDHCI driver and then convert other legacy platforms to use
SDHCI.

Next Steps:
*) Add UHS support to sdhci-omap
*) Add SDIO support
*) Add support for older TI platforms

Changes from v1:
*) Remove the quirks and instead use sdhci_omap specific callbacks for
   set_power, set_busmode etc.
*) Add a patch from Adrian to tidy reading 136-bit responses

I've also pushed the entire series along with dependent dt patches @
https://github.com/kishon/linux-wip.git sdhci_omap_v1 (in case someone
wants to test)

Adrian Hunter (1):
  mmc: sdhci: Tidy reading 136-bit responses

Kishon Vijay Abraham I (4):
  mmc: sdhci: Add quirk to indicate MMC_RSP_136 has CRC
  dt-bindings: ti-omap-hsmmc: Document new compatible for sdhci omap
  mmc: sdhci-omap: Add OMAP SDHCI driver
  MAINTAINERS: Add TI OMAP SDHCI Maintainer

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   1 +
 MAINTAINERS                                        |   6 +
 drivers/mmc/host/Kconfig                           |  12 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-omap.c                      | 629 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |  31 +-
 drivers/mmc/host/sdhci.h                           |   2 +
 7 files changed, 672 insertions(+), 10 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-omap.c

-- 
2.11.0

