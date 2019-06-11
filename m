From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 0/3] Add ZynqMP SD Clock Tap Delays configuration support
Date: Tue, 11 Jun 2019 15:26:48 +0530
Message-ID: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, rajan.vaja@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, manish.narani@xilinx.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch series adds support to configure SD tap delays on ZynqMP platforms
using Xilinx firmware driver and clock framework APIs.

Manish Narani (3):
  firmware: xilinx: Add SDIO Tap Delay API
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  32 ++++
 drivers/firmware/xilinx/zynqmp.c                   |  32 ++++
 drivers/mmc/host/sdhci-of-arasan.c                 | 173 ++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h               |  17 +-
 4 files changed, 252 insertions(+), 2 deletions(-)

-- 
2.1.1
