From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/7] mmc: dw_mmc: update host driver including HS400 support
Date: Fri, 21 Mar 2014 23:02:44 +0900
Message-ID: <001a01cf450e$3b9bd200$b2d37600$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch-set includes several driver's updates.
Specially, HS400 mode is enabled for eMMC5.0 spec.

Seungwon Jeon (7):
  mmc: dw_mmc: fix the max_blk_count in IDMAC
  mmc: dw_mmc: exynos: don't use if clock isn't available
  mmc: dw_mmc: exynos: move definitions to header file
  mmc: dw_mmc: exynos: incorporate ciu_div into timing property
  mmc: dw_mmc: exynos: support eMMC's HS400 mode
  ARM: dts: drop dw-mshc-ciu-div property from Exynos
  ARM: dts: add HS400 support for Exynos5420

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   18 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    5 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    5 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |    5 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   10 +-
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |   15 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   10 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   10 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   15 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  267 +++++++++++++-------
 drivers/mmc/host/dw_mmc-exynos.h                   |   70 +++++
 drivers/mmc/host/dw_mmc.c                          |    7 +-
 13 files changed, 303 insertions(+), 141 deletions(-)
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.h

-- 
1.7.4.1
