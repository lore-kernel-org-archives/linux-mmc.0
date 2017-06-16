From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/16] omap_hsmmc: Add ADMA support and UHS/HS200/DDR support
Date: Fri, 16 Jun 2017 18:15:28 +0530
Message-ID: <20170616124544.15046-1-kishon@ti.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, kishon@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This is the final part of the series originally sent as
part of [2].

This series adds UHS, HS200, DDR mode and ADMA support to
omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
SoCs.

Changes from [2]:
*) No more updating omap2plus_defconfig or multi_v7_defconfig is
   required, so those patches are removed.
*) Addressed Rob Herring's comment on implementing a function
   instead of having a macro while getting pinctrl state.

This series is created on top of [3], [4], [5] AND [6]
(i.e after
  ARM: dts: omap3-overo: Remove "vqmmc-supply" property from MMC dt node
  omap_hsmmc: use mmc_regulator_get_supply() to get regulators
  omap*: Fixes/Cleanups for MMC devicetree node
  ARM: dts: Add iodelay data for MMC)

The functionality implemented in this series was sent before ([1]) but
was never followed up since supporting high speed modes in dra7 required
IODelay values to be configured. With IODelay driver being merged into
kernel, sending it as a fresh series with support for configuring IODelay
values.

Suggestions of migrating to sdhci driver (from omap_hsmmc driver) is not
addressed since
*) tuning ratio of MMC in dra7 is different from sdhci
*) IOdelay is required for dra7
*) GPIO based card detect is not supported in sdhci
*) Some of the registers don't always have correct values as in sdhci
   (like PSTATE).
Supporting all of these in sdhci will result in adding lot of quirks in
sdhci driver.

This series has been tested on beagleboard, pandaboard, beaglebone-black,
beaglebone, am335x-evm, am437x-evm, dra7xx-evm, dra72x-evm, am571x-idk
and am572x-idk.

I can split the series to go into Ulf Hansson's tree and Tony's tree
separately if that is required.

[1] -> https://lkml.org/lkml/2015/8/25/213
[2] -> https://lkml.org/lkml/2017/5/19/19

[3] -> https://lkml.org/lkml/2017/6/9/206
[4] -> https://lkml.org/lkml/2017/6/7/169
[5] -> https://www.spinics.net/lists/arm-kernel/msg586215.html /
       http://www.spinics.net/lists/devicetree/msg180747.html
[6] -> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1423381.html

Kishon Vijay Abraham I (15):
  mmc: host: omap_hsmmc: Support pbias and vmmc_aux to switch to 1.8v
  mmc: host: omap_hsmmc: Separate setting voltage capabilities from bus
    power
  mmc: host: omap_hsmmc: Remove incorrect voltage switch sequence
  mmc: host: omap_hsmmc: Add voltage switch support for UHS SD card
  mmc: host: omap_hsmmc: Set clk rate to the max frequency
  mmc: host: omap_hsmmc: Add tuning support
  mmc: host: omap_hsmmc: Allow io voltage switch even for fixed vdd
  mmc: host: omap_hsmmc: Prepare *set_timing() to be used for iodelay
    setting
  mmc: host: omap_hsmmc: Add new compatible string to support dra7
  mmc: host: omap_hsmmc: Fix error path sequence
  mmc: host: omap_hsmmc: Add support to set IODELAY values
  mmc: host: omap_hsmmc: Remove *use_dma* member
  mmc: host: omap_hsmmc: Enable ADMA2
  ARM: dts: dra7: Use new dra7-specific compatible string
  ARM: dts: dra7: Add supported MMC/SD modes in MMC dt nodes

Mugunthan V N (1):
  mmc: host: omap_hsmmc: Add software timer when timeout greater than
    hardware capablility

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    6 +
 arch/arm/boot/dts/am571x-idk.dts                   |    1 +
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts      |    1 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts            |    6 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |    1 +
 arch/arm/boot/dts/dra7.dtsi                        |   22 +-
 drivers/mmc/host/omap_hsmmc.c                      | 1179 ++++++++++++++++----
 include/linux/platform_data/hsmmc-omap.h           |    2 +
 8 files changed, 1021 insertions(+), 197 deletions(-)

-- 
2.11.0
