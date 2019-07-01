From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v2 00/11] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date: Mon,  1 Jul 2019 10:59:40 +0530
Message-ID: <1561958991-21935-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, michal.simek@xilinx.com, adrian.hunter@intel.com, christoph.muellner@theobroma-systems.com, philipp.tomsich@theobroma-systems.com, viresh.kumar@linaro.org, scott.branden@broadcom.com, ayaka@soulik.info, kernel@esmil.dk, tony.xie@rock-chips.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch series does the following:
 - Reorganize the Clock Handling in Arasan SD driver
 - Adds new sampling clock in Arasan SD driver
 - Adds support to set Clock Delays in SD Arasan Driver
 - Add SDIO Tap Delay handling in ZynqMP firmware driver
 - Add support for ZynqMP Tap Delays setting in Arasan SD driver

Changes in v2:
	- Replaced the deprecated calls to clock framework APIs
	- Added support for dev_clk_get() call to work for SD card clock
	- Separated the clock data struct
	- Fragmented the patch series in smaller patches to make it more
	  readable

This patch series contains a DT patch, which I think should be there to
maintain the order of commits.

Manish Narani (11):
  dt-bindings: mmc: arasan: Update documentation for SD Card Clock
  arm64: dts: rockchip: Add optional clock property indicating sdcard
    clock
  mmc: sdhci-of-arasan: Replace deprecated clk API calls
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay APIs
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  49 ++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   4 +-
 drivers/firmware/xilinx/zynqmp.c                   |  48 +++
 drivers/mmc/host/sdhci-of-arasan.c                 | 453 ++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               |  15 +-
 5 files changed, 540 insertions(+), 29 deletions(-)

-- 
2.1.1
