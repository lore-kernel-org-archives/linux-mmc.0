From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 00/15] dra7: mmc: Update mmc dt node to use sdhci-omap
Date: Wed, 25 Apr 2018 18:24:34 +0530
Message-ID: <20180425125449.19755-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson=20?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Previous version of the patch series was sent here
https://lkml.org/lkml/2018/2/6/250

Most of the patches sent for v2 was merged. Remaining unmerged patches
from v2 and a few additional patches are sent here.

This series should be merged only after [1].
[1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2

This series:
 *) Adds wilink wlan support (Now all MMC instances in DRA7 will use
    sdhci-omap)
 *) Add a new pinctrl group for clk line without pullup required for
    UHS cards to work reliably.
 *) Update README to make sure users update .config file from 4.18
    kernel.
 *) Use sdhci-omap programming model.

In the "Use sdhci-omap programming model" patch, "ti,omap4-hsmmc"
compatible is removed. This is because if both "ti,dra7-sdhci" and
"ti,omap4-hsmmc" is added and if there is probe deferral in sdhci_omap
driver, the device is binding to omap_hsmmc driver.

Once omap_hsmmc and sdhci_omap driver are feature identical,
sdhci_omap driver will be made to support omap_hsmmc binding
(including "ti,omap4-hsmmc" compatible) and omap_hsmmc driver will
be removed. Till then dt nodes with "ti,omap4-hsmmc" compatible
will use omap_hsmmc driver and "ti,dra7-sdhci" compatible will
use sdhci_omap driver.

Hari Nagalla (2):
  ARM: dts: dra72-evm-common: Add wilink8 wlan support
  ARM: dts: dra7-evm: Add wilink8 wlan support

Kishon Vijay Abraham I (11):
  ARM: dts: dra72-evm-common: Remove mmc specific pinmux
  ARM: dts: dra71-evm: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra72x-mmc-iodelay: Add a new pinctrl group for clk line
    without pullup
  ARM: dts: dra74x-mmc-iodelay: Add a new pinctrl group for clk line
    without pullup
  ARM: dts: dra76x-mmc-iodelay: Add a new pinctrl group for clk line
    without pullup
  ARM: dts: am57xx-idk: Use pinctrl group from dra7xx-mmc-iodelay.dtsi
    to select pulldown
  ARM: dts: dra71-evm: Use pinctrl group from dra72x-mmc-iodelay.dtsi to
    select pulldown
  ARM: dts: dra7-evm: Model EVM_3V6 regulator
  ARM: dts: dra7: Use sdhci-omap programming model
  ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node
  Documentation: ARM: Add new MMC requirements for DRA7/K2G

Sekhar Nori (1):
  ARM: dts: am574x-idk: Add pinmux configuration for MMC

Vishal Mahaveer (1):
  ARM: dts: dra76-evm: Add wilink8 wlan support

 Documentation/arm/OMAP/README                 |  4 ++
 arch/arm/boot/dts/am571x-idk.dts              |  2 +-
 arch/arm/boot/dts/am572x-idk.dts              |  2 +-
 arch/arm/boot/dts/am574x-idk.dts              | 19 +++++
 .../boot/dts/am57xx-beagle-x15-common.dtsi    |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts       |  1 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi      |  3 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi        | 15 ++++
 arch/arm/boot/dts/dra7-evm.dts                | 68 ++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                   | 30 ++++----
 arch/arm/boot/dts/dra71-evm.dts               | 16 +----
 arch/arm/boot/dts/dra72-evm-common.dtsi       | 71 +++++++++++--------
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi     | 22 ++++++
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi     | 11 +++
 arch/arm/boot/dts/dra76-evm.dts               | 34 ++++++++-
 arch/arm/boot/dts/dra76x-mmc-iodelay.dtsi     | 11 +++
 16 files changed, 248 insertions(+), 65 deletions(-)

-- 
2.17.0
