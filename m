From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/7] ARM: dts: MMC fixes for DRA7 based boards
Date: Thu, 30 Jul 2015 13:43:33 +0530
Message-ID: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Miscellaneous fixes in dts files for MMC device tree nodes.

Did basic read/write test in J6, J6 Eco and Beagle-x15

Balaji T K (1):
  ARM: dts: dra7-evm: add evm_3v3_sd regulator

Kishon Vijay Abraham I (5):
  ARM: dts: dra72-evm: add evm_3v3_sd regulator
  ARM: dts: dra72-evm: Set max clock frequency of MMC1 and MMC2
  ARM: dts: am57xx-beagle-x15: mmc1: remove redundant pbias-supply
    property
  ARM: dts: dra7-evm: Fix spurious card insert/removal interrupt
  ARM: dts: dra72-evm: Fix spurious card insert/removal interrupt

Nishanth Menon (1):
  ARM: dts: dra7-evm: Add MMCSD card removal GPIO

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 -
 arch/arm/boot/dts/dra7-evm.dts          |   18 +++++++++++++++++-
 arch/arm/boot/dts/dra72-evm.dts         |   16 ++++++++++++++--
 3 files changed, 31 insertions(+), 4 deletions(-)

-- 
1.7.9.5
