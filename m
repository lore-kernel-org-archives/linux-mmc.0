From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 00/14] dra7: mmc: Update mmc dt node to use sdhci-omap
Date: Fri, 27 Apr 2018 17:38:51 +0530
Message-ID: <20180427120905.3665-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Changes from v3:
*) Added dra7-mmc-iodelay.dtsi to add a new pinctrl group for clk line
   without pullup to be used for dra71-evm and am57xx-idk.
*) Rename wlcore node name to wifi

This series should be merged only after [1].
[1] -> https://marc.info/?l=linux-omap&m=152482966225758&w=2

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

Kishon Vijay Abraham I (10):
  ARM: dts: dra72-evm-common: Remove mmc specific pinmux
  ARM: dts: dra71-evm: Add "vqmmc-supply" property for mmc2
  ARM: dts: dra7-mmc-iodelay: Add a new pinctrl group for clk line
    without pullup
  ARM: dts: am57xx-idk: Use pinctrl group from dra7-mmc-iodelay.dtsi to
    select pulldown
  ARM: dts: dra71-evm: Use pinctrl group from dra7-mmc-iodelay.dtsi to
    select pulldown
  ARM: dts: am57xx-beagle-x15/am57xx-idk: Fix pinctrl-names
  ARM: dts: dra7-evm: Model EVM_3V6 regulator
  ARM: dts: dra7: Use sdhci-omap programming model
  ARM: dts: dra7: Add high speed modes capability to MMC1/MMC2 dt node
  Documentation: ARM: Add new MMC requirements for DRA7/K2G

Sekhar Nori (1):
  ARM: dts: am574x-idk: Add pinmux configuration for MMC

Vishal Mahaveer (1):
  ARM: dts: dra76-evm: Add wilink8 wlan support

 Documentation/arm/OMAP/README                 |  4 ++
 arch/arm/boot/dts/am571x-idk.dts              |  5 +-
 arch/arm/boot/dts/am572x-idk.dts              |  5 +-
 arch/arm/boot/dts/am574x-idk.dts              | 20 ++++++
 .../boot/dts/am57xx-beagle-x15-common.dtsi    |  4 +-
 arch/arm/boot/dts/am57xx-beagle-x15.dts       |  3 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi      | 14 +---
 arch/arm/boot/dts/dra7-evm-common.dtsi        | 15 ++++
 arch/arm/boot/dts/dra7-evm.dts                | 68 ++++++++++++++++++
 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi       | 19 +++++
 arch/arm/boot/dts/dra7.dtsi                   | 32 ++++-----
 arch/arm/boot/dts/dra71-evm.dts               | 17 +----
 arch/arm/boot/dts/dra72-evm-common.dtsi       | 71 +++++++++++--------
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi     | 11 +++
 arch/arm/boot/dts/dra76-evm.dts               | 34 ++++++++-
 15 files changed, 243 insertions(+), 79 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra7-mmc-iodelay.dtsi

-- 
2.17.0
