From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv10 0/5] ARM: remove the sub-node and deprecate
 supports-highspeed property for dwmmc.
Date: Thu, 07 Aug 2014 16:37:57 +0900
Message-ID: <1407397082-32495-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Since used the mmc_of_parse(), didn't parse the sub-node.
So we can remove the sub-node, because almost SoC used the only one card per a host.
And supports-highspeed can be replaced with "cap-mmc/sd-highspeed" property.

Changelog V10:
	- Rebased for next.
	- Remove conflict
Changelog V9:
	- Fix typos.
	- Relocated the warning message.
	- Change patch's sequence.
Changelog V8:
	- Add the warning message to notice that slot-node was removed.
	(As Doug's suggestion)
Changelog V7:
	- Fixed typo and modified the commit message.
Changelog V6:
	- Fixed Wrong bit control for host's quirks and rename.
	- Add "Acked-by" for each SoC maintainers.
Changelog V5:
	- Rebased on v3.16-rc4.
	- Add Acked-by.
Changelog V4:
	- Fix the checkpatch error.
Changelog V3:
	- Fix the wrong bus-width value.
	- Use the slot->host->quirks instead of brq->quirks.
	- Add tested-by and reviewd-by.
Changelog V2:
	- Add the "mmc: dw_mmc: replace "disable-wp" from slot's quirks to host's quirk"

Jaehoon Chung (5):
  mmc: dw_mmc: Slot quirk "disable-wp" is deprecated.
  mmc: dw_mmc: modify the dt-binding for removing slot-node and
    supports-highspeed
  ARM: dts: exynos: unuse the slot-node and deprecate the
    supports-highspeed for dw-mmc
  ARM: dts: socfpga: unuse the slot-node and deprecate the
    supports-highspeed for dw-mmc
  ARM: dts: rockchip: unuse the slot-node and deprecate the
    supports-highspeed for dw-mmc

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++---------
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++------
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++------
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    8 ++-----
 arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++-----
 arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++-----
 arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++----------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   25 ++++++--------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++----------
 arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   18 ++++----------
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   18 ++++----------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 ++++---------
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   16 ++++---------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 ++++---------
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   16 ++++---------
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   15 ++++--------
 arch/arm/boot/dts/rk3188-radxarock.dts             |    7 ++----
 arch/arm/boot/dts/socfpga_arria5.dtsi              |    9 +++----
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
 arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
 drivers/mmc/host/dw_mmc.c                          |   11 +++++++--
 include/linux/mmc/dw_mmc.h                         |    2 ++
 23 files changed, 92 insertions(+), 202 deletions(-)

-- 
1.7.9.5
