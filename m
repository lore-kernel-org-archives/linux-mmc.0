From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] ARM: dts: use generic mmc properties for Samsung Exynos4210
 sdhci nodes
Date: Thu, 16 Aug 2012 22:30:29 +0530
Message-ID: <1345136429-21930-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39148 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633Ab2HPQoS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Aug 2012 12:44:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-mmc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

The SDHCI controller nodes in platforms which are based on Samsung's Exynos4210
SoC are using the older custom Samsung SDHCI bindings. Remove the old Samsung
specific bindings and use the generic mmc bindings that are defined for mmc
controllers.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts   |   10 ++++------
 arch/arm/boot/dts/exynos4210-smdkv310.dts |    5 ++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 0c49caa..5b5f389 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -30,10 +30,9 @@
 	};
 
 	sdhci@12530000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
+		bus-width = <4>;
 		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk2 2 2 3 3>;
+		cd-gpios = <&gpk2 2 2 3 3>;
 		gpios = <&gpk2 0 2 0 3>,
 			<&gpk2 1 2 0 3>,
 			<&gpk2 3 2 3 3>,
@@ -43,10 +42,9 @@
 	};
 
 	sdhci@12510000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
+		bus-width = <4>;
 		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk0 2 2 3 3>;
+		cd-gpios = <&gpk0 2 2 3 3>;
 		gpios = <&gpk0 0 2 0 3>,
 			<&gpk0 1 2 0 3>,
 			<&gpk0 3 2 3 3>,
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 1beccc8..f090095 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -30,10 +30,9 @@
 	};
 
 	sdhci@12530000 {
-		samsung,sdhci-bus-width = <4>;
-		linux,mmc_cap_4_bit_data;
+		bus-width = <4>;
 		samsung,sdhci-cd-internal;
-		gpio-cd = <&gpk2 2 2 3 3>;
+		cd-gpios = <&gpk2 2 2 3 3>;
 		gpios = <&gpk2 0 2 0 3>,
 			<&gpk2 1 2 0 3>,
 			<&gpk2 3 2 3 3>,
-- 
1.6.6.rc2

