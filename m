From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/5] mmc: dw_mmc: minor code cleanup.
Date: Mon, 12 May 2014 20:14:11 +0900
Message-ID: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32992 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaELLOW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 07:14:22 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5G00BLMKJWQ9A0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 May 2014 20:14:20 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org, dinguyen@altera.com, Jaehoon Chung <jh80.chung@samsung.com>

Jaehoon Chung (5):
  mmc: dw_mmc: fix the wrong condition checking
  mmc: dw_mmc: remove the "supports-highspeed" property.
  mmc: dw_mmc-exynos: add the MMC_CAP_ERASE by default.
  mmc: dw_mmc: add the specified capbilities2 of controller.
  mmc: dw_mmc: use the mmc regulator API into core.c

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    1 -
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |    1 -
 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    3 -
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |    4 +-
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    4 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi              |    3 +-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    3 +-
 arch/arm/boot/dts/socfpga_vt.dts                   |    3 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |    9 +--
 drivers/mmc/host/dw_mmc.c                          |   69 ++++++++------------
 drivers/mmc/host/dw_mmc.h                          |    2 +
 17 files changed, 55 insertions(+), 67 deletions(-)

-- 
1.7.9.5

