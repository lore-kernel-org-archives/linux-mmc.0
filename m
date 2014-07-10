From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv3 0/5] ARM: remove the sub-node and deprecated
 supports-highspeed property for dwmmc.
Date: Thu, 10 Jul 2014 16:08:34 +0900
Message-ID: <1404976119-10777-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Since used the mmc_of_parse(), didn't parse the sub-node.
So we can remove the sub-node, because almost SoC used the only one card per a host.
And supports-highspeed can be replaced to "cap-mmc/sd-highspeed" property.

Changelog V3:
	- Fix the wrong bus-width value.
	- Use the slot->host->quirks instead of brq->quirks.
	- Add tested-by and reviewd-by.
Changelog V2:
	- Add the "mmc: dw_mmc: replace "disable-wp" from slot's quirks to host's quirk"

Jaehoon Chung (5):
  mmc: dw_mmc: modify the dt-binding for removing slot-node and
    supports-highspeed
  ARM: dts: exynos: unuse the slot-node and deprecated the
    supports-highspeed for dw-mmc
  ARM: dts: socfpga: unuse the slot-node and deprecated the
    supports-highspeed for dw-mmc
  ARM: dts: rockchip: unuse the slot-node and deprecated the
    supports-highspeed for dw-mmc
  mmc: dw_mmc: replace "disable-wp" from slot's quirk to host's quirk

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++---------
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    8 ++----
 arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++----
 arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++----
 arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++----------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   26 ++++++--------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++----------
 arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   18 ++++----------
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   18 ++++----------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 +++---------
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   16 +++---------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 +++---------
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   16 +++---------
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   16 +++---------
 arch/arm/boot/dts/socfpga_arria5.dtsi              |    9 +++----
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
 arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
 drivers/mmc/host/dw_mmc.c                          |   12 ++++-----
 21 files changed, 84 insertions(+), 204 deletions(-)

-- 
1.7.9.5
