From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2] ARM: dts: change the compatible from exynos5250 to
 exynos5420 for mshc
Date: Fri, 23 Oct 2015 11:01:53 +0900
Message-ID: <1445565713-4000-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34109 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824AbbJWCCA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 22:02:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kgene@kernel.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

Exynos3250 and exnos5250 are some differences in Mobile Storage Host.
(For example, exynos3250 support the HS400 mode, but exynos5250 doesn't
support it.)
Exynos3250 can perform the similar function with exynos5420 compatible.
So this patch changes the compatible from exynos5250 to exynos5420
for mshc.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog v2:
	- Drop "mmc: dw_mmc: exynos: Add the exynos3250 compatible" patch.
	- Describe commit-message more detailedly than before.
	- Change to exynos5420, not add new compatible (exynos3250).

 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 033def4..2f30d63 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -333,7 +333,7 @@
 		};
 
 		mshc_0: mshc@12510000 {
-			compatible = "samsung,exynos5250-dw-mshc";
+			compatible = "samsung,exynos5420-dw-mshc";
 			reg = <0x12510000 0x1000>;
 			interrupts = <0 142 0>;
 			clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
@@ -345,7 +345,7 @@
 		};
 
 		mshc_1: mshc@12520000 {
-			compatible = "samsung,exynos5250-dw-mshc";
+			compatible = "samsung,exynos5420-dw-mshc";
 			reg = <0x12520000 0x1000>;
 			interrupts = <0 143 0>;
 			clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
-- 
1.9.1

