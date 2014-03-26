From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 0/7] mmc: dw_mmc: update host driver including HS400 support
Date: Wed, 26 Mar 2014 20:30:49 +0900
Message-ID: <000001cf48e6$d662a260$8327e720$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:15199 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaCZLav (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Mar 2014 07:30:51 -0400
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>

This patch-set includes several driver's updates.
Specially, HS400 mode is enabled for eMMC5.0 spec.
And it goes with "[PATCH v4 5/5] mmc: add support for HS400 mode of eMMC5.0"

Changes in v2:
	(2/7) Reuse bus_hz for clock rate.
	(3/7) Fix typo.

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
 drivers/mmc/host/dw_mmc-exynos.c                   |  262 +++++++++++++-------
 drivers/mmc/host/dw_mmc-exynos.h                   |   70 ++++++
 drivers/mmc/host/dw_mmc.c                          |    7 +-
 13 files changed, 298 insertions(+), 141 deletions(-)
 create mode 100644 drivers/mmc/host/dw_mmc-exynos.h

Thanks,
sw-j

