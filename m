From: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv5 0/6] Add support for UHS-I on Exynos5422 odroid boards
Date: Thu, 27 Sep 2018 14:07:32 +0000
Message-ID: <20180927140738.1006-1-linux.amoon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is series v4 since my previous patches were incomplete with driver
changes missing.

v5 changes.
drop the cd-gpios wp-gpio gpio pin setting, just add the pinctrl
configration to support write protect.

v4 changes.
squash cd-gpios and wp-gpio changes into single patch.
change the subject prefix to "ARM: dts: exynos:"

These changes add UHS-I tuning for dw_mmc-exynos driver.

Rebased on Krzysztof branch next/dt
[0] git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git 

Anand Moon (6):
  ARM: dts: exynos: Added UHS-I bus speed support
  ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
  ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
  ARM: dts: exynos: Add pin configuration for SD write protect on Odroid
    XU3/XU4
  ARM: dts: exynos: update maximum frequency for emmc to 200MHz
  mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode

 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  7 +++++++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++++--
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.17.1
