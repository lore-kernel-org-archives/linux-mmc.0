From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 00/15] mmc: sunxi: Support vqmmc regulator and eMMC DDR
 modes
Date: Thu, 21 Jan 2016 13:26:27 +0800
Message-ID: <1453354002-28366-1-git-send-email-wens@csie.org>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi everyone,

This series adds support for vqmmc regulator and eMMC DDR modes for
sunxi-mmc. Allwinner's MMC controller supports eMMC 4.41 on earlier
SoCs, and up to 5.0 on latest ones. UHS-1 modes are also supported
by the hardware, but these are not covered in this series, as no
boards have dedicated regulators for vqmmc.

To support these faster modes, these patches adds vqmmc regulator
support, which is used by the mmc core to switch to faster modes,
even if the signaling voltage is fixed. Signal voltage switching
support is also added, but not tested, as no available hardware has
a dedicated vqmmc regulator.

Support for eMMC reset in the controller, vs a GPIO and pwrseq, is
also added where applicable.

Patch 1 documents the mmc host init sequence. When the driver was
ported, this part was copied verbatim and not documented. With inline
comments from later SDKs and datasheet register definitions, this part
is now clearer.

Patch 2 makes the .set_ios callback return on errors from
mmc_regulator_set_ocr.

Patch 3 adds support (enabling/disable, and voltage control) for vqmmc
regulator to sunxi-mmc.

Patch 4 adds support signal voltage switch for the mmc controller. The
Allwinner MMC controller uses a special bit for sending signal voltage
switching command.

Patch 5 adds timing delays for MMC_DDR52 mode.

Patch 6 adds support for 8 bit eMMC DDR52 mode. Under this mode, the
controller must run at twice the card clock, and different timing delays
are needed.

Patch 7 enables eMMC HS-DDR for sunxi-mmc.

Patch 8 adds mmc3 pins for 8 bit emmc for A31/A31s.

Patch 9 switches from mmc2 to mmc3 for the onboard eMMC on Sinlinx
SinA31s. According to Allwinner, only mmc3 supports eMMC DDR52 on
A31/A31s.

Patch 10 adds the eMMC reset pin to the emmc pingroup for A23/A33.

Patch 11 enables eMMC hardware reset and eMMC DDR52 mode for SinA33.

Patch 12 switches A80 to sun9i specific mmc compatible. A80 has different
timing delays, and a larger FIFO (TODO).

Patch 13 adds the eMMC reset pin to the emmc pingroup for A80.

Patch 14 enables eMMC hardware reset and eMMC DDR52 mode for A80 Optimus.

Patch 15 enables eMMC hardware reset and eMMC DDR52 mode for Cubieboard4.

Chen-Yu Tsai (15):
  mmc: sunxi: Document host init sequence
  mmc: sunxi: Return error on mmc_regulator_set_ocr() fail in .set_ios
    op
  mmc: sunxi: Block signal voltage switching (CMD11)
  mmc: sunxi: Support vqmmc regulator
  mmc: sunxi: Support MMC_DDR52 timing modes
  mmc: sunxi: Support 8 bit eMMC DDR transfer modes
  mmc: sunxi: Enable eMMC HS-DDR (MMC_CAP_1_8V_DDR) support
  ARM: dts: sun6i: Add mmc3 pins for 8 bit emmc
  ARM: dts: sun6i: sina31s: Switch to mmc3 for onboard eMMC
  ARM: dts: sun8i: Include SDC2_RST pin in mmc2_8bit_pins
  ARM: dts: sun8i: sina33: Enable hardware reset and HS-DDR for eMMC
  ARM: dts: sun9i: Use sun9i specific mmc compatible
  ARM: dts: sun9i: Include SDC2_RST pin in mmc2_8bit_pins
  ARM: dts: sun9i: a80-optimus: Enable hardware reset and HS-DDR for
    eMMC
  ARM: dts: sun9i: cubieboard4: Enable hardware reset and HS-DDR for
    eMMC

 arch/arm/boot/dts/sun6i-a31.dtsi               | 10 +++
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi |  6 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi           |  2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts |  3 +
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts    |  6 ++
 arch/arm/boot/dts/sun9i-a80-optimus.dts        |  6 ++
 arch/arm/boot/dts/sun9i-a80.dtsi               | 11 +--
 drivers/mmc/host/sunxi-mmc.c                   | 98 +++++++++++++++++++++++---
 8 files changed, 126 insertions(+), 16 deletions(-)

-- 
2.7.0.rc3
