From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv3 0/7] Add support for UHS-I on Exynos5422 odroid boards
Date: Thu, 20 Sep 2018 17:58:19 +0000
Message-ID: <20180920175826.1284-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is series v3 since my previous patches we incomplete with driver
changes missing.

These changes add UHS-I tuning for dw_mmc-exynos driver.
Some new patches are added to enhance the performace.

Anand Moon (7):
  ARM: dts: exynos5422: Added UHS-I bus speed support
  ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid
    XU3/XU4
  ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
  ARM: dts: exynos5422: use cd-gpio method to detect sd-card
  ARM: dts: exynos5422: use wp-gpio method to detect sd-card
  ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
  mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 +++++++-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.17.1
