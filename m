From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv6 0/5] remove the sub-node and deprecated
Date: Fri, 25 Jul 2014 10:11:48 +0900
Message-ID: <1406250713-22604-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60288 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbaGYBL5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jul 2014 21:11:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, heiko@sntech.de, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

Since used the mmc_of_parse(), didn't parse the sub-node.
So we can remove the sub-node, because almost SoC used the only one card per a host.
And supports-highspeed can be replaced to "cap-mmc/sd-highspeed" property.

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
 include/linux/mmc/dw_mmc.h                         |    6 ++---
 22 files changed, 86 insertions(+), 208 deletions(-)

-- 
1.7.9.5

