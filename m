From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH V3 0/2]exynos dwmmc device tree node
Date: Wed, 21 Aug 2013 19:08:31 +0530
Message-ID: <1377092313-2328-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kgene.kim@samsung.com
Cc: ks.giri@samsung.com, t.figa@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

These patches were V3 versions of below patches.
1.[PATCH 1/2] ARM: dts: remove dwmmc nodes from exynos5 common dts file.
	http://www.spinics.net/lists/linux-samsung-soc/msg21602.html
2.[PATCH 2/2] ARM: dts: Add dwmmc nodes in SOC specific dts file
	http://www.spinics.net/lists/linux-samsung-soc/msg21603.html 

changes from V2:
	1.remove from exynos5.dtsi and add in exynos5250.dtsi
	  in single patch.Suggested by Tomasz Figa.
	2.Separate patch for changing status property of dwmmc node
	  in smdk5250 and arndale board dts file.

Yuvaraj Kumar C D (2):
  ARM: dts: Move dwmmc nodes from exynos5.dtsi to exynos5250.dtsi
  ARM: dts: exynos: change status property of dwmmc nodes

 arch/arm/boot/dts/exynos5.dtsi            |   21 ---------------------
 arch/arm/boot/dts/exynos5250-arndale.dts  |   10 ++--------
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   10 ++--------
 arch/arm/boot/dts/exynos5250.dtsi         |   16 ++++++++++++++++
 4 files changed, 20 insertions(+), 37 deletions(-)

-- 
1.7.9.5
