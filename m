From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v5 0/2] mmc: dw_mmc: exynos: Add HS400 support
Date: Thu, 29 Jan 2015 08:11:56 +0530
Message-ID: <1422499318-13726-1-git-send-email-alim.akhtar@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48261 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760561AbbA2CuT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jan 2015 21:50:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@gmail.com, kgene@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, a.kesavan@samsung.com, alim.akhtar@samsung.com

This adds HS400 mode support for exynos dw_mmc host controller.

Currently tested on Exynos5800-peach-pi and Exyons7 platform for HS400 mode.
Tested HS200 mode with this series applied, HS200 still works.

Appreciate testing on other exynos5/7 platform which supports emmc5.0

Changes in V5:
	* Enable HS400 on Exynos5800-peach-pi boards
	* Addressed other review comments from Jaehoon Chung

Changes in V4:
	* drop the idea of changing existing binding for ciu_div as per [1]
        * addressed comments from Jaehoon Chung [2]

[1] http://www.spinics.net/lists/linux-samsung-soc/msg40923.html
[2] http://www.spinics.net/lists/devicetree/msg64373.html

Changes in V3:
	rebased on ulf's next (commit: 607b448 mmc: core: Make tuning block patterns static)

Seungwon Jeon (2):
  mmc: dw_mmc: exynos: Support eMMC's HS400 mode
  ARM: dts: Add HS400 support for exynos5420 and exynos5800

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    7 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    4 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    7 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  185 ++++++++++++++++----
 drivers/mmc/host/dw_mmc-exynos.h                   |   19 +-
 drivers/mmc/host/dw_mmc.c                          |   16 +-
 drivers/mmc/host/dw_mmc.h                          |    2 +
 9 files changed, 213 insertions(+), 38 deletions(-)

-- 
1.7.9.5

