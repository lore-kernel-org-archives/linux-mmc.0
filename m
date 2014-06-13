From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv7 0/2] mmc: fixed the mmc_of_parse for dwmmc
Date: Fri, 13 Jun 2014 13:31:05 +0900
Message-ID: <1402633867-25155-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:19867 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbaFMEbL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jun 2014 00:31:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, "Heiko St.bner" <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

This patch-set is fixed the dw-mmc controller problem.
dw-mmc controller have the slot, but mmc_of_parse didn't parse the slot sub-node.
So dw-mmc controller didn't work correctly.

Changelog V7:
	- Remove the missing subnode.

Changelog V6:
	- Add the missing property.

Changelog V4/V5:
	- Drop "mmc: host: add slot argument to mmc_of_parse"
	- Drop "mmc: dw_mmc: remove the "supports-highspeed" property.
	- Rename patch's subject.
	- Remove the slot-node for dw-mmc controller.
Jaehoon Chung (2):
  mmc: dw_mmc: replace "disable-wp" from slot's quirk to host's quirk
  ARM: dts: unuse the slot-node and deprecated supports-highspeed for
    dw-mmc.

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   17 ++++--------
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   12 ++++-----
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   12 ++++-----
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    8 ++----
 arch/arm/boot/dts/exynos4412-origen.dts            |    8 ++----
 arch/arm/boot/dts/exynos4412-trats2.dts            |    8 ++----
 arch/arm/boot/dts/exynos5250-arndale.dts           |   18 ++++---------
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   28 ++++++--------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   18 ++++---------
 arch/arm/boot/dts/exynos5250-snow.dts              |    6 ++---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   16 +++--------
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   16 +++--------
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |   16 +++--------
 arch/arm/boot/dts/socfpga_arria5.dtsi              |   10 +++----
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    9 +++----
 arch/arm/boot/dts/socfpga_vt.dts                   |    9 +++----
 drivers/mmc/host/dw_mmc.c                          |   10 +++----
 17 files changed, 67 insertions(+), 154 deletions(-)

-- 
1.7.9.5

