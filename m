From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 0/4] Add auto tuning support for ZynqMP SDHCI controller
Date: Tue, 18 Sep 2018 19:15:35 +0530
Message-ID: <1537278339-9257-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com, olof@lixom.net, amit.kucheria@linaro.org, rajanv@xilinx.com, jollys@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series of patches are created On top of the
below series of patches.
https://lkml.org/lkml/2018/8/3/687 

Manish Narani (4):
  firmware: xilinx: Add SD Node and DLL Reset Data APIs
  dt-bindings: mmc: arasan: Document 'xlnx,zynqmp-8.9a' controller
  mmc: sdhci-of-arasan: Add auto tuning support for ZynqMP platform
  arm64: zynqmp: Add new SDHCI compatible string

 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 14 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  6 +-
 drivers/mmc/host/sdhci-of-arasan.c                 | 83 ++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 12 ++++
 4 files changed, 113 insertions(+), 2 deletions(-)

-- 
2.1.1
