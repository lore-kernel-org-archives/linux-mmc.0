From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v3 0/13] arm64: allwinner: a64: Enable MMC support
Date: Mon, 16 Jan 2017 17:56:50 +0100
Message-ID: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Here is a new attempt at getting the MMC controllers running, following the
work done by Andre.

This has been tested on a board with one SDIO device (a Marvell WiFi chip)
and a Kingston eMMC with 1.8V IOs.

For SDIO, the HS DDR mode works just fine. That serie also enables the
SDR104 mode to work on the devices that are capable of this.

For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
moment, but since it's significantly more complex, and at the same time
Allwinner recommends to limit its frequency to 100MHz, this doesn't have
any benefits. If there's any at some point, this can be added later.

Let me know what you think,
Maxime

Changes from v2:
  - Enabled SDR104, limited the frequency to 150MHz. 200MHz was too high.
  - Added more fixes to the gating and frequency rate change sequence
  - Added one more patch to mask DATA0 when updating the clock that was
    needed to get SDR104 to run
  - Added the patches to enable it on a few boards done by Andre
  - Amended the comments as suggested by Andre.
  - Added some tags

Andre Przywara (4):
  arm64: allwinner: a64: Add MMC nodes
  arm64: allwinner: pine64: add MMC support
  arm64: allwinner: a64: add UART1 pin nodes
  arm64: allwinner: add BananaPi-M64 support

Maxime Ripard (9):
  mmc: sunxi: Fix clock frequency change sequence
  mmc: sunxi: Gate the clock when rate is 0
  mmc: sunxi: Always set signal delay to 0 for A64
  mmc: sunxi: Enable the new timings for the A64 MMC controllers
  mmc: sunxi: Mask DATA0 when updating the clock
  mmc: sunxi: Add EMMC (MMC2) controller compatible
  mmc: sunxi: Add more debug messages
  arm64: allwinner: a64: Add MMC pinctrl nodes
  arm64: allwinner: a64: Increase the MMC max frequency

 arch/arm64/boot/dts/allwinner/Makefile                    |   1 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 120 +++++++-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       |  20 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi             |  77 ++++-
 drivers/mmc/host/sunxi-mmc.c                              | 101 +++---
 5 files changed, 278 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts

base-commit: bc34c1af0a280e27eafe3f86b9ad87fe0c9ea715
-- 
git-series 0.8.11
