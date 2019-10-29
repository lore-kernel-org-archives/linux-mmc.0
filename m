From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 0/8] Arasan SDHCI enhancements and ZynqMP Tap Delays Handling
Date: Tue, 29 Oct 2019 16:01:06 +0530
Message-ID: <1572345066-101293-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, git@xilinx.com
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

Changes in v3:
	- Reverted "Replaced the deprecated calls to clock framework APIs"
	- Removed devm_clk_get() call which was added in v2

Changes in v4:
	- Made the Phase Delay properties Arasan specific

Manish Narani (8):
  mmc: sdhci-of-arasan: Separate out clk related data to another
    structure
  dt-bindings: mmc: arasan: Update Documentation for the input clock
  mmc: sdhci-of-arasan: Add sampling clock for a phy to use
  dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
  mmc: sdhci-of-arasan: Add support to set clock phase delays for SD
  firmware: xilinx: Add SDIO Tap Delay nodes
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |  41 +-
 drivers/mmc/host/sdhci-of-arasan.c            | 477 +++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h          |  13 +-
 3 files changed, 499 insertions(+), 32 deletions(-)

-- 
2.17.1
