From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 0/6] Add Support for MMC/SD in TI's AM65x SOCs
Date: Thu, 4 Oct 2018 16:44:45 +0530
Message-ID: <20181004111451.9539-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, faiz_abbas@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, catalin.marinas@arm.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

The following patches add driver support for MMC/SD in TI's
AM65x SOCs. There are two controller instances. Both are compatible
with eMMC5.1 Host Controller Standard Specification and SD Host
Controller Standard Specification 4.10.

DT Support patches will be posted separately.

Faiz Abbas (6):
  dt-bindings: phy: am654-mmc-phy: Document new phy bindings
  phy: am654-mmc-phy: Add Support for MMC PHY on AM654 Devices
  dt-bindings: mmc: sdhci-of-arasan: Add new compatible for AM654 MMC
    PHY
  mmc: sdhci-of-arasan: Add a single data structure to incorporate pdata
    and soc_ctl_map
  mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
  arm64: defconfig: Enable MMC PHY for AM65xx

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |   1 +
 .../devicetree/bindings/phy/am654-mmc-phy.txt |  42 +++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/mmc/host/sdhci-of-arasan.c            |  93 +++++-
 drivers/phy/ti/Kconfig                        |   7 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-am654-mmc.c                | 291 ++++++++++++++++++
 7 files changed, 421 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/am654-mmc-phy.txt
 create mode 100644 drivers/phy/ti/phy-am654-mmc.c

-- 
2.18.0
