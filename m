From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 00/11] ARM: sun8i: a83t: Add support for MMC controllers
Date: Fri, 14 Jul 2017 14:42:51 +0800
Message-ID: <20170714064302.20383-1-wens@csie.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

This series adds support for the MMC controllers on the A83T. The A83T's
MMC controller adds what they call the "new timing mode". It moves the
MMC clock delay lines into the controller itself. There are some minor
changes to how the clock rate is calculated. The new mode give better
performance and stability for eMMC applications. This mode is only
found on the eMMC facing controller (or MMC2 on this chip).

This mode is also found on the A64, but on that chip, the controller
is fixed to that mode. On the A83t, the user is free to use the old
or new mode, but the new mode is recommended. There are two switches,
one in the clock controller, the other in the MMC controller, that
must be set in tandem.

The main part of this series adds custom functions to the sunxi-ng
clk driver, allowing the MMC driver to query and configure the mode.
The MMC driver can then support timing mode switching, and thus, the
MMC2 controller on the A83t.

The other bits are some related cleanups, and the usual device tree
changes.

The first patch, while largely unrelated, converts the raw clock
indices used in the A83t device tree to properly named macros. This
should be applied for 4.13, before any other device tree additions
that reference the CCU clocks. So it is included in this series.

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (11):
  ARM: dts: sun8i: a83t: Switch to CCU device tree binding macros
  clk: sunxi-ng: Add interface to query or configure MMC timing modes.
  clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
  mmc: sunxi: Keep default timing phase settings for new timing mode
  mmc: sunxi: Support controllers that can use both old and new timings
  mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
  mmc: sunxi: Add support for A83T eMMC (MMC2)
  ARM: dts: sun8i: a83t: Add MMC controller device nodes
  ARM: dts: sun8i: a83t: Add pingroup for 8-bit eMMC on mmc2
  ARM: dts: sun8i: a83t: cubietruck-plus: Enable micro-SD card and eMMC
  ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  1 +
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 21 ++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 27 +++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 82 ++++++++++++++++++++--
 drivers/clk/sunxi-ng/Makefile                      |  1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c              | 38 +++++++---
 drivers/clk/sunxi-ng/ccu_common.h                  |  2 +
 drivers/clk/sunxi-ng/ccu_mmc_timing.c              | 73 +++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c                       | 78 +++++++++++++++-----
 include/linux/clk/sunxi-ng.h                       | 20 ++++++
 10 files changed, 311 insertions(+), 32 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu_mmc_timing.c
 create mode 100644 include/linux/clk/sunxi-ng.h

-- 
2.13.2

