From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] ARM: dts: change the compatible from exynos5250 to
 exynos3250
Date: Wed, 21 Oct 2015 15:39:15 +0900
Message-ID: <1445409555-1684-2-git-send-email-jh80.chung@samsung.com>
References: <1445409555-1684-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:36646 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbbJUGjX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 02:39:23 -0400
In-reply-to: <1445409555-1684-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kgene@kernel.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, Jaehoon Chung <jh80.chung@samsung.com>

To use more excatly, change compatible from exynos5250 to exynos3250.
Exynos3250 and exnos5250 are some difference.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 033def4..05ed242 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -333,7 +333,7 @@
 		};
 
 		mshc_0: mshc@12510000 {
-			compatible = "samsung,exynos5250-dw-mshc";
+			compatible = "samsung,exynos3250-dw-mshc";
 			reg = <0x12510000 0x1000>;
 			interrupts = <0 142 0>;
 			clocks = <&cmu CLK_SDMMC0>, <&cmu CLK_SCLK_MMC0>;
@@ -345,7 +345,7 @@
 		};
 
 		mshc_1: mshc@12520000 {
-			compatible = "samsung,exynos5250-dw-mshc";
+			compatible = "samsung,exynos3250-dw-mshc";
 			reg = <0x12520000 0x1000>;
 			interrupts = <0 143 0>;
 			clocks = <&cmu CLK_SDMMC1>, <&cmu CLK_SCLK_MMC1>;
-- 
1.9.1

