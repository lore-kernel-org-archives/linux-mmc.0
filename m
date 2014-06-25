From: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
Subject: [PATCH] ARM: dts: update mmc node with hs-200 mode
Date: Wed, 25 Jun 2014 15:21:26 +0530
Message-ID: <1403689886-14573-1-git-send-email-yuvaraj.cd@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jh80.chung@samsung.com, cjb@laptop.org, tgih.jun@samsung.com, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, devicetree@vger.kernel.org
Cc: sonnyrao@chromium.org, t.figa@samsung.com, kgene.kim@samsung.com, joshi@samsung.com, ks.giri@samsung.com, prashanth.g@samsung.com, alim.akhtar@samsung.com, rahul.sharma@samsung.com, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch updates hs-200 device tree property from
caps2-mmc-hs200-1.8v to mmc-hs200-1.8v for peach-pit
and peach-pi boards.

Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 1cf9df0..056a6fa 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -186,7 +186,7 @@
 	status = "okay";
 	num-slots = <1>;
 	broken-cd;
-	caps2-mmc-hs200-1_8v;
+	mmc-hs200-1_8v;
 	supports-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 2c2c137..bb3ee76 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -171,7 +171,7 @@
 	status = "okay";
 	num-slots = <1>;
 	broken-cd;
-	caps2-mmc-hs200-1_8v;
+	mmc-hs200-1_8v;
 	supports-highspeed;
 	non-removable;
 	card-detect-delay = <200>;
-- 
1.7.10.4
